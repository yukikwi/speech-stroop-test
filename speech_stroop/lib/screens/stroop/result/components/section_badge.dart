import 'package:flutter/material.dart';
import 'package:speech_stroop/model/badge.dart';
import 'package:speech_stroop/theme.dart';

class SectionBadge extends StatefulWidget {
  const SectionBadge(this.badges, {Key key}) : super(key: key);
  final List<String> badges;

  @override
  SectionBadgeState createState() => SectionBadgeState();
}

class SectionBadgeState extends State<SectionBadge> {
  final formGlobalKey = GlobalKey<FormState>();

  List<String> badges = [];

  @override
  void initState() {
    badges = widget.badges;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              'รางวัลที่ได้รับ',
              style: textTheme().titleMedium,
            ),
          ),
          Row(
            children: [
              for (String b in badges)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    badgesMap[b].imgPath,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
