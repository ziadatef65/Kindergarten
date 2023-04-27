class CourseModel
{
  String? nameOfCourse;
  String?  image;
  List? urls;
  List? description;
  List? questions;




  CourseModel({
    this.nameOfCourse,
    this.image,
    this.urls,
    this.description,
    this.questions,

  });


  CourseModel.fromJson(Map<dynamic,dynamic> json)
  {

    nameOfCourse = json['nameOfCourse'];
    image= json['image'];
    urls= json['urls'];
    description= json['description'];
    questions= json['questions'];


  }

  Map<String,dynamic> toMap()
  {
    return{
      'nameOfCourse':nameOfCourse,

      'image':image,
      'urls':urls,
      'description':description,
      'questions':questions,


    };
  }


}