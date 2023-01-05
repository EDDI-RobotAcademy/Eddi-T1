import 'package:flutter/material.dart';

class BuyerInfoCard extends StatefulWidget {
  const BuyerInfoCard(
      {Key? key,
      required this.iconData,
      required this.menuTitle,
      required this.onCustomButtonPressed})
      : super(key: key);

  @override
  State<BuyerInfoCard> createState() => _BuyerInfoCardState();
  final IconData iconData;
  final String menuTitle;
  final VoidCallback onCustomButtonPressed;
}

class _BuyerInfoCardState extends State<BuyerInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            widget.onCustomButtonPressed.call();
          },
          child: Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              color: Color(0xFF2F4F4F),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Icon(widget.iconData, color: Colors.white, size: 45),
                    const SizedBox(height: 5.0),
                    Text(widget.menuTitle,
                        style: TextStyle(fontSize: 10, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
