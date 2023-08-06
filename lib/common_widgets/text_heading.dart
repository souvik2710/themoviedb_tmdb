



import 'package:flutter/material.dart';

class TextMovieHeadingWidget extends StatelessWidget {
  final String headingText;
  const TextMovieHeadingWidget({
    super.key, required this.headingText
  });

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(headingText,style: TextStyle(fontSize:20,fontWeight: FontWeight.w500,),textAlign: TextAlign.left,)
    );
  }
}

class SmallSizedBoxCustom extends StatelessWidget {
  const SmallSizedBoxCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height:MediaQuery.of(context).size.height*0.01,);
  }
}


class MediumSizedBoxCustom extends StatelessWidget {
  const MediumSizedBoxCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height:MediaQuery.of(context).size.height*0.02,);
  }
}
