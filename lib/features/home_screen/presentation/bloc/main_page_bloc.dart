import 'dart:io';
import 'package:codeinit/core/usecases/usecase.dart';
import 'package:codeinit/features/home_screen/data/models/yearbook_model.dart';
import 'package:codeinit/features/home_screen/domain/entities/yearbook.dart';
import 'package:codeinit/features/home_screen/domain/usecases/get_year_book.dart';
import 'package:codeinit/features/home_screen/domain/usecases/upload_pdf.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_page_event.dart';
part 'main_page_state.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final UploadPdfUseCase _uploadPdfUseCase;
  final GetYearBookUseCase _getYearBookUseCase;

  MainPageBloc(
      {required UploadPdfUseCase uploadPdfUseCase,
      required GetYearBookUseCase getYearBookUseCase})
      : _uploadPdfUseCase = uploadPdfUseCase,
        _getYearBookUseCase = getYearBookUseCase,
        super(MainPageInitial()) {
    on<MainPageEvent>((event, emit) {
      emit(MainPageLoading());
    });
    on<UploadPdfEvent>(_onUploadPdfEvent);
    on<GetYearBookEvent>(_onGetYearBookEvent);
  }
  void _onGetYearBookEvent(
      GetYearBookEvent event, Emitter<MainPageState> emit) async {
    final res = await _getYearBookUseCase(NoParams());
    res.fold((l) => emit(GetYearBookFailure(message: l.message)),
        (r) => emit(GetYearBookSuccess(yearBookModels: r)));
  }

  void _onUploadPdfEvent(
      UploadPdfEvent event, Emitter<MainPageState> emit) async {
    final res = await _uploadPdfUseCase(
        UploadPdfParams(title: event.model, file: event.file));

    res.fold(
      (l) => emit(UploadFailure(message: l.message)),
      (r) => emit(UploadPdfSuccess(url: r)),
    );
  }
}
