class UserModel{

final String name;
final String email;
final String? address;
final String? image;
final String? token;
final String? visa;

  UserModel({
   required this.name,
    required this.email,
    this.address,
    this.image,
    this.token,
    this.visa});


  factory UserModel.fromJson(Map<String,dynamic>json){
    return UserModel(
        name: json["name"]?? "",
        email: json["email"]?? "",
        address: json["address"]?? "",
        image: json["image"]?? "",
        token: json["token"]?? "",
        visa: json["Visa"]?? ""


    );
  }
}