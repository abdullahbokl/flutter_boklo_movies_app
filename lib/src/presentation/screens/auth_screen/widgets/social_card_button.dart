import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SocialCardButton extends StatelessWidget {
  final String img;
  final void Function() func;

  const SocialCardButton({Key? key, required this.img, required this.func})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).textTheme.displayLarge!.color,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(29.8),
        ),
        InkWell(
          onTap: func,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(15),
            child: Image.asset(
              img,
              height: 4.h,
            ),
          ),
        ),
      ],
    );
  }
}
