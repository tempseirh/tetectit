import 'package:detect_it/app/models/scan_model.dart';
import 'package:detect_it/library/detect_it.dart';

class DiseaseDetailsList extends StatelessWidget {
  const DiseaseDetailsList({
    super.key,
    required this.disease,
  });
  final ScanModel disease;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Scan Results',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                              text: disease.confidence.toPercentage,
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
                DiseaseDetailItem(
                  title: 'Disease Name',
                  value: disease.diseaseName,
                ),
                DiseaseDetailItem(
                  title: 'Symptoms',
                  value: disease.symptoms.join(', '),
                ),
                DiseaseDetailItem(
                  title: 'Medications',
                  value: disease.treatment.medications.join(', '),
                ),
                DiseaseDetailItem(
                  title: 'Recommended Actions',
                  value: disease.treatment.recommendedActions.join(', '),
                ),
                DiseaseDetailItem(
                  title: 'Precautions',
                  value: disease.treatment.precautions.join(', '),
                ),
                DiseaseDetailItem(
                  title: 'Additional Notes',
                  value: disease.additionalNotes ?? '',
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DiseaseDetailItem extends StatelessWidget {
  const DiseaseDetailItem({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0.2,
      shadowColor: Colors.grey.shade200,
      borderOnForeground: false,
      child: ListTile(
        title: Text(title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF64748B),
            )),
        subtitle: Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF9DA4AE),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }
}

extension DoubleExtension on double {
  String get toPercentage {
    return '${(this * 100).toInt()}%';
  }
}
