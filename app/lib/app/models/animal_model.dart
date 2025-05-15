// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:detect_it/utils/packages.dart';
import 'package:equatable/equatable.dart';

class AnimalModel extends Equatable {
  final String id;
  final String imageUrl;
  final String disease;
  final double confidence;
  const AnimalModel({
    this.id = '',
    this.imageUrl = '',
    required this.disease,
    required this.confidence,
  });

  AnimalModel copyWith({
    String? id,
    String? imageUrl,
    String? disease,
    double? confidence,
  }) {
    return AnimalModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      disease: disease ?? this.disease,
      confidence: confidence ?? this.confidence,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imageUrl': imageUrl,
      'disease': disease,
      'confidence': confidence,
    };
  }

  factory AnimalModel.create({
    required String imageUrl,
    required String disease,
    required double confidence,
  }) {
    return AnimalModel(
      id: '',
      imageUrl: imageUrl,
      disease: disease,
      confidence: confidence,
    );
  }

  AnimalModel withId(String id) {
    return copyWith(id: id);
  }

  factory AnimalModel.fromMap(Map<String, dynamic> map) {
    return AnimalModel(
      id: map['id'] as String,
      imageUrl: map['imageUrl'] as String,
      disease: map['disease'] as String,
      confidence: map['confidence'] as double,
    );
  }

  factory AnimalModel.fromJsonResponse({
    required Map<String, dynamic> map,
    required String imageUrl,
  }) {
    final data = map['predictions'][0];

    return AnimalModel(
      id: map['inference_id'] as String,
      imageUrl: imageUrl,
      disease: data['class'] as String,
      confidence: data['confidence'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimalModel.fromJson(String source) =>
      AnimalModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, imageUrl, disease, confidence];

  factory AnimalModel.example() {
    return AnimalModel(
      id: '1',
      imageUrl: 'https://i.imgur.com/uzbuIxp.jpeg',
      disease: 'Example Disease',
      confidence: 0.99,
    );
  }

  static List<AnimalModel> get animalModelExamples {
    return [
      AnimalModel.example(),
      AnimalModel.example().copyWith(
          disease: 'Another Disease',
          confidence: 0.95,
          imageUrl: "https://i.imgur.com/lG0IGND.jpeg"),
      AnimalModel.example().copyWith(
          disease: 'Different Disease',
          confidence: 0.92,
          imageUrl: "https://i.imgur.com/46CNOxp.jpeg"),
      AnimalModel.example().copyWith(
          disease: 'New Disease',
          confidence: 0.85,
          imageUrl: "https://i.imgur.com/AeNZKGv.jpeg"),
      AnimalModel.example().copyWith(
          disease: 'Yet Another Disease',
          confidence: 0.80,
          imageUrl: "https://i.imgur.com/3vBzJls.jpeg"),
    ];
  }
}

extension AnimalModelExt on String {
  String get toDisease {
    return replaceAll('_', ' ').capitalize!;
  }
}

extension AnimalModelDoubleExt on double {
  String get confidence {
    return toStringAsFixed(2);
  }
}
