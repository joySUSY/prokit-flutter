import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CommonBackWidget extends StatelessWidget {
  final Widget child;

  const CommonBackWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (Navigator.of(context).canPop())
          Positioned(
            left: 0,
            top: 16,
            child: IconButton(
              icon: Icon(Icons.arrow_back_outlined),
              onPressed: () {
                finish(context);
              },
            ),
          ),
      ],
    );
  }
}
