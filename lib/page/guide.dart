import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Guide extends StatefulWidget {
  const Guide({super.key});

  @override
  State<Guide> createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(34, 34, 34, 0.98),
      body: ListView(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 70, bottom: 40),
        children: const <Widget>[
          Text(
            'Guides',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.normal
            ),
          ),
          Text(
            'Read our latest blogs!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w100
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 50)),
          GuideCard(
            title: 'Ini title custom',
            subtitle: 'Ini subtitle custom',
            content: 'Ini content custom',
          ),
          GuideCard(),
          GuideCard(),
          GuideCard(),
        ],
      ),
    );
  }
}


class GuideCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String content;
  final int id;
  const GuideCard({super.key,
    this.title = "Lorem Ipsum",
    this.subtitle = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
        "Cras et euismod justo, id dapibus est. "
        "Etiam auctor sem nec nisl rhoncus, a malesuada odio fringilla.",
    this.content = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras et euismod justo, id dapibus est. Etiam auctor sem nec nisl rhoncus, a malesuada odio fringilla. Praesent tempus turpis sem, a egestas lacus rutrum eget. Curabitur vulputate, velit ut faucibus interdum, lacus leo egestas risus, a congue ipsum erat et arcu. In id commodo arcu. Donec vel metus sapien. Phasellus lobortis risus felis. In congue nisi a nulla viverra, quis tristique lacus egestas. Ut molestie auctor erat, non aliquam risus consequat vel. Ut convallis nibh eget ultricies luctus. Cras lacinia malesuada hendrerit.\n\nVestibulum bibendum nulla vitae nibh blandit tincidunt. Nulla lorem eros, rutrum vel tristique et, dictum non velit. Duis a imperdiet nisl, ut varius sem. Quisque rutrum pellentesque malesuada. Nulla id bibendum justo, id laoreet ipsum. Donec sed nulla dapibus, pharetra velit a, vulputate augue. Phasellus nec mi nec mauris venenatis volutpat. Etiam ultricies, lorem quis porta accumsan, arcu nibh pharetra elit, eget tincidunt purus lorem eu ipsum. Cras dapibus et nisl eget tristique. Vestibulum ut tempus lectus. Cras vitae sem commodo, venenatis ante vel, vulputate purus. Suspendisse hendrerit risus diam, quis convallis risus lacinia a. In pretium porttitor dui non laoreet. Mauris vitae eleifend felis. Nulla facilisi.",
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
              trailing: const SizedBox(
                  height: 80,
                  width: 80,
                  child: Placeholder()
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
  final String title;
  final String content;
  const GuideArticle({super.key, this.title = "Title", this.content = "Content"});

  @override
  Widget build(BuildContext context) {
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
            Text(title,
              overflow: TextOverflow.fade,
              maxLines: 3,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 0,
              ),),
            const SizedBox(
                height: 170,
                child: Placeholder()
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: Text(content,
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