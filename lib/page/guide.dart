import 'dart:io';

import 'package:dinacom_2024/home.dart';
import 'package:dinacom_2024/models/guide_content.dart';
import 'package:dinacom_2024/services/guide_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Guide extends StatefulWidget {
  const Guide({super.key});

  @override
  State<Guide> createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  static List<GuideContent> contents = <GuideContent>[

  ];
  _GuideState() {
    _replaceALlGuide();
  }
  List<GuideCard> cards = [];

  Future<void> _replaceALlGuide() async {
    contents = await GuideService().getAllGuides() ?? [];
    setState(() {
      int p = 0;
      cards = contents.map((e) => GuideCard(
        title: e.title ?? '',
        subtitle: e.content ?? '',
        imagePath: e.imagePath,
        id: p++,)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(34, 34, 34, 0.98),
      body: RefreshIndicator(
        onRefresh: _replaceALlGuide,
        child: ListView(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 70, bottom: 40),
          children: <Widget>[
            const Text(
              'Guides',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.normal
              ),
            ),
            const Text(
              'Read our latest blogs!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w100
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            Column(
              children: cards,
            ),
          ],
        ),
      ),
    );
  }
}


class GuideCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? imagePath;
  final int id;
  const GuideCard({super.key,
    this.title = "Lorem Ipsum",
    this.subtitle = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
        "Cras et euismod justo, id dapibus est. "
        "Etiam auctor sem nec nisl rhoncus, a malesuada odio fringilla.",
    this.imagePath,
    this.id = -1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 342,
      height: 130,

      child: Card(
        elevation: 10,
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        color: const Color(0xFF5A8A62),
        child: InkWell(
          onTap: () {
            GoRouter.of(context).push('/guide/${id}');
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 15, 18),
            child: ListTile(
              title: Text(title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              subtitle: Text(subtitle,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w300,
                  height: 0,
                ),
              ),
              trailing: SizedBox(
                  height: 80,
                  width: 80,
                  child: imagePath != null ? Image(
                    image: AssetImage(imagePath!),
                    errorBuilder: (context, error, stackTrace) => const Placeholder(),
                  ): const Placeholder()
              ),
              contentPadding: EdgeInsets.zero,
              minVerticalPadding: 0,
            ),
          ),
        ),
      ),
    );
  }
}

class GuideArticle extends StatelessWidget {
  const GuideArticle({super.key});

  @override
  Widget build(BuildContext context) {
    final int id = int.tryParse(
        GoRouterState.of(context).pathParameters['id'] ?? ''
    ) ?? -1;
    final GuideContent guideContent = (0 <= id && id < _GuideState.contents.length)
        ? _GuideState.contents[id]
        : GuideContent();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xF9212121),
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(42, 40, 43, 17),
        color: const Color(0xF9212121),
        child: ListView(
          clipBehavior: Clip.antiAlias,
          children: <Widget>[
            Text(guideContent.title ?? 'Guide not found',
              overflow: TextOverflow.fade,
              maxLines: 3,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 0,
              ),),
            guideContent.imagePath != null ? SizedBox(
                height: 170,
                child: Image(image: AssetImage(guideContent.imagePath!),
                  errorBuilder: (context, error, stackTrace) => const Placeholder(),)
            ) : const SizedBox(height: 20,),
            Text(id.toString()),
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: Text(guideContent.content ?? 'Guide with id $id not found',
                textAlign: TextAlign.left,
                overflow: TextOverflow.visible,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w300,
                  height: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}