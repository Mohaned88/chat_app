import 'dart:io';
import 'package:chat_app/models/msg_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import 'chat_states.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of<ChatCubit>(context);

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FacebookAuth facebookAuth = FacebookAuth.instance;

  ImagePicker imagePicker = ImagePicker();
  UserModel registerUser = UserModel();
  UserModel friend = UserModel();
  XFile? userImage;
  GoogleSignIn? googleSignIn = GoogleSignIn();
  FacebookLogin facebookLogin = FacebookLogin();

  List allMessages = [];
  Map<String, MsgModel> lastUserMessage = {};
  ScrollController scrollController = ScrollController();
  List users = [];
  MsgModel msgModel = MsgModel();
  MsgModel newMsgModel = MsgModel();

  images({required String camera}) async {
    if (camera == "cam") {
      userImage = await imagePicker.pickImage(source: ImageSource.camera);
      try {
        await firebaseStorage
            .ref()
            .child("photos/")
            .child("${registerUser.id}.png")
            .putFile(File(userImage!.path));
        emit(SuccessfullyStoredImage());
      } catch (e) {
        print('error : $e');
        emit(FailedToStoreImage());
      }

      return userImage!.readAsBytes();
    } else {
      userImage = await imagePicker.pickImage(source: ImageSource.gallery);
      return userImage!.readAsBytes();
    }
  }

  registerByEmailAndPassword(String email, String password, String name) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSuccessEmail());
      try {
        registerUser.name = name;
        registerUser.email = email;
        registerUser.password = password;
        registerUser.id = credential.user!.uid;
        await firebaseStorage
            .ref()
            .child("photos/")
            .child("${registerUser.id}.png")
            .putFile(File(userImage!.path));
        registerUser.photo = await firebaseStorage
            .ref()
            .child("photos/")
            .child("${registerUser.id}.png")
            .getDownloadURL();
        await firebaseFirestore
            .collection('users')
            .doc(registerUser.id)
            .set(registerUser.toJson());
        emit(SaveDataToFireStoreEmail());
      } catch (e2) {
        emit(ErrorDataToFireStoreEmail());
      }
    } catch (e) {
      emit(RegisterFailedEmail());
    }
  }

  signInByGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn!.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      var user = await auth.signInWithCredential(authCredential);
      emit(RegisterSuccessEmail());
      try {
        registerUser.id = user.user!.uid;
        registerUser.name = googleSignInAccount.displayName;
        registerUser.email = googleSignInAccount.email;
        registerUser.photo = googleSignInAccount.photoUrl;
        await firebaseFirestore
            .collection('users')
            .doc(registerUser.id)
            .set(registerUser.toJson());
        //getMessage();
        getUsers();
        emit(SaveDataToFireStoreEmail());
      } catch (e2) {
        emit(ErrorDataToFireStoreEmail());
      }
    } catch (e) {
      emit(RegisterFailedEmail());
    }
  }

  signInWithFacebook() async {
    try {
      FacebookLoginResult result =
          await facebookLogin.logIn(customPermissions: ['email']);
      OAuthCredential faceCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      UserCredential credential =
          await auth.signInWithCredential(faceCredential);
      emit(RegisterSuccessEmail());
      try {
        registerUser.id = credential.user!.uid;
        registerUser.name = credential.user!.displayName;
        registerUser.email = credential.user!.email;
        registerUser.photo = credential.user!.photoURL;
        await firebaseFirestore
            .collection('users')
            .doc(registerUser.id)
            .set(registerUser.toJson());
        getUsers();
        emit(SaveDataToFireStoreEmail());
      } catch (e2) {
        emit(ErrorDataToFireStoreEmail());
      }
    } catch (e) {
      emit(RegisterFailedEmail());
    }
  }

  login(String email, String password) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      DocumentSnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
          .collection('users')
          .doc(credential.user!.uid)
          .get();
      registerUser = UserModel.fromJson(snapshot.data());
      emit(LoginSuccessfully());
    } catch (e) {
      emit(FailedToLogin());
    }
    getUsers();
    emit(UsersSecured());
  }

  sentMessage(String message, UserModel receiver, int index) async {
    MsgModel msgModel = MsgModel(
      msgText: message,
      senderId: registerUser.id,
      receiverId: receiver.id,
      msgId: "${registerUser.id}",
      dateTime: DateTime.now().toString(),
      incoming: false,
    );

    try {
      await firebaseFirestore
          .collection('chat')
          .doc(registerUser.id)
          .collection('${receiver.id}')
          .doc()
          .set(msgModel.toJson());
      await firebaseFirestore
          .collection('chat')
          .doc(receiver.id)
          .collection('${registerUser.id}')
          .doc()
          .set(msgModel.toJson());
/*    var groupId = '';
    List idSortList = [registerUser.id, receiver.id];
    idSortList.sort();
    print(idSortList);
    groupId = idSortList.join();
    print(groupId);
    await firebaseFirestore
        .collection('groupChats')
        .doc(groupId)
        .collection('chat')
        .doc()
        .set(msgModel.toJson());
    //await firebaseFirestore.collection(groupId).doc().set(msgModel.toJson());*/
      emit(SentAMessage());
    } catch (e) {
      emit(MessageSendingFailed());
    }
  }

  getMessagesStream(UserModel userFriend) {
/*    var groupId = '';
    List idSortList = [registerUser.id, userFriend.id];
    idSortList.sort();
    print(idSortList);
    groupId = idSortList.join();
    print(groupId);*/
    try {
      var messages = firebaseFirestore
          .collection('chat')
          .doc(userFriend.id)
          .collection('${registerUser.id}')
          .orderBy('dateTime');
      //  var messages2 = firebaseFirestore.collection('groupChats').doc(groupId).collection('chat').orderBy('dateTime');
      return messages;
    } catch (e) {
      emit(FailedToGetMessages());
    }
  }

  /* getMessage()async{
    var fireStoreMsg = await firebaseFirestore.collection('chat').where('msgId',isEqualTo: "${registerUser.id}").orderBy("dateTime").get();
    fireStoreMsg.docs.forEach((element) {
      allMessages.add(MsgModel.fromJson(element.data()));
    });
    //allMessages.add(MsgModel.fromJson(fireStoreMsg.data()));
  }*/

  getUsers() async {
    try {
      var fireStoreUsers = await firebaseFirestore
          .collection('users')
          .where('id', isNotEqualTo: registerUser.id)
          .get();
      fireStoreUsers.docs.forEach((element) {
        users.add(
          UserModel.fromJson(element.data()),
        );
      });
      emit(LoadUsersSuccessfully());
    } catch (e) {
      emit(FailedToLoadUsers());
    }
  }
}
