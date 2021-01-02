import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class ReadMore extends StatefulWidget {
  String copyright;
  String date;
  String explanation;
  String url;
  String title;
  ReadMore({this.copyright,this.date,this.explanation,this.url,this.title});

  @override
  _ReadMoreState createState() => _ReadMoreState(
    copyright,
    date,
    explanation,
    url,
    title,
  );
}

class _ReadMoreState extends State<ReadMore> {
  String copyright;
  String date;
  String explanation;
  String url;
  String title;

  _ReadMoreState(
      this.copyright,
      this.date,
      this.explanation,
      this.url,
      this.title,

      );

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
          child: Column(
            children: [
              SizedBox(height: 30,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(url),
                    backgroundColor: Colors.transparent,
                  ),
                ],
              ),

              SizedBox(height: 80,),

              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 2,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:18.0),
                  child: Column(
                    children: [

                      Text(
                        '${title}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 40,
                          fontFamily: 'Playfair',
                        ),
                      ),

                      SizedBox(
                        height: 40,
                      ),

                      Row(

                        children: [

                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                  text: 'Date: ',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '${date}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),

                                    )
                                  ]

                              ),
                            ),
                          ),


                          Spacer(),

                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                  text: 'Copyright: ',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '${copyright}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),

                                    )
                                  ]

                              ),
                            ),
                          )



                        ],
                      ),

                      SizedBox(
                        height: 40,
                      ),

                      Text('${explanation}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 40,),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
