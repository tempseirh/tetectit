import 'package:detect_it/library/detect_it.dart';

class PopularDiseases extends StatelessWidget {
  const PopularDiseases({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CarouselView(
        itemExtent: 200,
        padding: EdgeInsets.zero,
        children: const [
          DiseaseCard(),
          DiseaseCard(),
          DiseaseCard(),
        ],
      ),
    );
  }
}
