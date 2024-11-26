import 'package:appwrite/models.dart';

class Task {
  final String id;
  final String name;
  final String photo;
  final bool isComplete;
  Task(
      {required this.id,
      required this.name,
      required this.photo,
      required this.isComplete});

  factory Task.formDoument(Document doc) {
    print(doc);
    return Task(
        id: doc.$id,
        name: doc.data['name'],
        photo: doc.data['photo'],
        isComplete: doc.data['isComplete']);
  }
}
