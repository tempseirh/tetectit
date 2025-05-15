import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfilePicture extends StatelessWidget {
  final String? imageUrl;
  final double? radius;
  const ProfilePicture({
    super.key,
    required this.imageUrl,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return (imageUrl == '' || imageUrl == null || imageUrl == 'null')
        ? CircleAvatar(
            radius: radius ?? 60,
            backgroundColor: Color(0xFFFFD737),
            child: Icon(
              PhosphorIcons.user(PhosphorIconsStyle.thin),
              color: Colors.grey,
              size: radius == null ? 65 : radius! + 5.0,
            ),
          )
        : CachedNetworkImage(
            imageUrl: imageUrl!,
            filterQuality: FilterQuality.high,
            imageBuilder: (context, imageProvider) => CircleAvatar(
              radius: radius ?? 60,
              backgroundColor: Color(0xFFFFD737),
              backgroundImage: imageProvider,
            ),
            placeholder: (context, url) => CircleAvatar(
              radius: radius ?? 60,
              backgroundColor: Color(0xFFFFD737),
              child: const CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => CircleAvatar(
              radius: radius ?? 60,
              backgroundColor: Color(0xFFFFD737),
              child: Icon(
                PhosphorIcons.user(PhosphorIconsStyle.thin),
                color: Colors.white,
                size: radius == null ? 65 : radius! + 5.0,
              ),
            ),
          );
  }
}
