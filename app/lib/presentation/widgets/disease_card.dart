import 'package:detect_it/library/detect_it.dart';

class DiseaseCard extends StatelessWidget {
  const DiseaseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[100],
      margin: const EdgeInsets.all(8.0),
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: NetworkImage('https://i.imgur.com/uzbuIxp.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
