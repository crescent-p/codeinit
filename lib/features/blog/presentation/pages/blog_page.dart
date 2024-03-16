// import 'package:codeinit/core/common/widgets/loader.dart';
// import 'package:codeinit/core/common/widgets/tile_card.dart';
// import 'package:codeinit/core/utils/show_snackbar.dart';
// import 'package:codeinit/features/blog/presentation/bloc/blog_bloc.dart';
// import 'package:codeinit/features/blog/presentation/pages/add_new_blog.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class BlogPage extends StatefulWidget {
//   BlogPage({super.key});
//   final route = MaterialPageRoute(builder: (context) => BlogPage());

//   @override
//   State<BlogPage> createState() => _BlogPageState();
// }

// class _BlogPageState extends State<BlogPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<BlogBloc>().add(GetAllBlogEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("This is a Blog page"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(context, AddBlogPage().route);
//               setState(() {});
//             },
//             icon: const Icon(CupertinoIcons.add_circled),
//           ),
//           IconButton(
//               onPressed: () {
//                 context.read<BlogBloc>().add(GetAllBlogEvent());
//                 setState(() {});
//               },
//               icon: const Icon(Icons.refresh))
//         ],
//       ),
//       body: BlocConsumer<BlogBloc, BlogState>(
//         listener: (context, state) {
//           if (state is BlogFailure) {
//             return showSnackBar(
//               context,
//               "Blog Failure: ${state.message}  ",
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is BlogLoading) {
//             return const LoadingIndicator();
//           } else if (state is BlogLoadSuccess) {
//             return Scrollbar(
//               child: ListView.builder(
//                   itemCount: state.blogs.length,
//                   itemBuilder: (context, index) {
//                     return BlogCard(state: state, index: index);
//                   }),
//             );
//           } else {
//             return const Text("NO CONTENT TO SHOW");
//           }
//         },
//       ),
//     );
//   }
// }
