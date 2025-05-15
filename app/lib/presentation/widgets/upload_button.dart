import 'package:detect_it/app/controllers/disease_ctl.dart';
import 'package:detect_it/library/detect_it.dart';
import 'package:flutter_svg/svg.dart';

class UploadButton extends GetView<DiseaseCtl> {
  const UploadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text('Gallery'),
                      leading: Icon(Icons.image),
                      onTap: () async {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);

                        if (image?.path != null) {
                          Get.back(result: image);
                        }

                        controller.scanImage(image!);
                      },
                    ),
                    ListTile(
                      title: Text('Camera'),
                      leading: Icon(Icons.camera),
                      onTap: () async {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.camera);

                        if (image?.path != null) {
                          Get.back(result: image);
                        }

                        controller.scanImage(image!);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      tileColor: Color(0xFF0052EA),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(100),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SvgPicture.asset(
          SvgIcons.scan,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      title: const Text(
        'Upload an image to scan',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
