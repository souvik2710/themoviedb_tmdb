

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themoviedb_tmdb/common_widgets/text_heading.dart';
import 'package:themoviedb_tmdb/model/movie_results_model.dart';
import 'package:themoviedb_tmdb/utilities/colors_contant.dart';

class SingleMovieDetails extends HookConsumerWidget {
  static String BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w500';
  final Result movieResult;
  const SingleMovieDetails( {super.key, required this.movieResult,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(movieResult.originalTitle??'',style: TextStyle(color: ConstantColors.darkTextColor,fontSize: 16),),
        leading: InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back_ios_new_sharp,color: ConstantColors.darkTextColor,)),
        elevation: 3,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ShaderMask(
                blendMode : BlendMode.modulate,
                //by default blendmode is BlendMode.modulate
                // blendMode : BlendMode.srcATop,
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black,
                        Colors.grey,
                        Colors.white
                      ]
                  ).createShader(bounds);
                },
               child: Container(
                 height: 500,
                 // width:150,
                 // padding: const EdgeInsets.only(left:10.0,top:15.0,right:10.0,bottom: 0.0),
                   decoration: BoxDecoration(
                     color: Colors.red,
                     image: DecorationImage(
                       image:NetworkImage('$BASE_IMAGE_URL/${movieResult.posterPath}'),
                       fit:BoxFit.fill,
                     ),
                     // borderRadius: BorderRadius.all(Radius.circular(20.0)),
                     borderRadius: BorderRadius.circular(0.0),
                   )

               ),
             ),
              // Divider(thickness: 10, color: ConstantColors.mediumTextColor,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const MediumSizedBoxCustom(),
                    const TextMovieHeadingWidget(headingText: 'Story',),
                    const MediumSizedBoxCustom(),
                    Text('${movieResult.overview}',style: const TextStyle(fontSize: 12,color: Colors.grey, ),textAlign: TextAlign.left,),
                  ],
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }
}
