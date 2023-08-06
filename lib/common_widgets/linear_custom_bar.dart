






import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themoviedb_tmdb/utilities/colors_contant.dart';
import 'package:themoviedb_tmdb/view_model.dart';

class LinearCustomBar extends HookConsumerWidget {
  final String headingTitle;
  final int count;
  final bool isArrow;
  final bool isLogout;
  final IconData iconDataPass;
   const LinearCustomBar({ required this.iconDataPass,required this.headingTitle, this.count =0,this.isArrow=false,this.isLogout =false,
    super.key,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: isLogout?ConstantColors.highlightedColor:ConstantColors.ultraLightTextColor,
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
               Icon(iconDataPass,color: isLogout?Colors.white:ConstantColors.darkTextColor,size: 24,),
              const SizedBox(width: 20,),
              Text(headingTitle,style:  TextStyle(color: isLogout?Colors.white:ConstantColors.darkTextColor,),),
              // isArrow?const SizedBox(width: 20,):const SizedBox(width: 0,),
            ],
          ),
          isArrow?  Icon(Icons.arrow_forward_ios,color: isLogout?Colors.white:ConstantColors.darkTextColor,size: 16,):Text('$count',style: const TextStyle(color: ConstantColors.darkTextColor,),),
          // isArrow?const SizedBox(width: 20,):const SizedBox(width: 0,),

        ],
      ),
    );
  }
}