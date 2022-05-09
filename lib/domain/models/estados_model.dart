class Estados {
  String title, uid, information, link, fotoestado;
  String? id;

  Estados(
    {required this.uid,
    this.id,
    required this.title, 
    required this.information,
    required this.link,
    required this.fotoestado}
  );

  factory Estados.fromJson(Map<String, dynamic> map){
    final data = map["data"];
    return Estados(
      uid: data['uid'],
      id: data['id'],
      title: data['title'], 
      information: data['information'],
      link: data['link'],
      fotoestado: data['fotoestado']);
  }
  Map<String, dynamic> toJson(){
    return {
      "title": title,
      "uid": uid,
      "id": id,
      "information": information,
      "link": link,
      "fotoestado": fotoestado
    };
  }
}