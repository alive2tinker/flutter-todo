class Category{
  String name, description;
  int id;

  categoryMap(){
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;

    return map;
  }
}