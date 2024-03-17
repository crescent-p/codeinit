import 'package:codeinit/core/common/widgets/tile_card.dart';
import 'package:codeinit/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:codeinit/features/home_screen/presentation/widgets/blog_card_foreign.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBarMine extends StatefulWidget {
  const SearchBarMine({super.key});

  @override
  State<SearchBarMine> createState() => _SearchBarMineState();
}

class _SearchBarMineState extends State<SearchBarMine> {
  final searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(GetAllBlogEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            context.read<BlogBloc>().add(GetAllBlogEvent());
          });
        },
        child: const Icon(Icons.refresh),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchBar(
              controller: searchController,
              hintText: 'Search for a user',
              onSubmitted: (text) {
                print(text);
                context.read<BlogBloc>().add(
                      GetPersonalBlogsEvent(name: text.trim()),
                    );
              },
            ),
            BlocBuilder<BlogBloc, BlogState>(
              builder: (context, state) {
                if (state is BlogLoading) {
                  return const CircularProgressIndicator();
                } else if (state is BlogLoadPersonalSuccess) {
                  return SingleChildScrollView(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.blogs.length,
                      itemBuilder: (context, index) {
                        return BlogCardForeign(
                          state: state,
                          index: index,
                        );
                      },
                    ),
                  );
                } else if (state is BlogFailure) {
                  return Text(state.message);
                } else if (state is BlogLoadSuccess) {
                  return SingleChildScrollView(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.blogs.length,
                      itemBuilder: (context, index) {
                        return BlogCard(
                          state: state,
                          index: index,
                        );
                      },
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
