abstract class AdminStates{}
class AdminInitialState extends AdminStates{}
class UploadLoadingState extends AdminStates{}

class ProfilePickedSuccessState extends AdminStates{}
class ProfilePickedErrorState extends AdminStates{}


class SocialUploadProfileImageErrorState extends AdminStates{}
class SocialUploadProfileImageSuccessState extends AdminStates{}

//
class CreateCourseSuccessState extends AdminStates {
  final String nameOfCourse;
  CreateCourseSuccessState(this.nameOfCourse);
}
class CreateCourseErrorState extends AdminStates{
  final String error;
  CreateCourseErrorState(this.error);
}

//

class UpdateErrorState extends AdminStates{}
class UpdateSuccessState extends AdminStates{}
//
class AddUrlSuccessState extends AdminStates{}
class AddUrlErrorState extends AdminStates{}
//
//
class AddDescriptionSuccessState extends AdminStates{}
class AddDescriptionErrorState extends AdminStates{}
//

class UploadProfileImageErrorState extends AdminStates{}
class UploadProfileImageSuccessState extends AdminStates{}
////

class AddQuestionSuccessState extends AdminStates{}
class AddQuestionErrorState extends AdminStates{}
////////
class GetCoursesSuccessState extends AdminStates{}
class GetCoursesErrorStat extends AdminStates{
  final error;
  GetCoursesErrorStat(this.error);
}
//////////////////////////////////////
class GetUrlsSuccessState extends AdminStates{}
class GetUrlsErrorStat extends AdminStates {
  final error;

  GetUrlsErrorStat(this.error);


}
////////////////////////////////////
class GetDescriptionSuccessState extends AdminStates{}
class GetDescriptionErrorState extends AdminStates {
  final error;

  GetDescriptionErrorState(this.error);


}
////////////////////////////////////
class GetQuestionSuccessState extends AdminStates{}
class GetQuestionErrorState extends AdminStates {
  final error;

  GetQuestionErrorState(this.error);


}
//////////////////////////////////////
class ClearDone extends AdminStates{}