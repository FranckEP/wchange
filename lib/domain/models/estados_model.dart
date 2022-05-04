class Estados {
  String title, uid, information, link;
  String? id;

  Estados(
    {required this.uid,
    this.id,
    required this.title, 
    required this.information,
    required this.link}
  );

  factory Estados.fromJson(Map<String, dynamic> map){
    final data = map["data"];
    return Estados(
      uid: data['uid'],
      id: data['id'],
      title: data['title'], 
      information: data['information'],
      link: data['link']);
  }
  Map<String, dynamic> toJson(){
    return {
      "title": title,
      "uid": uid,
      "id": id,
      "information": information,
      "link": link
    };
  }
}