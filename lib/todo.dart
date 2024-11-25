import 'package:appwrite/models.dart';

class Task {


final String id;
final String name;
final String photo;
final bool isCompleted;
Task({required this.id, required this.name, required this.photo, required this.isCompleted});


factory Task.formDoument(Document doc){
  print(doc);
  return Task(id: doc.$id, name: doc.data['name'], photo: doc.data['photo'], isCompleted: doc.data['isComplete']);
}
}