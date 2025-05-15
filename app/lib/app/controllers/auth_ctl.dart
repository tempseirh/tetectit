import 'package:detect_it/app/controllers/disease_ctl.dart';
import 'package:detect_it/app/services/auth_svc.dart';
import 'package:detect_it/app/services/db_svc.dart';
import 'package:detect_it/library/detect_it.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

/// Authentication controller
class AuthCtl extends GetxController {
  final authSvc = AuthSvc();
  final dbSvc = DatabaseService();
  final user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    autoLogin();
  }

  Future<void> autoLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    await getCurrentUser();

    if (user.value != null) {
      await Get.find<DiseaseCtl>().fetchUserScans();
      Get.offAllNamed(RouteNames.homeScreen);
    } else {
      Get.offAllNamed(RouteNames.welcomeScreen);
    }
  }

  Future<void> signInWithGoogle() async {
    final user = await authSvc.signInWithGoogle();
    if (user != null) {
      this.user.value = user;
      Get.offAllNamed(RouteNames.homeScreen);
    } else {
      this.user.value = null;
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    final res = await authSvc.signInWithEmailAndPassword(email, password);
    if (res != null) {
      user.value = res;
      Get.offAllNamed(RouteNames.homeScreen);
    } else {
      EasyLoading.showError('Invalid email or password');
    }
  }

  Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    final res = await authSvc.signUpWithEmailAndPassword(email, password);
    if (res != null) {
      await dbSvc.addNewUser(
        userId: res.uid,
        name: name,
      );

      user.value = res;
      Get.offAllNamed(RouteNames.homeScreen);
    }
  }

  Future<void> signOut() async {
    await authSvc.signOut();
    user.value = null;
    Get.offAllNamed(RouteNames.welcomeScreen);
    Get.find<DiseaseCtl>().dispose();
    // Get.put(DiseaseCtl(), permanent: true);
    // Get.find<AuthCtl>().dispose();
    // Get.put(AuthCtl(), permanent: true);
  }

  Future<void> getCurrentUser() async {
    final user = await authSvc.getCurrentUser();
    this.user.value = user;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await authSvc.sendPasswordResetEmail(email);
  }
}
