import 'package:detect_it/app/controllers/auth_ctl.dart';
import 'package:detect_it/app/models/scan_model.dart';
import 'package:detect_it/app/services/app_svc.dart';
import 'package:detect_it/library/detect_it.dart';
import 'package:detect_it/presentation/pages/views/disease_detail.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DiseaseCtl extends GetxController {
  final disease = Rx<ScanModel>(ScanModel.empty());
  final isLoading = Rx<bool>(false);
  final imageFile = Rx<XFile?>(null);
  final authCtl = Get.find<AuthCtl>();
  final userScans = Rx<List<ScanModel>>([]);

  @override
  void onInit() async {
    super.onInit();
    await fetchUserScans();
  }

  @override
  void onClose() {
    userScans.value = [];
    disease.value = ScanModel.empty();
    imageFile.value = null;
    isLoading.value = false;
    authCtl.user.value = null;
    super.onClose();
  }

  void setDisease(ScanModel value) {
    disease.value = value;
  }

  Future<void> scanImage(XFile image) async {
    isLoading.value = true;
    imageFile.value = image;

    Get.to(() => DiseaseDetail(imageFile: image));

    await getDiseaseDetails(image);
  }

  Future<void> getDiseaseDetails(XFile image) async {
    final result = await diseaseSvc.getDiagnosis(image);
    result.fold(
      (_) {
        EasyLoading.showError('Error getting disease details');
        logger.e('Error getting disease details');
        isLoading.value = false;
      },
      (disease) {
        setDisease(disease);
        isLoading.value = false;
      },
    );
  }

  Future<void> refreshDiseaseDetails() async {
    isLoading.value = true;
    if (disease.value != ScanModel.empty()) {
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
      return;
    }

    if (imageFile.value == null) {
      EasyLoading.showError('No image file selected');
      isLoading.value = false;
      return;
    }

    await getDiseaseDetails(imageFile.value!);
    isLoading.value = false;
  }

  Future<void> addScan() async {
    final userId = authCtl.user.value?.uid;

    if (userId == null || imageFile.value == null) {
      EasyLoading.showError('Session expired, please login again');
      return;
    }

    EasyLoading.showInfo(
      'Saving scan...',
      duration: const Duration(days: 1),
      dismissOnTap: false,
    );

    final imageUrl = await storageSvc.uploadImage(imageFile.value!);

    final result = await dbSvc.addUserScan(
      scan: disease.value.copyWith(imageUrl: imageUrl),
      userId: userId,
    );

    if (result.isLeft()) {
      EasyLoading.showError('Error saving scan');
      return;
    }

    await fetchUserScans();

    EasyLoading.showSuccess('Scan added successfully');
    Get.back();
  }

  Future<void> deleteScan(ScanModel? scan) async {
    if (scan == null) {
      return;
    }

    EasyLoading.showInfo('Deleting scan...');

    final result = await dbSvc.deleteUserScan(
      scanId: scan.id,
      userId: authCtl.user.value?.uid ?? '',
    );
    if (result.isLeft()) {
      EasyLoading.showError('Error deleting scan');
      return;
    }

    await fetchUserScans();

    EasyLoading.showSuccess('Scan deleted successfully');
    Get.back();
  }

  Future<void> fetchUserScans() async {
    final userId = Get.find<AuthCtl>().user.value?.uid;
    final result = await dbSvc.fetchUserScans(userId: userId);
    result.fold(
      (_) {
        userScans.value = [];
        logger.e('Error fetching user scans');
      },
      (scans) {
        // logger.i('scans: $scans');
        userScans.value = [];
        userScans.value = scans;
      },
    );
  }

  bool get isDisabled => isLoading.value || disease.value.confidence < 0.4;
}
