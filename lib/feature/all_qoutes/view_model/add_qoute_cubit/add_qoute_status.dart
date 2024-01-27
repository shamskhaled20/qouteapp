abstract class AddQuoteState {
  const AddQuoteState();

  @override
  List<Object> get props => [];
}

class AddQuoteInitial extends AddQuoteState {}

class AddQuoteLoading extends AddQuoteState {}

class AddQuoteSuccess extends AddQuoteState {}

class AddQuoteFailure extends AddQuoteState {
  final String error;

  AddQuoteFailure({required this.error});

  @override
  List<Object> get props => [error];
}