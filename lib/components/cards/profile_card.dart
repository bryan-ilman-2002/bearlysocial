import 'package:bearlysocial/components/buttons/splash_btn.dart';
import 'package:bearlysocial/constants/design_tokens.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final List<String> interests;
  final double rating;
  final String location;

  const ProfileCard({
    super.key,
    required this.name,
    required this.interests,
    required this.rating,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return SplashButton(
      callbackFunction: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (ctx, p, q) => SizedBox(),
            transitionsBuilder: (ctx, animation, _, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      },
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).dividerColor,
              ),
            ),
            // Replace with your photo widget
            child: Center(
              child: Icon(
                Icons.no_photography_rounded,
                size: 24,
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(interests[0]),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('4.2'),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.location_pin,
                      size: 20,
                      color: AppColor.heavyRed,
                    ),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        location,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
