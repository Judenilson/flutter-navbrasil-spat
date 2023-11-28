class Sector {
  String id;
  String name;
  String locate;

  Sector({
    required this.id,
    required this.name,
    required this.locate,
  });

  Sector.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        locate = map['locate'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'locate': locate,
    };
  }
}
