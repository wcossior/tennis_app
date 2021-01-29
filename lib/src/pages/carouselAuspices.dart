import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tennis_app/src/providers/auspices_provider.dart';

class CarouselAuspices extends StatefulWidget {
  CarouselAuspices({Key key})
      : super(key: key);

  @override
  _CarouselAuspicesState createState() => _CarouselAuspicesState();
  
}

class _CarouselAuspicesState extends State<CarouselAuspices> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final auspicesBloc = AuspicesProvider.of(context);
    final auspices = auspicesBloc.auspices;
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              spreadRadius: 3.0,
            ),
          ]),
          child: CarouselSlider(
            options: CarouselOptions(
              height:  MediaQuery.of(context).size.height * 0.18,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            items: auspices.map((auspice) {
              return Builder(builder: (BuildContext context) {
                return Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width * 0.40,
                        child: FadeInImage(
                            placeholder: AssetImage("assets/jar-loading.gif"),
                            fadeInDuration: Duration(milliseconds: 200),
                            image: auspice.urlImg == null
                                ? AssetImage("assets/jar-loading.gif")
                                : NetworkImage(auspice.urlImg),
                            fit: BoxFit.cover)));
              });
            }).toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(auspices, (index, url) {
            return Container(
              width: 10.0,
              height: 10.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentIndex == index ? Colors.blueAccent : Colors.grey,
              ),
            );
          }),
        ),
      ],
    );
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
}
