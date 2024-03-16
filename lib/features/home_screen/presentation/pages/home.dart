import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class HomeBar extends StatefulWidget {
  const HomeBar({super.key});

  @override
  State<HomeBar> createState() => _HomeBarState();
}

class _HomeBarState extends State<HomeBar> {
  final List<String> titles = <String>[
    'NITC \n2022',
    'Looking \nBack',
    'Today',
  ];
  final List<Widget> images = <Widget>[
    ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        'https://images.pexels.com/photos/19808874/pexels-photo-19808874/free-photo-of-the-light.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        'https://images.pexels.com/photos/17815952/pexels-photo-17815952/free-photo-of-sun-hat-a-camera-and-a-bowl-of-blackberries-lying-on-a-white-picnic-blanket.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        fit: BoxFit.cover,
      ),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        'https://images.pexels.com/photos/16652251/pexels-photo-16652251/free-photo-of-woman-standing-with-camera-among-flowers.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
        fit: BoxFit.cover,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 800,
        width: 400,
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                //margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 800,
                width: double.infinity,
                child: VerticalCardPager(
                  titles: titles,
                  images: images,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
