import 'package:detect_it/app/controllers/disease_ctl.dart';
import 'package:detect_it/library/detect_it.dart';
import 'package:detect_it/presentation/widgets/no_recent_scan.dart';
import 'package:detect_it/presentation/widgets/recent_scan.dart';

class UserScans extends GetView<DiseaseCtl> {
  const UserScans({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.userScans.value.isEmpty) {
        return const NoRecentScan();
      }

      return RecentScan(userScans: controller.userScans.value);
    });
  }
}
