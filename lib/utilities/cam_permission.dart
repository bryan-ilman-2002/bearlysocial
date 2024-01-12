import 'package:permission_handler/permission_handler.dart';

Future<bool> get cameraPermission async {
  var status = await Permission.camera.status;

  if (status.isDenied) {
    if (await Permission.camera.request().isGranted) {
      return true;
    } else {
      return false;
    }
  } else if (status.isGranted) {
    return true;
  } else {
    return false;
  }
}
