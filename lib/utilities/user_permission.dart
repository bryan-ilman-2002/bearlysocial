import 'package:permission_handler/permission_handler.dart';

class UserPermission {
  static Future<bool> get cameraPermission async {
    var status = await Permission.camera.status;
    if (status.isGranted) return true;
    if (status.isDenied) return await Permission.camera.request().isGranted;
    return false;
  }
}
