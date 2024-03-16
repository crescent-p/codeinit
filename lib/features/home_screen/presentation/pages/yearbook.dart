import 'dart:io';
import 'package:codeinit/core/common/widgets/loader.dart';
import 'package:codeinit/core/utils/file_picker.dart';
import 'package:codeinit/core/utils/show_snackbar.dart';
import 'package:codeinit/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:codeinit/features/home_screen/data/models/yearbook_model.dart';
import 'package:codeinit/features/home_screen/presentation/bloc/main_page_bloc.dart';
import 'package:codeinit/features/home_screen/presentation/widgets/year_book_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class YearBookBar extends StatefulWidget {
  const YearBookBar({super.key});

  @override
  State<YearBookBar> createState() => _YearBookBarState();
}

class _YearBookBarState extends State<YearBookBar> {
  PlatformFile? file;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () async {
                      file = await filePicker();
                      if (file != null) {
                        showSnackBar(context, "File Selected Successfully!");
                      } else {
                        showSnackBar(context, 'No file selected!');
                      }
                    },
                    icon: const Icon(Icons.select_all)),
                IconButton(
                  onPressed: () async {
                    if (file != null) {
                      final ioFile = File(file!.path!);
                      context.read<MainPageBloc>().add(
                            UploadPdfEvent(
                              file: ioFile,
                              model: YearBookModel(
                                user_id: '',
                                id: '',
                                link: '',
                                name: file!.name,
                              ),
                            ),
                          );
                      showSnackBar(context, 'File Uploaded Successfully!');
                      await Future.delayed(const Duration(seconds: 2));
                      context.read<MainPageBloc>().add(GetYearBookEvent());
                    } else {
                      showSnackBar(context, "Please select a file to upload");
                    }
                  },
                  icon: const Icon(Icons.upload),
                ),
              ],
            ),
            BlocConsumer<MainPageBloc, MainPageState>(
              listener: (context, state) {
                if (state is BlogFailure) {
                  return showSnackBar(
                    context,
                    "Failed to Fetch Blog!",
                  );
                }
              },
              builder: (context, state) {
                if (state is MainPageLoading) {
                  return const LoadingIndicator();
                } else if (state is GetYearBookSuccess) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.yearBookModels.length,
                      itemBuilder: (context, index) {
                        return Tile(
                          title: state.yearBookModels[index].name,
                          link: state.yearBookModels[index].link,
                        );
                      });
                } else {
                  return const Text("NO CONTENT TO SHOW");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
