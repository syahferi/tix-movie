part of 'shared.dart';

Future<XFile?> getImage() async {
  final imagePicker = ImagePicker();
  final image = await imagePicker.pickImage(source: ImageSource.gallery);
  return image;
}

Future<String> uploadImage(XFile xFile) async {
  String fileName = basename(xFile.path);
  late firebaseStorage.TaskSnapshot snapshot;

  firebaseStorage.Reference ref =
      firebaseStorage.FirebaseStorage.instance.ref().child(fileName);
  firebaseStorage.UploadTask task = ref.putFile(File(xFile.path));
  await task.whenComplete(() => snapshot = task.snapshot);

  return await snapshot.ref.getDownloadURL();
}
