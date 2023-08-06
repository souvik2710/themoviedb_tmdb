import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:themoviedb_tmdb/api_provider.dart';
import 'package:themoviedb_tmdb/common_widgets/text_heading.dart';
import 'package:themoviedb_tmdb/model/movie_results_model.dart';
import 'package:themoviedb_tmdb/utilities/colors_contant.dart';
import 'package:themoviedb_tmdb/view_model.dart';


import '../common_widgets/card_custom_movie.dart';
import 'carousel.dart';
List<String> img=["https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__340.jpg",
  "https://st3.depositphotos.com/3047333/12924/i/600/depositphotos_129246006-stock-photo-kitten-sitting-in-flowers.jpg",
  "https://thumbs.dreamstime.com/b/flowers-4929984.jpg",
  "https://cdn.pixabay.com/photo/2017/05/08/13/15/bird-2295431__340.jpg"];

// https://image.tmdb.org/t/p/w500/1E5baAaEse26fej7uHcjOgEE2t2.jpg

class MovieMainPage extends HookConsumerWidget {
  static String BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w500';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ref.read(movieViewModel).getUserCloudF();
        ref.read(movieViewModel).vmGetMoviesTrending();
        ref.read(movieViewModel).vmGetNowPlaying();
        ref.read(movieViewModel).vmGetTvShows();
        ref.read(movieViewModel).vmGetPopularMovies();
      });
      return () {

      };
    }, []);
    final MovieResultsModel?  sMoviesTrending  = ref.watch(movieViewModel).isLoadingMoviesTrending?null:ref.watch(movieViewModel).mMoviesTrending;
    final MovieResultsModel?  sNowPlaying  = ref.watch(movieViewModel).isLoadingNowPlaying?null:ref.watch(movieViewModel).mNowPlaying;
    final MovieResultsModel?  sGetTvShows  = ref.watch(movieViewModel).isLoadingGetTvShows?null:ref.watch(movieViewModel).mTvShows;
    final MovieResultsModel?  sPopularMovies  = ref.watch(movieViewModel).isLoadingGetPopularMovies?null:ref.watch(movieViewModel).mPopularMovies;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ref.watch(movieViewModel).isLoadingMoviesTrending || ref.watch(movieViewModel).isLoadingNowPlaying || ref.watch(movieViewModel).isLoadingGetTvShows || ref.watch(movieViewModel).isLoadingGetPopularMovies ?
      const SafeArea(child: Center(child: CircularProgressIndicator(),)):
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
          child: SingleChildScrollView(
            child: Column(
              // shrinkWrap: true,
              children: [
                // Carousel(HOME_PAGE_BANNERS),
                Card(
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      height: 400,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      //onPageChanged: callbackFunction,
                      scrollDirection: Axis.horizontal,
                    ),
                    itemCount: sMoviesTrending?.results.length??0,
                    itemBuilder: (BuildContext context, int i, int realIndex) =>
                        Container(
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              Container(
                                  // height: 400,
                                  // width:150,
                                  // padding: const EdgeInsets.only(left:10.0,top:15.0,right:10.0,bottom: 0.0),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    image: DecorationImage(
                                      image:NetworkImage('$BASE_IMAGE_URL/${sMoviesTrending?.results[i].posterPath}'),
                                      fit:BoxFit.fill,
                                    ),
                                    // borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                    borderRadius: BorderRadius.circular(10.0),
                                  )

                              ),
                              Visibility(
                                visible: false,
                                child: Positioned(
                                  bottom: 30,
                                    child: Text('${sMoviesTrending?.results[i].title}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: ConstantColors.darkTextColor),)),
                              ),
                            ],
                          ),
                        ),
                  ),
                ),
                // Divider(thickness: 10, color: ConstantColors.mediumTextColor,),
                const SmallSizedBoxCustom(),

                const TextMovieHeadingWidget(headingText: 'Now Playing',),
                const SmallSizedBoxCustom(),

                Container(
                  // padding: EdgeInsets.symmetric(horizontal: 30),
                  height: 250,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount:sNowPlaying?.results.length??0,
                      separatorBuilder: (context,index){
                        return SizedBox(width:10.0);
                      },
                      itemBuilder: (context,index){
                        if((sNowPlaying?.results[index].id??0)==0){
                          return const SizedBox();
                        }else{
                          return  CardCustomMovie(movieName: '${sNowPlaying?.results[index].title}', duration: '1hr 45min', imageUrl: '$BASE_IMAGE_URL/${sNowPlaying?.results[index].posterPath}', rating: '${sNowPlaying?.results[index].voteAverage}', entireMovie: sNowPlaying!.results[index],);
                        }
                      }
                  ),
                ),
                const SmallSizedBoxCustom(),
                const TextMovieHeadingWidget(headingText: 'On TV',),
                const SmallSizedBoxCustom(),
                Container(
                  // padding: EdgeInsets.symmetric(horizontal: 30),
                  height: 250,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount:sGetTvShows?.results.length??0,
                      separatorBuilder: (context,index){
                        return SizedBox(width:10.0);
                      },
                      itemBuilder: (context,index){
                      if((sGetTvShows?.results[index].id??0)==0){
                        return const SizedBox();
                        }else{
                        return  CardCustomMovie(movieName: '${sGetTvShows?.results[index].title}', duration: '1hr 45min', imageUrl: '$BASE_IMAGE_URL/${sGetTvShows?.results[index].posterPath}', rating: '${sGetTvShows?.results[index].voteAverage}', entireMovie: sGetTvShows!.results[index],);
                      }
                      }
                  ),
                ),

                const SmallSizedBoxCustom(),
                const TextMovieHeadingWidget(headingText: 'Popular Movies',),
                const SmallSizedBoxCustom(),
                Container(
                  // padding: EdgeInsets.symmetric(horizontal: 30),
                  height: 250,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount:sPopularMovies?.results.length??0,
                      separatorBuilder: (context,index){
                        return SizedBox(width:10.0);
                      },
                      itemBuilder: (context,index){
                        if((sPopularMovies?.results[index].id??0)==0){
                          return const SizedBox();
                        }else{
                          return  CardCustomMovie(movieName: '${sPopularMovies?.results[index].title}', duration: '1hr 45min', imageUrl: '$BASE_IMAGE_URL/${sPopularMovies?.results[index].posterPath}', rating: '${sPopularMovies?.results[index].voteAverage}', entireMovie: sPopularMovies!.results[index],);
                        }
                      }
                  ),
                ),
                // #FF0030

              ],
            ),
          ),
        ),
      ),
    );
  }
}





