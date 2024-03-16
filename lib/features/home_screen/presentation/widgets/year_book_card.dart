import 'package:codeinit/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Tile extends StatelessWidget {
  final String title;
  final String link;

  const Tile({Key? key, required this.title, required this.link})
      : super(key: key);

  Future<void> _launchURL() async {
    await launch(link);
    if (await canLaunch(link)) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppPallete.greyColor,
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.all(16),
        height: 100,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 8, width: double.infinity, child: Container()),
            Text(
              title,
              maxLines: 1,
            ),
            TextButton(
              onPressed: _launchURL,
              child: const Text(
                'Open Link',
                style: TextStyle(color: Colors.blue),
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
