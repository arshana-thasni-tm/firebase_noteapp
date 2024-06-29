class Note {
  int? id;
  String title;
  String content;
  String dateTimeEdited;
  String dateTimeCreated;
  bool isFavorite;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.dateTimeEdited,
    required this.dateTimeCreated,
    this.isFavorite = false,
  });

  // Factory constructor to create Note from database record
  factory Note.fromMap(Map<String, dynamic> json) => Note(
    id: json['id'],
    title: json['title'],
    content: json['content'],
    dateTimeEdited: json['dateTimeEdited'],
    dateTimeCreated: json['dateTimeCreated'],
    isFavorite: json['isFavorite'] == 1,
  );

  // Method to convert Note to database record
  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'content': content,
    'dateTimeEdited': dateTimeEdited,
    'dateTimeCreated': dateTimeCreated,
    'isFavorite': isFavorite ? 1 : 0,
  };
}
