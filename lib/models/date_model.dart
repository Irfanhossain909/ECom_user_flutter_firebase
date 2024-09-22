import 'package:cloud_firestore/cloud_firestore.dart';

class DateModel {
  int day;
  int month;
  int year;
  Timestamp timestamp;

  DateModel({
    required this.day,
    required this.month,
    required this.year,
    required this.timestamp,
  });
  Map<String, dynamic> toMap() {
    return {'day': day,
      'month': month,
      'year': year,
      'timestamp': timestamp,
    };
  }

  factory DateModel.fromMap(Map<String, dynamic> map) {
    return DateModel(
      day: map['day'] ?? 0,
      month: map['month'] ?? 0,
      year: map['year'] ?? 0,
      timestamp: map['timestamp'],
    );
  }
}