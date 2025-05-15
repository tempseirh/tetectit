import 'package:detect_it/app/controllers/auth_ctl.dart';
import 'package:detect_it/library/detect_it.dart';
import 'package:detect_it/presentation/widgets/profile_picture.dart';

class ProfileScreen extends GetView<AuthCtl> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            Center(
              child: ProfilePicture(
                imageUrl: controller.user.value?.photoURL ?? '',
              ),
            ),
            Text(controller.user.value?.email ?? ''),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                controller.signOut();
              },
              child: const Text(
                'Sign Out',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
