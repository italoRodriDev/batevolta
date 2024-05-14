import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsService extends GetxService {
  requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.camera,
      Permission.photos
    ].request();

    if (statuses[Permission.notification.isPermanentlyDenied] != null) {
      openAppSettings();
    }

    if (statuses[Permission.notification.isPermanentlyDenied] != null) {
      openAppSettings();
    }
  }
}