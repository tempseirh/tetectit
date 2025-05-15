import 'package:detect_it/library/detect_it.dart';
import 'package:detect_it/presentation/widgets/profile_picture.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    this.imageUrl = AppConst.placeholderImageUrl,
    this.onPressed,
  });
  final String? imageUrl;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        padding: const EdgeInsets.all(1),
        child: ProfilePicture(
          imageUrl: imageUrl,
          radius: 25,
        ),
      ),
    );
  }
}
