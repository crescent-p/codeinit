part of 'main_page_bloc.dart';

@immutable
sealed class MainPageState {}

final class MainPageInitial extends MainPageState {}

final class MainPageLoading extends MainPageState {}

final class UploadPdfSuccess extends MainPageState {
  final String url;

  UploadPdfSuccess({required this.url});
}

final class UploadFailure extends MainPageState {
  final String message;

  UploadFailure({required this.message});
}

final class GetYearBookSuccess extends MainPageState {
  final List<YearBook> yearBookModels;

  GetYearBookSuccess({required this.yearBookModels});
}

final class GetYearBookFailure extends MainPageState {
  final String message;

  GetYearBookFailure({required this.message});
}