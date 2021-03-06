import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
      width: 2.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.pink,
      width: 2.0,
    ),
  ),
);

const drawerItemStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w500,
);

const formTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 14,
);

const faqSizedbox = SizedBox(
  height: 10,
);
