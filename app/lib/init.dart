import 'package:detect_it/app/bindings/auth_bind.dart';
import 'package:detect_it/library/detect_it.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:themed/themed.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Themed(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConst.appName,
        themeMode: ThemeMode.light,
        theme: ThemeData(
          primaryColor: Color(0xFF0052EA),
        ),
        darkTheme: ThemeData(
          primaryColor: Color(0xFF0052EA),
        ),
        initialRoute: RouteNames.splashScreen,
        getPages: router,
        initialBinding: AuthBinding(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..maskType = EasyLoadingMaskType.none
    ..userInteractions = false
    ..animationDuration = const Duration(milliseconds: 300)
    ..dismissOnTap = false
    ..toastPosition = EasyLoadingToastPosition.bottom;
}
