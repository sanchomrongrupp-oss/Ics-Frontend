import 'package:equatable/equatable.dart';

// --- EVENTS ---
abstract class POrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddRowEvent extends POrderEvent {}

class UpdateFieldEvent extends POrderEvent {
  final int rowIndex;
  final int colIndex;
  final String newValue;
  UpdateFieldEvent(this.rowIndex, this.colIndex, this.newValue);

  @override
  List<Object> get props => [rowIndex, colIndex, newValue];
}

// --- STATE ---
class POrderState extends Equatable {
  final List<Map<String, dynamic>> items;
  const POrderState({this.items = const []});

  POrderState copyWith({List<Map<String, dynamic>>? items}) {
    return POrderState(items: items ?? this.items);
  }

  @override
  List<Object> get props => [items];
}
