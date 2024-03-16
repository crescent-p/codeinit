import 'dart:io';
import 'package:codeinit/core/usecases/usecase.dart';
import 'package:codeinit/features/blog/domain/entities/blog.dart';
import 'package:codeinit/features/blog/domain/usecases/create_blog_usecase.dart';
import 'package:codeinit/features/blog/domain/usecases/get_all_blogs_usecase.dart';
import 'package:codeinit/features/blog/domain/usecases/get_personal_blogs_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final CreateBlogUseCase _createBlogUseCase;
  final GetAllBlogsUseCase _getAllBlogsUseCase;
  final GetPersonalBlogsUseCase _getPersonalBlogsUseCase;

  BlogBloc({
    required GetAllBlogsUseCase getAllBlogsUseCase,
    required CreateBlogUseCase createBlogUseCase,
    required GetPersonalBlogsUseCase getPersonalBlogsUseCase,
  })  : _createBlogUseCase = createBlogUseCase,
        _getAllBlogsUseCase = getAllBlogsUseCase,
        _getPersonalBlogsUseCase = getPersonalBlogsUseCase,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoading());
    });
    on<CreateBlogEvent>(_onCreateBlogEvent);
    on<GetAllBlogEvent>(_onGetAllBlogsEvent);
    on<GetPersonalBlogsEvent>(_onGetPersonalBlogsEvent);
  }
  void _onGetPersonalBlogsEvent(
      GetPersonalBlogsEvent event, Emitter<BlogState> emit) async {
    final res = await _getPersonalBlogsUseCase(event.name);
    res.fold(
      (l) => emit(BlogFailure(message: l.message)),
      (r) => emit(BlogLoadPersonalSuccess(blogs: r)),
    );
  }


  void _onGetAllBlogsEvent(
      GetAllBlogEvent event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogsUseCase(NoParams());
    res.fold(
      (l) => emit(BlogFailure(message: l.message)),
      (r) => emit(BlogLoadSuccess(blogs: r)),
    );
  }

  void _onCreateBlogEvent(
      CreateBlogEvent event, Emitter<BlogState> emit) async {
    final res = await _createBlogUseCase(Params(
      title: event.title,
      content: event.content,
      image: event.image,
      postId: event.postId,
      topics: event.topics,
    ));
    res.fold(
      (l) => emit(BlogFailure(message: l.message)),
      (r) => emit(BlogUploadSuccess(blog: r)),
    );
  }
}

class GetPersonalBlogEvent {
}
