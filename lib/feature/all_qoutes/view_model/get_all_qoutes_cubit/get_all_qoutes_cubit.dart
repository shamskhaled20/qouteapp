import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qoute/feature/all_qoutes/view_model/get_all_qoutes_cubit/get_all_qoutes_status.dart';

import '../../data/api_get_qoutes.dart';
class QoutesCubit extends Cubit<QouteState> {
  final ApiServiceQouteList apiService = ApiServiceQouteList();

  QoutesCubit() : super(QouteInitial());

  void fetchProducts() async {
    emit(QouteLoading());

    try {
      final qoutes = await apiService.getQoutes();
      emit(QouteLoaded(qoutes.quotes));
    } catch (e) {
      emit(QouteError("Failed to load products"));
    }
  }
}
