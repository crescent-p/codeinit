import 'dart:io';

import 'package:codeinit/core/common/cubit/app_user_cubit.dart';
import 'package:codeinit/core/theme/colors.dart';
import 'package:codeinit/core/utils/image_picker.dart';
import 'package:codeinit/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:codeinit/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBlogPage extends StatefulWidget {
  AddBlogPage({super.key});
  final route = MaterialPageRoute(builder: (context) => AddBlogPage());

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  final headingTextController = TextEditingController();
  final contentTextController = TextEditingController();

  File? image;

  

  void selectImage() async {
    image = await pickImage();
    if (image != null) {
      setState(() {});
    }
  }

  List<String> selectedTopics = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final postId =
                  (context.read<AppUserCubit>().state as AppUserLoggedIn)
                      .user
                      .id;
              context.read<BlogBloc>().add(
                    CreateBlogEvent(
                      title: headingTextController.text,
                      content: contentTextController.text,
                      image: image!,
                      topics: selectedTopics,
                      postId: postId,
                    ),
                  );
            },
            icon: const Icon(Icons.done_all_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              image == null
                  ? DottedBorder(
                      color: AppPallete.borderColor,
                      dashPattern: const [20, 4],
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            selectImage();
                          },
                          child: const SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.folder),
                                Text("Add Image"),
                              ],
                            ),
                          ),
                        ),
                      ))
                  : GestureDetector(
                      onTap: () async {
                        selectImage();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          image!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    "Technology",
                    "Gaming",
                    "Science",
                    "Astrology",
                    "Health",
                    "Fashion",
                    "Sports",
                    "Travel"
                  ]
                      .map((e) => Padding(
                          padding: const EdgeInsets.all(16),
                          child: GestureDetector(
                              onTap: () {
                                if (selectedTopics.contains(e)) {
                                  selectedTopics.remove(e);
                                } else {
                                  selectedTopics.add(e);
                                }
                                setState(() {});
                              },
                              child: Chip(
                                  color: MaterialStateProperty.resolveWith(
                                      (states) => selectedTopics.contains(e)
                                          ? AppPallete.gradient1
                                          : AppPallete.backgroundColor),
                                  label: Text(e)))))
                      .toList(),
                ),
              ),
              BlogTextField(
                hintext: "Heading",
                controller: headingTextController,
              ),
              const SizedBox(
                height: 20,
              ),
              BlogTextField(
                hintext: "Content",
                controller: contentTextController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
