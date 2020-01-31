import 'dart:convert';
import 'showProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 1;

  Future<Map> _getAPI() async {
    http.Response res = await http
        .get('https://rickandmortyapi.com/api/character/?page=$_page');
    return json.decode(res.body);
  }

  @override
  void initState() {
    super.initState();
    _getAPI().then((p) => print(p));
  }

  List data;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: Image.asset(
            'images/image_back.jpg',
            width: 400,
            fit: BoxFit.fitWidth,
          ),
        ),
        FutureBuilder(
          future: _getAPI(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Material(
                type: MaterialType.transparency,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'images/Squanchy_.png',
                      width: 150,
                      height: 150,
                    ),
                    Text(
                      "Loading...",
                      style: GoogleFonts.bangers(
                          color: Colors.white,
                          textStyle: TextStyle(fontSize: 35)),
                    ),
                  ],
                )),
              );
            } else {
              data = snapshot.data['results'];
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    floating: false,
                    pinned: false,
                    expandedHeight: 150.0,
                    backgroundColor: Colors.transparent,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      background: Image.asset(
                        'images/card_bar.png',
                        height: 150,
                        width: 333,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Hero(
                        tag: data[index]['id'],
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: GestureDetector(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 6)),
                                child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: data[index]['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ShowProfile(data, index)));
                            },
                          ),
                        ),
                      );
                    }, childCount: data.length),
                  ),
                  SliverToBoxAdapter(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _page > 1
                          ? RawMaterialButton(
                              fillColor: Colors.yellow,
                              child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(
                                        Icons.arrow_back,
                                        color: Colors.blue,
                                        size: 30,
                                      ),
                                      Text(
                                        'BACK',
                                        style: GoogleFonts.bangers(
                                          color: Colors.blue,
                                          textStyle: TextStyle(fontSize: 30),
                                        ),
                                      ),
                                    ],
                                  )),
                              onPressed: () {
                                setState(() {
                                  _page--;
                                });
                              },
                              shape: StadiumBorder(),
                            )
                          : Container(),
                      _page < 25
                          ? RawMaterialButton(
                              fillColor: Colors.yellow,
                              child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'NEXT',
                                        style: GoogleFonts.bangers(
                                          color: Colors.blue,
                                          textStyle: TextStyle(fontSize: 30),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.blue,
                                        size: 30,
                                      ),
                                    ],
                                  )),
                              onPressed: () {
                                setState(() {
                                  _page++;
                                });
                              },
                              shape: StadiumBorder(),
                            )
                          : Container(),
                    ],
                  ))
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
