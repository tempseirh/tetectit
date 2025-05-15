import 'package:detect_it/app/controllers/auth_ctl.dart';
import 'package:detect_it/app/controllers/disease_ctl.dart';
import 'package:get/get.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthCtl(), permanent: true);
    Get.lazyPut(() => DiseaseCtl(), fenix: true);
  }
}
