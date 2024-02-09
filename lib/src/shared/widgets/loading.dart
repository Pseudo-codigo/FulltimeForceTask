import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3),
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.grey.shade400),
              color: Colors.white),
          child: SpinKitPulsingGrid(
            color: Colors.black.withOpacity(0.9),
            size: 50.0,
          ),
        ),
      ),
    );
  }
}
