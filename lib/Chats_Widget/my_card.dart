import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String message;
  final String time;
  const MyCard({super.key, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            color: const Color(0xff075E57),
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 30, left: 10, top: 5, bottom: 20),
                child: Text(message,style: const TextStyle(fontSize: 15,color: Colors.white),),
              ),
              Positioned(
                bottom: 1,
                right: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Text(time,style: const TextStyle(fontSize: 12,color: Colors.grey),),
                   const SizedBox(
                      width: 5,
                    ), const Icon(Icons.done_all,color: Colors.blue)],
                ),
              ),
            ]),
          )),
    );
  }
}
