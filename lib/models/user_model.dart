class UserModel {
  String? childFullName;
  String? email;
  String? gender;
  String? userId;
  String? age;
  String? image;

  UserModel({
    this.image,
    this.childFullName,
    this.email,
    this.age,
    this.gender,
    this.userId,
  });

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    childFullName = json['childFullName'];
    email = json['email'];
    age = json['age'];
    gender = json['gender'];
    userId = json['userId'];
    image = json['image'];
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
    };
  }

}
