import 'package:flutter/material.dart';

class HeaderView extends StatelessWidget {
  const HeaderView({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          const Divider(color: Colors.grey,height: 1.5,)
        ],
      ),
    );
  }
}
