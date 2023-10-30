class Equipment{
  String id;
  String name;
  String description;
  String location;
  String state;
  String? urlImage;

  Equipment({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.state,
  });

  Equipment.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        description = map["description"],
        location = map["location"],
        state = map["state"],
        urlImage = map["urlImage"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "location": location,
      "state": state,
      "urlImage": urlImage,
    };
  }
}