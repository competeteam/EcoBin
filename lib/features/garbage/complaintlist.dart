import 'package:dinacom_2024/page/garbages.dart';
import 'package:dinacom_2024/services/complaint_service.dart';
import 'package:flutter/material.dart';

class ComplaintList extends StatefulWidget {
  final String tid;
  final String uid;
  final String adrs;

  const ComplaintList(
      {super.key, required this.uid, required this.adrs, required this.tid});

  @override
  State<ComplaintList> createState() => _ComplaintListState();
}

class _ComplaintListState extends State<ComplaintList> {
  List<GuideCard> cards = [];
  List<ResolvedCard> resolvedcards = [];

  Future<void> _replaceALlGuide() async {
    try {
      var complaints = await ComplaintService().getComplaintByTid(widget.tid);

      // contents.clear();
      // contents.addAll(localContents);
      // contents.addAll(onlineContent);
      if (mounted) {
        setState(() {
          int p = 0;
          cards = complaints
              .where((element) => element!.isResolved == false)
              .map((e) => GuideCard(
                    title: e!.content,
                    subtitle:
                        e.type.toString().replaceAll("ComplaintType.", ""),
                    imagePath: '',
                    id: p++,
                    cid: e.cid,
                    uid: widget.uid,
                  ))
              .toList();
          resolvedcards = complaints
              .where((element) => element!.isResolved)
              .map((e) => ResolvedCard(
                    title: e!.content,
                    subtitle:
                        e.type.toString().replaceAll("ComplaintType.", ""),
                    imagePath: '',
                    id: p++,
                    cid: e.cid,
                    uid: widget.uid,
                  ))
              .toList();
        });
      }
    } catch (e) {
      // TODO: Implement
    }
  }

  @override
  Widget build(BuildContext context) {
    _replaceALlGuide();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(34, 34, 34, 0.98),
      body: RefreshIndicator(
        onRefresh: _replaceALlGuide,
        child: ListView(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 70, bottom: 40),
          children: <Widget>[
            const Text(
              'Complaints',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.normal),
            ),
            Text(
              'Trash bin in ${widget.adrs}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w100),
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
            const Text(
              "Unresolved complaints",
              style: TextStyle(
                  color: Color.fromARGB(255, 218, 218, 218),
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            ),
            Column(
              children: cards,
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
            const Text(
              "Resolved complaints",
              style: TextStyle(
                  color: Color.fromARGB(255, 218, 218, 218),
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            ),
            Column(
              children: resolvedcards,
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
  final String? cid;
  final String? uid;

  const GuideCard(
      {super.key,
      this.title = "Lorem Ipsum",
      this.subtitle =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
              "Cras et euismod justo, id dapibus est. "
              "Etiam auctor sem nec nisl rhoncus, a malesuada odio fringilla.",
      this.imagePath,
      this.id = -1,
      this.cid,
      this.uid});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 342,
      height: 130,
      child: Card(
        elevation: 10,
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        color: const Color.fromARGB(255, 182, 85, 85),
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 15, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        subtitle.capitalize(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: ElevatedButton(
                      // style: OutlinedButton.styleFrom(
                      //     fixedSize: Size.fromWidth(
                      //         MediaQuery.of(context).size.width * 0.01)),
                      onPressed: () {
                        ComplaintService().resolveComplaint(
                            cid: cid!, uid: uid!, resolvedAt: DateTime.now());
                      },
                      child: const Icon(
                        Icons.done,
                        color: Color(0xFF5A8A62),
                      )
                      // const Text(
                      //   'Resolve',
                      //   style: TextStyle(
                      //     color: Color(0xFF5A8A62),
                      //   ),
                      // ),
                      ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResolvedCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? imagePath;
  final int id;
  final String? cid;
  final String? uid;

  const ResolvedCard(
      {super.key,
      this.title = "Lorem Ipsum",
      this.subtitle =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
              "Cras et euismod justo, id dapibus est. "
              "Etiam auctor sem nec nisl rhoncus, a malesuada odio fringilla.",
      this.imagePath,
      this.id = -1,
      this.cid,
      this.uid});

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
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 15, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        subtitle.capitalize(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
