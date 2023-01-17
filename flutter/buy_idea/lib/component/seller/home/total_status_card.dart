import 'package:flutter/material.dart';

class TotalStatusCard extends StatefulWidget {

  final int total;
  final String title;
  final String subTitle;
  final String imageName;
  final String bottomText;
  final String countText;
  final void Function()? onTap;

  const TotalStatusCard({
    Key? key,
    required this.total,
    required this.title,
    required this.subTitle,
    required this.imageName,
    required this.bottomText,
    required this.countText,
    this.onTap
  }) : super(key: key);

  @override
  State<TotalStatusCard> createState() => _TotalStatusCardState();
}

class _TotalStatusCardState extends State<TotalStatusCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
      child: InkWell(
        onTap: widget.onTap,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(child: Text(widget.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                    Align(
                      alignment: Alignment.center,
                      child: Icon(Icons.arrow_forward)
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(widget.subTitle, style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Image.asset(widget.imageName)
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(widget.bottomText, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Divider(thickness: 0.5, indent: 10, endIndent: 10, color: Colors.black)
                    ),
                    Text('${widget.total}${widget.countText}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
