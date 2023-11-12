class Note {
  int id;
  String title;
  String content;
  DateTime creationDate;
  int? colorId; 

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.creationDate,
    this.colorId,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'creationDate': creationDate.toIso8601String(),
      'colorId': colorId, // Include colorId in the map
    };
  }
}
