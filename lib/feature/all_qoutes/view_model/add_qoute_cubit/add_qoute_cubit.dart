import 'package:bloc/bloc.dart';

import '../../data/api_add_qoute.dart';
import 'add_qoute_status.dart';

class AddQuoteCubit extends Cubit<AddQuoteState> {
  final ApiServiceAddQuoteList apiService;

  AddQuoteCubit({required this.apiService}) : super(AddQuoteInitial());

  Future<void> addQuote(String quote, String author) async {
    emit(AddQuoteLoading());

    try {
      await apiService.addQuote(quote, author);
      emit(AddQuoteSuccess());
    } on Exception catch (e) {
      emit(AddQuoteFailure(error: e.toString()));
    }
  }
}