import 'package:flutter/material.dart';
import 'package:flutter_crise/components/button.component.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class IntroPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: EdgeInsets.only(top: 25),
              child: Center(
                  child: Image.asset('assets/images/logo_intro.png', width: 200))),
          SvgPicture.asset('assets/images/vetor_intro.svg'),
          ButtonComponent(label: '')
        ],
      ),
    )));
  }
}
