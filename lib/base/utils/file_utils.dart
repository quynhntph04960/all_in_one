import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import 'common_function.dart';

class FileUtils {
  static final FileUtils _instance = FileUtils();

  static FileUtils get instance {
    return _instance;
  }

  /// chụp ảnh
  Future<XFile?> scanImagePicker() async {
    // String image64 = "";
    // ignore: deprecated_member_use
    return await ImagePicker().pickImage(source: ImageSource.camera);
    // if (pickedFile != null) {
    //   pickedFile.name
    //   return pickedFile.path;
    //   // image64 = convertImageBase64(_image);
    //   // print(image64);
    // } else {
    //   log('No image selected.');
    // }
    // return image64;
  }

  /// chọn ảnh
  static Future<List<PlatformFile>?> selectFilePicker({
    FileType type = FileType.any,
    bool isSelectedMultiple = false,
    List<String>? allowedExtensions,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: type,
      initialDirectory: "/*",
      allowMultiple: isSelectedMultiple,
      allowedExtensions: allowedExtensions,
    );
    if (result == null || isNullOrEmpty(result.files)) {
      return null;
    }
    return result.files;
    // final pathFile = result.files[0].path;
    // final nameFile = result.files[0].name;
    // String image64 = pathFile ?? "";
    // // String image64 = convertImageBase64(pathFile!);
    // // print(image64);
    // return image64;
  }
}
