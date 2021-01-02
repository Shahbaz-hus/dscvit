import 'dart:convert';

import 'package:dscnasa/readMore.dart';
import 'package:dscnasa/viewImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int code = 0;
  String details;
  String imgUrl;
  Future<dynamic> _future;
  String showLess;

  
  getData() async{
    //http://www.filltext.com/?rows=1&pretty=true&url=https://orsted.com/-/media/WWW/Images/Corp/Campaign/SpaceSafari/space-safari-background.png&explanation=The%20South%20Celestial%20Pole%20is%20easy%20to%20spot%20in%20star%20trail%20images%20of%20the%20southern%20sky.%20The%20extension%20of%20Earth%27s%20axis%20of%20rotation%20to%20the%20south,%20it%27s%20at%20the%20center%20of%20all%20the%20southern%20star%20trail%20arcs.%20In%20this%20starry%20panorama%20streching%20about%2060%20degrees%20across%20deep%20southern%20skies%20the%20South%20Celestial%20Pole%20is%20somewhere%20near%20the%20middle%20though,%20flanked%20by%20bright%20galaxies%20and%20southern%20celestial%20gems.%20Across%20the%20top%20of%20the%20frame%20are%20the%20stars%20and%20nebulae%20along%20the%20plane%20of%20our%20own%20Milky%20Way%20Galaxy.
    //https://api.nasa.gov/planetary/apod?api_key=EBqyhwQVantjfEABXbVlHiBrwN7pSvXpGIq2Sujy
    var res = await http.get('https://api.nasa.gov/planetary/apod?api_key=EBqyhwQVantjfEABXbVlHiBrwN7pSvXpGIq2Sujy');
    if (res.statusCode == 200){
      setState(() {
        code = 200;
      });

      var responseBody = json.decode(res.body);
      print(responseBody);
      return responseBody;
    }

    
  }

  @override
  void initState() {
    _future = getData();
    super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Center(
            child: Stack(
              children: [
                FutureBuilder(
                  future: _future,
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if (snapshot.hasData){
                      print(snapshot.data.length);
                      if(snapshot.data.length == 0){
                        return Center(
                            child: Text(
                              'No data found',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ));
                      }
                      else{

                          showLess = snapshot.data["explanation"].toString().substring(0,200);


                        return Container(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [

                              Container(
                                height: size.height,
                                width: double.infinity,
                                color: Colors.black,
                                child: Opacity(
                                    opacity: 0.7,
                                    child: Image.network(

                                      snapshot.data["url"],
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context, Widget child,
                                          ImageChunkEvent loadingProgress) {

                                        if (loadingProgress == null) return child;
                                        return Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              CircularProgressIndicator(
                                                value: loadingProgress.expectedTotalBytes != null
                                                    ? loadingProgress.cumulativeBytesLoaded /
                                                    loadingProgress.expectedTotalBytes
                                                    : null,
                                              ),
                                              SizedBox(height: 10,),
                                              Text('Loading...',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),),
                                            ],
                                          ),

                                        );

                                      },
                                    )

                                ),
                              ),


                               Positioned(
                                 bottom: 50,

                                 child: Container(
                                   height: size.height*0.4,
                                   width: size.width*0.8,
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                     color: Colors.black.withOpacity(0.6),
                                   ),
                                   child: Padding(
                                     padding: const EdgeInsets.all(14),
                                     child: Column(
                                       children: [
                                         SizedBox(height: 20,),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           children: [
                                             Text(
                                               '${snapshot.data["date"]}',
                                               style: TextStyle(
                                                 color: Colors.white,
                                                 fontWeight: FontWeight.w900,
                                                 fontSize: 40,
                                                 fontFamily: 'Playfair',

                                               ),

                                             )
                                           ],
                                         ),
                                         SizedBox(
                                           height: 20,
                                         ),

                                         Row(
                                           children: [
                                             Flexible(
                                               child: Text(
                                                 '${showLess}...',
                                                 style: TextStyle(
                                                   color: Colors.white,
                                                   fontWeight: FontWeight.w300,
                                                   fontSize: 15,
                                                 ),

                                               ),
                                             )
                                           ],
                                         ),

                                         SizedBox(
                                           height: 20,
                                         ),

                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                           children: [

                                             GestureDetector(
                                               onTap: (){

                                                 Navigator.push(
                                                   context,
                                                   MaterialPageRoute(
                                                       builder: (context) =>
                                                           ReadMore(
                                                             copyright: snapshot.data["copyright"],
                                                             date: snapshot.data["date"],
                                                             explanation: snapshot.data["explanation"],
                                                             title: snapshot.data["title"],
                                                             url: snapshot.data["url"],
                                                           )),
                                                 );

                                              },
                                               child: Container(
                                                 height: 40,
                                                 width: 120,
                                                 decoration: BoxDecoration(
                                                   borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                   color: Color(0xFF546F93),
                                                 ),

                                                 child: Center(
                                                   child: Text(
                                                     'Read More',
                                                     style: TextStyle(
                                                       color: Colors.white,
                                                       fontWeight: FontWeight.bold,
                                                     ),
                                                   ),
                                                 ),

                                               ),
                                             ),

                                             GestureDetector(
                                               onTap: (){
                                                 Navigator.push(
                                                   context,
                                                   MaterialPageRoute(
                                                       builder: (context) =>
                                                           ViewImage(
                                                             url: snapshot.data["url"],
                                                           )),
                                                 );
                                               },
                                               child: Container(
                                                 height: 40,
                                                 width: 120,
                                                 decoration: BoxDecoration(
                                                   borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                                   color: Colors.white.withOpacity(0.9),
                                                 ),
                                                 child: Center(
                                                   child: Text(
                                                     'View image',
                                                     style: TextStyle(
                                                       color: Colors.black,
                                                       fontWeight: FontWeight.bold,
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                             )

                                           ],
                                         )
                                       ],
                                     ),
                                   ),
                                 )
                               ),

                              //Text('${snapshot.data["url"]}',),
                            ],
                          ),

                        );
                      }
                    }
                    else{
                      return Container(
                        height: size.height,
                        width: size.width,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left:40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: size.width*0.9,



                                    child: Image.asset("assets/images/image.png")),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  },
                )

              ],
            )
          ),
        ),
      ),
    );
  }
}

