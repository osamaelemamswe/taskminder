import 'package:equatable/equatable.dart';

class Task extends Equatable {
  Task({
    required this.id,
    required this.title,
    this.description,
    this.deadLine,
    this.isFavorite,
    this.isCompleted,
  }) {
    deadLine = deadLine ?? '';
    description = description ?? '';
    isFavorite = isFavorite ?? false;
    isCompleted = isCompleted ?? false;
  }

  Task copyWith({
    int? id,
    String? title,
    String? description,
    String? deadLine,
    bool? isFavorite,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      deadLine: deadLine ?? this.deadLine,
      isFavorite: isFavorite ?? this.isFavorite,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'deadLine': deadLine,
      'isFavorite': isFavorite,
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'],
      deadLine: map['deadLine'],
      isFavorite: map['isFavorite'],
      isCompleted: map['isCompleted'],
    );
  }

  final int id;
  final String title;
  String? description;
  String? deadLine;
  bool? isFavorite;
  bool? isCompleted;

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    deadLine,
    isFavorite,
    isCompleted,
  ];
}
