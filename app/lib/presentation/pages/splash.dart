import 'package:detect_it/app/controllers/auth_ctl.dart';
import 'package:detect_it/library/detect_it.dart';

class SplashScreen extends GetView<AuthCtl> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Hero(
          tag: 'logo',
          child: Image.asset(
            Images.detect,
            height: 200,
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }
}
