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
          data: {});
    } catch (e) {
      print(e);
    }
  }
}
