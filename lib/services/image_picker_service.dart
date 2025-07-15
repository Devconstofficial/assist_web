import 'package:firebase_storage/firebase_storage.dart';

class ImagePickerService {
  ImagePickerService._();

  static final ImagePickerService _instance = ImagePickerService._();

  factory ImagePickerService() {
    return _instance;
  }

  Future<dynamic> uploadImageToFirebase(dynamic imageBytes) async {
    try {
      String filePath =
          'chat_images/${DateTime.now().millisecondsSinceEpoch}.png';

      UploadTask uploadTask;

      uploadTask = FirebaseStorage.instance.ref(filePath).putData(imageBytes);

      // Wait for the upload to complete
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL after the upload is complete
      String downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      return false;
    }
  }
}
