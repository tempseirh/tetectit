import 'package:detect_it/app/services/auth_svc.dart';
import 'package:detect_it/app/services/db_svc.dart';
import 'package:detect_it/app/services/disease_svc.dart';
import 'package:detect_it/app/services/http_svc.dart';
import 'package:detect_it/app/services/storage_svc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/web.dart';

final dbSvc = DatabaseService();
final httpSvc = HttpService();
final diseaseSvc = DiseaseSvc();
final storageSvc = StorageSvc();
final logger = Logger(printer: PrettyPrinter());
final loader = EasyLoading;
final authSvc = AuthSvc();
