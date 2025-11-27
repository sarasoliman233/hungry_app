class SideOptionsModel {


  int id;
  String name;
  String image;

  SideOptionsModel({
    required this.id,
    required this.name,
    required this.image
  });

  factory SideOptionsModel.fromJson(Map<String,dynamic> json) {
    return SideOptionsModel(
      id :json['id'],
      name : json['name'],
      image : json['image'],

    );
  }

}