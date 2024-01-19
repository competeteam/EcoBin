import 'package:flutter/material.dart';

import 'package:dinacom_2024/models/guide_content.dart';
import 'package:dinacom_2024/services/guide_service.dart';
import 'package:go_router/go_router.dart';

const placeholderImage = Image(image: AssetImage('assets/images/photo_unavailable_placeholder_basic.jpg'),);

class Guide extends StatefulWidget {
  const Guide({super.key});

  @override
  State<Guide> createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  static final List<GuideContent> localContents = <GuideContent>[
    GuideContent(
      title: "Simple Ways of Waste Management at Home",
      content: "To reduce the production of such waste, it’s important to practice waste management at home. You can make small changes in your home which can lead to a big impact. Take a look at these simple ways in which waste can be efficiently managed at home:\n"
      "\n"
      "Limit the use of plastic: \nAvoid buying plastic water bottles; instead, carry your own water bottle whenever you step out. Do away with plastic straws and drink directly from the glass. Use steel or glass cups instead of plastic ones and carry a cloth bag with you every time you go out shopping. You can even turn your old jeans or pieces of denim into bags.\n"
      "\n"
      "Segregate the waste: \nSegregate garbage into degradable and non-degradable waste. You can also create compost at home with leftover food, fruit and vegetable peels etc. Waste segregation not only makes the process of recycling much easier, but it will also help in maintaining a healthy and clean surrounding.\n"
      "\n"
      "Reduce the use of paper: \nUse cloth rags instead of paper towels in the kitchen. Maintain soft copies of your journals, rather than using a notebook or a diary. Buy e-books instead of hard copies. Switch to using handkerchiefs and avoiding tissue papers to wipe your hands and face. Prefer metal or eco-friendly bamboo jute plates and cutlery instead of using paper plates when needed.\n"
      "\n"
      "Say yes to composting: \nComposting can reduce wastes by turning wet waste into fertilisers for plants. Besides, if you have or are planning to grow your own garden, you will have homemade, eco-friendly, chemical-free fertilisers to nourish your green babies.\n"
      "\n"
      "Plan your meals in advance: \nA lot of waste is generated from people throwing excess food away because they do not plan their meals in advance.\n"
      "\n"
      "Source: https://www.hdfc.com/blog/sustainability-at-hdfc/7-simple-ways-waste-management-home",
      imagePath: "assets/images/three_rs.jpg",
    ),
    GuideContent(
      title: "Classifying Waste",
      content: "There are 6 types of waste that can be classified into two categories: recyclable and non-recyclable.\n\n"
          "The recyclable waste includes paper, cardboard, glass, metal, and plastic.\n\n"
          "The non-recyclable waste includes hazardous waste, medical waste, electronic waste, organic waste, and general waste .\n\n"
          "It is important to follow the rules when disposing of waste. For example, green waste must not contain logs, stumps, palm logs, whole trees, mulched trees, golden cane trunks, soil, or turf. Branches must be under 13cm diameter. All green waste must stay under the top rail of the skip bin, with nothing poking up. General waste must not contain rocks, bricks, tiles, concrete, pavers, hard wood, paint, chemicals, tyres, carpet, mattress, soil, dirt, sand or hard fill. All general waste must stay under the top rail of the skip bin, with nothing poking up.\n\n"
          ""
          "Source: https://4waste.com.au/rubbish-removal/5-types-waste-know/",
      imagePath: "assets/images/classify_waste_campaign.jpg"
    )
  ];
  static List<GuideContent> contents = <GuideContent>[

  ];
  _GuideState() {
    _replaceALlGuide();
  }
  List<GuideCard> cards = [];

  Future<void> _replaceALlGuide() async {
    contents.clear();
    contents.addAll(localContents);
    try {
      var onlineContent = await GuideService().getAllGuides() ?? [];
      for (var element in onlineContent) {
        element.cardColor = const Color(0xFF5A8A62);
      }
      contents.addAll(onlineContent);
    }
    catch (exception) {

    }

    setState(() {
      int p = 0;
      cards = contents.map((e) => GuideCard(
        title: e.title ?? '',
        subtitle: e.content ?? '',
        imagePath: e.imagePath,
        cardColor: e.cardColor,
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
  final Color cardColor;
  const GuideCard({super.key,
    this.title = "Lorem Ipsum",
    this.subtitle = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
        "Cras et euismod justo, id dapibus est. "
        "Etiam auctor sem nec nisl rhoncus, a malesuada odio fringilla.",
    this.imagePath,
    this.id = -1,
    this.cardColor = const Color(0xFF377EB5),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 342,
      height: 130,

      child: Card(
        elevation: 10,
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        color: cardColor,
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
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
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
                    errorBuilder: (context, error, stackTrace) => placeholderImage,
                    fit: BoxFit.contain,
                  ): placeholderImage
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 0,
              ),),
            const SizedBox(height: 18,),
            guideContent.imagePath != null ? SizedBox(
                height: 170,
                child: Image(image: AssetImage(guideContent.imagePath!),
                  errorBuilder: (context, error, stackTrace) => placeholderImage,
                  fit: BoxFit.contain,
                )
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