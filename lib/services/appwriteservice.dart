import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class Appwriteservice {
  late Client client;
  late Databases databases;

  static const endpoint = "https://cloud.appwrite.io/v1";
  static const projectId = "674065a6003a2906a5c1";
  static const databaseId = "6740668d000629c46dea";
  static const collectionId = "6744605900173977bcfc";

  Appwriteservice() {
    client = Client();
    client.setEndpoint(endpoint);
    client.setProject(projectId);
    databases = Databases(client);
  }

  Future<void> addTask(
    _name,
    _photo,
  ) async {
    try {
      final documentId = ID.unique();
      final result = await databases.createDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: documentId,
          data: {"name": _name, "photo": _photo, "isComplete": false});
    } catch (e) {
      print(e);
    }
  }

  Future<List<Document>> getTask() async {
    try {
      final result = await databases.listDocuments(
          databaseId: databaseId, collectionId: collectionId);
      return result.documents;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Document> UpdateColor(String documentId, bool completed) async {
    try {
      final result = await databases.updateDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: documentId,
          data: {"isComplete": completed});
      return result;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> delete(documentId) async {
    try {
      final res = await databases.deleteDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: documentId);
    } catch (e) {
      print(e);
    }
  }
}
