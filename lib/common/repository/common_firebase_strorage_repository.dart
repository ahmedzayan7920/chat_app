import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonFirebaseStorageRepositoryProvider = Provider(
  (ref) => CommonFirebaseStorageRepository(
    firebaseStorage: FirebaseStorage.instance,
  ),
);

class CommonFirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;

  CommonFirebaseStorageRepository({
    required this.firebaseStorage,
  });

  Future<String> storeFileToFirebase(
      {required String ref, required File file}) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    // uploadTask.snapshotEvents.listen((event) {
    //   print(((event.bytesTransferred.toDouble() / event.totalBytes.toDouble()) *100).roundToDouble());
    // });
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}