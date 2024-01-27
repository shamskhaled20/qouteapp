import '../../data/model_qoute.dart';

abstract class QouteState {}

class QouteInitial extends QouteState {
  @override
  List<Object?> get props => [];
}

class QouteLoading extends QouteState {
  @override
  List<Object?> get props => [];
}
class QouteLoaded extends QouteState {
  final List<Quote> quotes;

  QouteLoaded(this.quotes);

  @override
  List<Object> get props => [quotes];
}

class QouteError extends QouteState {
  final String errorMessage;

  QouteError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
