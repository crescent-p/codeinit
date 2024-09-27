part of 'main_page_bloc.dart';

@immutable
sealed class MainPageEvent {}

final class UploadPdfEvent extends MainPageEvent {
  final File file;
  final YearBookModel model;

  UploadPdfEvent({required this.file, required this.model});
}

final class GetYearBookEvent extends MainPageEvent {
  GetYearBookEvent();
}