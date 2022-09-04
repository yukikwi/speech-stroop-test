import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/model/badge.dart';

showSimpleModalDialogBadge(context, String badgeId) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Badge(badgeId),
        );
      });
}

class Badge extends StatefulWidget {
  const Badge(this.badge, {Key key}) : super(key: key);
  final String badge;

  @override
  State<Badge> createState() => _BadgeState();
}

class _BadgeState extends State<Badge> with TickerProviderStateMixin {
  String badge;
  @override
  void initState() {
    badge = widget.badge;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 500),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Navigator.pop(context, false),
                icon: const Icon(
                  Icons.close,
                  color: Color(0xFF37265F),
                ),
                iconSize: 30,
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: (Column(
                children: [
                  Text(
                    'ยินดีด้วย! 🎉',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 32.0,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'คุณได้รับรางวัล',
                    style: TextStyle(
                      color: formText,
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ScaleTransition(
                    scale: CurvedAnimation(
                      parent: AnimationController(
                        duration: const Duration(seconds: 2),
                        vsync: this,
                      )..repeat(period: const Duration(seconds: 2)),
                      curve: Curves.fastLinearToSlowEaseIn,
                    ),
                    child: Image.asset(
                      badgesMap[badge].imgPath,
                      scale: 0.7,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    badgesMap[badge].name.split(' ')[0],
                    style: TextStyle(
                      color: formText,
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        badgesMap[badge].name.split(' ')[1],
                        style: TextStyle(
                          color: secondaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 32.0,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        badgesMap[badge].name.split(' ')[2],
                        style: TextStyle(
                          color: secondaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 32.0,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
