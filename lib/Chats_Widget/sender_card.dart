import 'package:flutter/material.dart';

class SenderCard extends StatelessWidget {
  final String message;
  final String time;
  const SenderCard({super.key, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            color:const Color.fromRGBO(37, 45, 49, 1),
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 30, left: 10, top: 5, bottom: 20),
                child: Text(message,
                    style: const TextStyle(fontSize: 15, color: Colors.white)),
              ),
              Positioned(
                bottom: 2,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(time, style: const TextStyle(fontSize: 12)),
                    
                  ],
                ),
              ),
            ]),
          )),
    );
  }
}
