class Note {
  late int id;
  late String content;

  Note({required this.content});

  Note.fromMap(Map<String, dynamic> data){
    this.id = data['id'];
    this.content = data['content'];
  }

  Map<String, dynamic> toMap(){
    return {'content' : content};
  }

}