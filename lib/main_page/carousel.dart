



import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

const List<String> HOME_PAGE_BANNERS = [
  'assets/images/banner.jpg',
  'assets/images/banner.jpg',
  'assets/images/banner.jpg',
  'assets/images/banner.jpg',
];

class Carousel extends StatelessWidget {
  final List<String> banners;


  const Carousel(this.banners);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: 150,
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          //onPageChanged: callbackFunction,
          scrollDirection: Axis.horizontal,
        ),
        itemCount: banners.length,
        itemBuilder: (BuildContext context, int i, int realIndex) =>
            Container(
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Image.asset(
                    banners[i],
                  ),
                  Text('dgsfgshdh'),
                ],
              ),
            ),
      ),
    );
  }
}
