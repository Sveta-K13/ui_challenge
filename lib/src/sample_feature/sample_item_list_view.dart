import 'package:flutter/material.dart';

import '../settings/settings_view.dart';
import 'sample_item.dart';
import 'sample_item_details_view.dart';

const cardHeight = 140.0;
const cardWidth = 300.0;

/// Displays a list of SampleItems.
class SampleItemListView extends StatefulWidget {
  const SampleItemListView({
    Key? key,
    this.items = const [
      SampleItem(1, Colors.black, 'First'),
      SampleItem(2, Colors.amber, 'Second'),
      SampleItem(3, Colors.cyan, 'Third'),
    ],
  }) : super(key: key);

  static const routeName = '/';

  final List<SampleItem> items;

  @override
  State<SampleItemListView> createState() => _SampleItemListViewState();
}

class _SampleItemListViewState extends State<SampleItemListView> {
  double koef = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.ac_unit),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: Stack(
        children: widget.items.map((item) {
          final topPosition = 100 + (item.id - 1) * (cardHeight + 20) * koef;
          return AnimatedPositioned(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInCubic,
            top: topPosition,
            child: GestureDetector(
              onTap: () => setState(() {
                koef = koef == 0.5 ? 0 : .5;
              }),
              child: AnimatedRotation(
                  duration: const Duration(seconds: 1),
                  turns: koef * 0.1 * item.id,
                  child: CustomCard(item: item)),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  final SampleItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        height: cardHeight,
        width: cardWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [item.color, item.color.withRed(20)],
          ),
          borderRadius: BorderRadius.circular(20),
          backgroundBlendMode: BlendMode.hardLight,
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(item.text),
        ));
  }
}
