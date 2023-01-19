abstract class ChatStates{}

class ChatInitial extends ChatStates{}
class RegisterSuccessEmail extends ChatStates{}
class RegisterFailedEmail extends ChatStates{}
class SaveDataToFireStoreEmail extends ChatStates{}
class ErrorDataToFireStoreEmail extends ChatStates{}

class UsersSecured extends ChatStates{}
class SentAMessage extends ChatStates{}
class MessageSendingFailed extends ChatStates{}
class FailedToGetMessages extends ChatStates{}
class MessagesSecured extends ChatStates{}

class SuccessfullyStoredImage extends ChatStates{}
class FailedToStoreImage extends ChatStates{}

class FailedToLogin extends ChatStates{}
class LoginSuccessfully extends ChatStates{}

class FailedToLoadUsers extends ChatStates{}
class LoadUsersSuccessfully extends ChatStates{}