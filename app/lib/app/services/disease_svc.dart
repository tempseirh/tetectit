import 'package:dartz/dartz.dart';
import 'package:detect_it/app/models/scan_model.dart';
import 'package:detect_it/app/services/app_svc.dart';
import 'package:detect_it/consts/const.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class DiseaseSvc {
  Future<Either<void, ScanModel>> getDiagnosis(XFile image) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        image.path,
        contentType: MediaType('image', 'jpeg'),
      ),
    });

    try {
      final res = await httpSvc.post(
        url: AppConst.apiBaseUrl,
        data: formData,
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      );

      final data = res as Map<String, dynamic>;

      return Right(ScanModel.fromMap(data));
    } catch (e) {
      logger.e(e);
      return Left(null);
    }
  }
}
