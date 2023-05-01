class UserModel {
  String? childFullName;
  String? email;
  String? gender;
  String? userId;
  String? age;
  String? image;
  bool? isAdmin;
  double? scorePercentage;


  UserModel({
    this.image,
    this.childFullName,
    this.email,
    this.age,
    this.gender,
    this.userId,
    this.isAdmin,
    this.scorePercentage,

  });

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    childFullName = json['childFullName'];
    email = json['email'];
    age = json['age'];
    gender = json['gender'];
    userId = json['userId'];
    image = json['image'];
    isAdmin = json['isAdmin'];
    scorePercentage = json['scorePercentage'];

  }


  Map<String,dynamic> toMap()
  {
    return {
      'childFullName':childFullName,
      'email':email,
      'age':age,
      'gender':gender,
      'userId':userId,
      'image':image,
      'isAdmin':isAdmin,
      'scorePercentage':scorePercentage,
    };
  }

}
