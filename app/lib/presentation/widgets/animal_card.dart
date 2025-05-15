import 'package:detect_it/app/models/animal_model.dart';
import 'package:detect_it/library/detect_it.dart';

class AnimalCard extends StatelessWidget {
  const AnimalCard({super.key, required this.disease});

  final AnimalModel disease;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
          image: DecorationImage(
            image: NetworkImage(disease.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        height: 250,
        child: Center(
          child: Text(disease.disease),
        ),
      ),
    );
  }
}
