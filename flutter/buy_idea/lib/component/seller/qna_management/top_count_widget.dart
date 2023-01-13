import 'package:flutter/material.dart';

class TopCountWidget extends StatefulWidget {
  const TopCountWidget(
      {Key? key, required this.questionCount, required this.answerStatus})
      : super(key: key);
  final int questionCount;
  final String answerStatus;

  @override
  State<TopCountWidget> createState() => _TopCountWidgetState();
}

class _TopCountWidgetState extends State<TopCountWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            height: 50.0,
            child: Row(
              children: [
                Icon(Icons.auto_graph, color: Color(0xFF2F4F4F), size: 30),
                SizedBox(width: 10.0),
                Text('${widget.answerStatus} 상태의 글'),
                SizedBox(width: 10.0),
                Expanded(
                  child: Divider(
                      color: Color(0xFF2F4F4F), height: 2.0, thickness: 1),
                ),
                SizedBox(width: 10.0),
                Text(
                  '${widget.questionCount}개',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F4F4F)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
