import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:detect_it/app/models/scan_model.dart';
import 'package:detect_it/app/services/app_svc.dart';
import 'package:detect_it/consts/const.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  // final _db = FirebaseFirestore.instance;

  Future<Either<String, ScanModel>> addUserScan({
    required ScanModel scan,
    required String userId,
  }) async {
    try {
      final newDocRef =
          FirebaseFirestore.instance.collection(DbCollections.scans.name).doc();

      await newDocRef.set({
        ...scan.toMap(),
        'id': newDocRef.id,
        'userId': userId,
      });

      await FirebaseFirestore.instance
          .collection(DbCollections.users.name)
          .doc(userId)
          .set({
        'scans': FieldValue.arrayUnion([newDocRef.id])
      }, SetOptions(merge: true));

      return Right(scan);
    } on FirebaseException catch (e) {
      return Left('Error while adding scan to Firestore: ${e.message}');
    } catch (e) {
      return Left('Error: ${e.toString()}');
    }
  }

  Future<Either<String, void>> deleteUserScan({
    required String scanId,
    required String userId,
  }) async {
    userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    if (userId.isEmpty) {
      return Left('User not found');
    }

    try {
      await FirebaseFirestore.instance
          .collection(DbCollections.users.name)
          .doc(userId)
          .update({
        'scans': FieldValue.arrayRemove([scanId])
      });

      await FirebaseFirestore.instance
          .collection(DbCollections.scans.name)
          .doc(scanId)
          .delete();

      return Right(null);
    } on FirebaseException {
      return Left('Error while deleting scan from Firestore');
    } catch (e) {
      return Left('Error: ${e.toString()}');
    }
  }

  Future<Either<String, List<ScanModel>>> fetchUserScans({
    String? userId,
  }) async {
    try {
      userId = FirebaseAuth.instance.currentUser?.uid;

      logger.i('Fetching scans for user: $userId');

      if (userId == null) {
        return Left('User not found');
      }

      final snapshot = await FirebaseFirestore.instance
          .collection(DbCollections.users.name)
          .doc(userId)
          .get();

      logger.i('Snapshot: ${snapshot.data()}');

      if (!snapshot.exists) {
        return Left('User not found');
      }

      final scanIds = snapshot.data()?['scans'];

      final scans = await FirebaseFirestore.instance
          .collection(DbCollections.scans.name)
          .where('id', whereIn: scanIds)
          .get();

      return Right(
        scans.docs.map((doc) => ScanModel.fromMap(doc.data())).toList(),
      );
    } on FirebaseException {
      return Left('Error while fetching user scans');
    } catch (e) {
      return Left('Error: ${e.toString()}');
    }
  }

  Future<Either<String, void>> addNewUser({
    required String userId,
    required String name,
  }) async {
    userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    if (userId.isEmpty) {
      return Left('User not found');
    }

    try {
      await FirebaseFirestore.instance
          .collection(DbCollections.scans.name)
          .doc(userId)
          .set({
        'name': name,
      });
      return Right(null);
    } on FirebaseException catch (e) {
      return Left('Error while adding new user to Firestore: ${e.message}');
    } catch (e) {
      return Left('Error: ${e.toString()}');
    }
  }
}
