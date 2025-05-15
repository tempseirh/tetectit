// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ScanModel {
  final String id;
  final String diseaseName;
  final double confidence;
  final List<String> symptoms;
  final String severity;
  final TreatmentModel treatment;
  final String? additionalNotes;
  final String imageUrl;
  ScanModel({
    required this.id,
    required this.diseaseName,
    required this.confidence,
    required this.symptoms,
    required this.severity,
    required this.treatment,
    required this.additionalNotes,
    this.imageUrl = '',
  });

  ScanModel copyWith({
    String? id,
    String? diseaseName,
    double? confidence,
    List<String>? symptoms,
    String? severity,
    TreatmentModel? treatment,
    String? additionalNotes,
    String? imageUrl,
  }) {
    return ScanModel(
      id: id ?? this.id,
      diseaseName: diseaseName ?? this.diseaseName,
      confidence: confidence ?? this.confidence,
      symptoms: symptoms ?? this.symptoms,
      severity: severity ?? this.severity,
      treatment: treatment ?? this.treatment,
      additionalNotes: additionalNotes ?? this.additionalNotes,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'diseaseName': diseaseName,
      'confidence': confidence,
      'symptoms': symptoms,
      'severity': severity,
      'treatment': treatment.toMap(),
      'additionalNotes': additionalNotes,
      'imageUrl': imageUrl,
    };
  }

  factory ScanModel.fromMap(Map<String, dynamic> map) {
    return ScanModel(
      id: map['id'] != null ? map['id'] as String : '',
      diseaseName:
          map['diseaseName'] != null ? map['diseaseName'] as String : '',
      confidence: map['confidence'] != null
          ? double.tryParse(map['confidence'].toString()) ?? 0
          : 0,
      symptoms:
          map['symptoms'] != null ? List<String>.from((map['symptoms'])) : [],
      severity: map['severity'] != null ? map['severity'] as String : '',
      treatment: map['treatment'] != null
          ? TreatmentModel.fromMap(map['treatment'] as Map<String, dynamic>)
          : TreatmentModel.empty(),
      additionalNotes: map['additionalNotes'] != null
          ? map['additionalNotes'] as String
          : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ScanModel.fromJson(String source) =>
      ScanModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ScanModel(id: $id, diseaseName: $diseaseName, confidence: $confidence, symptoms: $symptoms, severity: $severity, treatment: $treatment, additionalNotes: $additionalNotes, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(covariant ScanModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.diseaseName == diseaseName &&
        other.confidence == confidence &&
        listEquals(other.symptoms, symptoms) &&
        other.severity == severity &&
        other.treatment == treatment &&
        other.additionalNotes == additionalNotes &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        diseaseName.hashCode ^
        confidence.hashCode ^
        symptoms.hashCode ^
        severity.hashCode ^
        treatment.hashCode ^
        additionalNotes.hashCode ^
        imageUrl.hashCode;
  }

  factory ScanModel.empty() {
    return ScanModel(
      id: '',
      diseaseName: '',
      confidence: 0,
      symptoms: [],
      severity: '',
      treatment: TreatmentModel.empty(),
      additionalNotes: '',
      imageUrl: '',
    );
  }
}

class TreatmentModel extends Equatable {
  final List<String> recommendedActions;
  final List<String> medications;
  final List<String> precautions;
  final bool veterinaryConsultation;
  const TreatmentModel({
    required this.recommendedActions,
    required this.medications,
    required this.precautions,
    required this.veterinaryConsultation,
  });

  TreatmentModel copyWith({
    List<String>? recommendedActions,
    List<String>? medications,
    List<String>? precautions,
    bool? veterinaryConsultation,
  }) {
    return TreatmentModel(
      recommendedActions: recommendedActions ?? this.recommendedActions,
      medications: medications ?? this.medications,
      precautions: precautions ?? this.precautions,
      veterinaryConsultation:
          veterinaryConsultation ?? this.veterinaryConsultation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'recommendedActions': recommendedActions,
      'medications': medications,
      'precautions': precautions,
      'veterinaryConsultation': veterinaryConsultation,
    };
  }

  factory TreatmentModel.fromMap(Map<String, dynamic> map) {
    return TreatmentModel(
      recommendedActions: List<String>.from((map['recommendedActions'])),
      medications: List<String>.from((map['medications'])),
      precautions: List<String>.from((map['precautions'])),
      veterinaryConsultation: map['veterinaryConsultation'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory TreatmentModel.fromJson(String source) =>
      TreatmentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props =>
      [recommendedActions, medications, precautions, veterinaryConsultation];

  factory TreatmentModel.empty() {
    return TreatmentModel(
      recommendedActions: [],
      medications: [],
      precautions: [],
      veterinaryConsultation: false,
    );
  }
}
