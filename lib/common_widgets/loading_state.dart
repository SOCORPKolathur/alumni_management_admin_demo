import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingState extends StatefulWidget {
  const LoadingState({Key? key}) : super(key: key);

  @override
  State<LoadingState> createState() => _LoadingStateState();
}

class _LoadingStateState extends State<LoadingState> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(

              width: 400,
              child: Lottie.asset("assets/loading file new.json"))
        ],
      ),
    );
  }
}
