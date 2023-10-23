
import 'package:flutter/material.dart';

import '../../service/firebase_service.dart';

class CountUnSeenMessages extends StatefulWidget {
  final String roomId;
  final DateTime otherSeen;
  const CountUnSeenMessages({Key? key, required this.roomId, required this.otherSeen}) : super(key: key);

  @override
  State<CountUnSeenMessages> createState() => _CountUnSeenMessagesState();
}

class _CountUnSeenMessagesState extends State<CountUnSeenMessages> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
        future: FirebaseService().getUnseenCount(
            roomId: widget.roomId,
            lastSeen: widget.otherSeen
        ),
        builder: (context, snapshot){
          if(snapshot.hasData){
            if(snapshot.data! < 1)return const SizedBox.shrink();
            return Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFFF0433F),
                        Color(0xFFFE5709),
                        Color(0xFFFD7C01)
                      ])),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(
                  snapshot.data.toString(),
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        });
  }
}
