abstract class KindergartenStates{}
class KindergartenInitialState extends KindergartenStates{}

//
class ChangeBottomNavState extends KindergartenStates{}
class OnPageChanged extends KindergartenStates{}
//

//
class GetUserLoadingState extends KindergartenStates{}
class GetUserSuccessState extends KindergartenStates{}
class GetUserErrorState extends KindergartenStates{
  final String error;

  GetUserErrorState(this.error);
}
//

//
class ProfileImagePickedSuccessState extends KindergartenStates{}
class ProfileImagePickedErrorState extends KindergartenStates{}
//

//
class UploadProfileImageSuccessState extends KindergartenStates{}
class UploadProfileImageErrorState extends KindergartenStates{}
//

//
class UserUpdateError extends KindergartenStates{}
class UserUpdateLoading extends KindergartenStates{}
//

//
class ContainerOfVideoOpen extends KindergartenStates{}
//