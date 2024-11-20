import 'package:flutter/material.dart';

class SocialMediaSharingPopup extends StatefulWidget {
  const SocialMediaSharingPopup({super.key});

  @override
  State<SocialMediaSharingPopup> createState() => _SocialMediaSharingPopupState();
}

class _SocialMediaSharingPopupState extends State<SocialMediaSharingPopup> {

  // TODO: Add Social Media icons from other icon sources.
  final List<Map<String, dynamic>> socialMediaApps = [
    {'icon': Icons.link,'name': 'Copy Link', 'color': Colors.black12},
    {'icon': Icons.facebook, 'name': 'Facebook', 'color': Colors.blue},
    // {'icon': Icons.twitter, 'name': 'Twitter', 'color': Colors.lightBlue},
    // {'icon': Icons.instagram, 'name': 'Instagram', 'color': Colors.purple},
    // {'icon': Icons.whatsapp, 'name': 'WhatsApp', 'color': Colors.green},
    {'icon': Icons.telegram, 'name': 'Telegram', 'color': Colors.blueAccent},
    // {'icon': Icons.linkedin, 'name': 'LinkedIn', 'color': Colors.blue[700]},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Share',
                style: Theme.of(context).textTheme.bodyLarge
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Enables horizontal scrolling
                child: Row(
                  children: socialMediaApps.map((app) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  // Handle social media sharing action for this app
                                  print("Sharing to ${app['name']}");
                                },
                                icon: Icon(app['icon']),
                                color: app['color'],
                                iconSize: 40, // Adjust icon size as needed
                                tooltip: app['name'], // Shows the name on long press
                              ),
                              Text(
                                  app['name'],
                                  style: Theme.of(context).textTheme.bodySmall
                              )
                            ]
                        )

                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
