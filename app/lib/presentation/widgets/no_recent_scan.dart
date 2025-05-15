import 'package:detect_it/library/detect_it.dart';

class NoRecentScan extends StatelessWidget {
  const NoRecentScan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'No recent scan',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Scan an animal to get started',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF9DA4AE),
            ),
          ),
        ],
      ),
    );
  }
}