/*





                              FutureBuilder(
                  future: getData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    if (snapshot.hasData){
                      print(snapshot.data.length);
                      if(snapshot.data.length == 0){
                        return Center(
                            child: Text(
                              'No data found',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ));
                      }
                      else{
                        return Container(
                          child: Column(
                            children: [

                              Container(
                                height: size.height,
                                width: double.infinity,
                                color: Colors.black,
                                child: Opacity(
                                    opacity: 0.7,
                                    child: Image.network(

                                      snapshot.data["url"],
                                      fit: BoxFit.fill,
                                      loadingBuilder: (BuildContext context, Widget child,
                                          ImageChunkEvent loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              CircularProgressIndicator(
                                                value: loadingProgress.expectedTotalBytes != null
                                                    ? loadingProgress.cumulativeBytesLoaded /
                                                    loadingProgress.expectedTotalBytes
                                                    : null,
                                              ),
                                              SizedBox(height: 10,),
                                              Text('Loading...',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),),
                                            ],
                                          ),
                                        );
                                      },
                                    )),
                              ),
                              //Text('${snapshot.data["url"]}',),
                            ],
                          ),

                        );
                      }
                    }
                    else{
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )








                              PhotoView(
                                  imageProvider: NetworkImage(snapshot.data["url"]),

                                  loadingBuilder: (context, event) => Center(
                                    child: Container(
                                      width: 20.0,
                                      height: 20.0,
                                      child: CircularProgressIndicator(
                                        value: event == null
                                            ? 0
                                            : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                                      ),
                                    ),
                                  ),

                                ),





 */