import 'package:cached_network_image/cached_network_image.dart';
import 'package:detect_it/app/models/scan_model.dart';
import 'package:detect_it/library/detect_it.dart';
import 'package:detect_it/presentation/pages/views/disease_detail.dart';
import 'package:detect_it/presentation/widgets/disease_details_list.dart';

class RecentScan extends StatelessWidget {
  const RecentScan({super.key, required this.userScans});
  final List<ScanModel> userScans;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: CarouselView(
        itemExtent: userScans.length > 1 ? 200 : 350,
        onTap: (value) {
          final scan = userScans[value];
          Get.to(
            () => DiseaseDetail(
              scan: scan,
              isScan: false,
            ),
          );
        },
        children: userScans.map((scan) {
          return ScanItem(scan: scan);
        }).toList(),
      ),
    );
  }
}

class ScanItem extends StatelessWidget {
  const ScanItem({
    super.key,
    required this.scan,
  });
  final ScanModel scan;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: scan.id,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(scan.imageUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.black.withAlpha(100),
                child: Column(
                  children: [
                    Text(
                      scan.diseaseName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Chip(
                      label: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Accuracy: ',
                              style: TextStyle(
                                color: Color(0xFF334155),
                              ),
                            ),
                            TextSpan(
                              text: scan.confidence.toPercentage,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF15803D),
                              ),
                            ),
                          ],
                        ),
                      ),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Color(0xFFDCFCE7),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
