import 'package:flutter/material.dart';

class CustomFavouriteButton extends StatelessWidget {
  final void Function() func;

  const CustomFavouriteButton({Key? key, required this.func}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 119, 235, 123),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: IconButton(
        onPressed: func,
        icon: const Icon(
          Icons.favorite,
          color: Colors.white,
        ),
      ),
    );
  }
}
