import 'package:codeinit/features/home_screen/presentation/bloc/main_page_bloc.dart';
import 'package:codeinit/features/home_screen/presentation/pages/home.dart';
import 'package:codeinit/features/home_screen/presentation/pages/profile.dart';
import 'package:codeinit/features/home_screen/presentation/pages/search.dart';
import 'package:codeinit/features/home_screen/presentation/pages/yearbook.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static route() => MaterialPageRoute(builder: (context) => const HomeScreen());
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<MainPageBloc>().add(GetYearBookEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: _currentIndex,
            children: const [
              HomeBar(),
              YearBookBar(),
              SearchBarMine(),
              ProfileScreen(),
            ],
          ),
        ),
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Home"),
              selectedColor: Colors.purple,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: const Icon(Icons.book_online_outlined),
              title: const Text("YearBook"),
              selectedColor: Colors.pink,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: const Icon(Icons.search),
              title: const Text("Search"),
              selectedColor: Colors.orange,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: const Icon(Icons.person),
              title: const Text("Profile"),
              selectedColor: Colors.teal,
            ),
          ],
        ));
  }
}
