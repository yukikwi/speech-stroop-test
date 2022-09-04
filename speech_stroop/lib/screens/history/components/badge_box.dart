import 'package:flutter/material.dart';
import 'package:speech_stroop/constants.dart';
import 'package:speech_stroop/model/badge.dart';
import 'package:speech_stroop/model/user.dart';

class BadgeBox extends StatefulWidget {
  const BadgeBox(this.title, this.type, {Key key}) : super(key: key);
  final String title;
  final String type;
  @override
  BadgeBoxState createState() => BadgeBoxState();
}

class BadgeBoxState extends State<BadgeBox> {
  final formGlobalKey = GlobalKey<FormState>();
  List<Badge> defaultBadges = [];
  List<Badge> userBadges = [];

  @override
  void initState() {
    defaultBadges = getBadgeListByType(widget.type).reversed.toList();

    userBadges = getUserBadgeByType(userProfile.badge, widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        decoration: BoxDecoration(
            color: softPrimaryColor, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.title,
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      .apply(color: Color(0xFF464D59)),
                ),
                const Spacer(),
                Text("${userBadges.length}/6",
                    textAlign: TextAlign.right,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        .apply(color: secondaryColor)),
              ],
            ),
            Divider(
              color: primaryColor.withOpacity(0.3),
              height: 25,
              thickness: 1,
            ),
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: badgesMap != null
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0;
                                i < defaultBadges.sublist(0, 3).length;
                                i++)
                              userBadges
                                      .contains(defaultBadges.sublist(0, 3)[i])
                                  ? Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Image.asset(
                                        defaultBadges.sublist(0, 3)[i].imgPath,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Image.asset(
                                          defaultBadges
                                              .sublist(0, 3)[i]
                                              .imgPath,
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                          color: Colors.white.withOpacity(0.2),
                                          colorBlendMode: BlendMode.modulate),
                                    ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0;
                                i < defaultBadges.sublist(3, 6).length;
                                i++)
                              userBadges
                                      .contains(defaultBadges.sublist(3, 6)[i])
                                  ? Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Image.asset(
                                        defaultBadges.sublist(3, 6)[i].imgPath,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Image.asset(
                                          defaultBadges
                                              .sublist(3, 6)[i]
                                              .imgPath,
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                          color: Colors.white.withOpacity(0.2),
                                          colorBlendMode: BlendMode.modulate),
                                    ),
                          ],
                        ),
                      ],
                    )
                  : null,
            ),
          ],
        ));
  }

  List<Badge> getUserBadgeByType(List<String> badges, String type) {
    List<Badge> filteredBadge = [];
    filteredBadge = badges
        .where((b) => badgesMap[b].type == type)
        .toList()
        .map((b) => badgesMap[b])
        .toList();
    return filteredBadge;
  }
}
