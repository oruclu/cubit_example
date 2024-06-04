class PostModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostModel(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory PostModel.fromMap(Map<String, dynamic> map) => PostModel(
        userId: map['userId'],
        id: map['id'],
        title: map['title'],
        body: map['body'],
      );

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
      };
}
