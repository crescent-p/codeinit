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
  Widget build(BuildContext context) {
    return Scaffold(
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
