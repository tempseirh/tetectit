import 'package:detect_it/app/controllers/auth_ctl.dart';
import 'package:detect_it/library/detect_it.dart';
import 'package:detect_it/presentation/pages/views/scans.dart';
import 'package:detect_it/presentation/widgets/quick_tips.dart';
import 'package:detect_it/presentation/widgets/upload_button.dart';

class HomeScreen extends GetView<AuthCtl> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text('Good ${DateTime.now().dayPeriod},'),
          subtitle: Text(
            FirebaseAuth.instance.currentUser?.displayName ?? 'User',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          ProfileButton(
            imageUrl: FirebaseAuth.instance.currentUser?.photoURL,
            onPressed: () {
              Get.toNamed(RouteNames.profileScreen);
            },
          )
        ],
        actionsPadding: const EdgeInsets.only(right: 10),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          spacing: 30,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox.shrink(),
            const UploadButton(),
            const QuickTips(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recent Scan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                UserScans(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  String get dayPeriod {
    final hour = this.hour;
    if (hour < 12) return 'morning';
    if (hour < 17) return 'afternoon';
    return 'evening';
  }
}
