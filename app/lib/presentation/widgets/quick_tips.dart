import 'package:detect_it/library/detect_it.dart';
import 'package:flutter_svg/svg.dart';

class QuickTips extends StatelessWidget {
  const QuickTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              'Quick Tips',
              style: TextStyle(
                color: Color(0xFF15803D),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(SvgIcons.sun),
            title: Text(
              'Take photos in natural daylight for best results',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(SvgIcons.capture),
            title: Text(
              'Capture clear, close-up images of affected areas',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
