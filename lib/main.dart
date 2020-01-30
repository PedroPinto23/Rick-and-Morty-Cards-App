import 'dart:convert';
import 'src/showProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

void main() {
  runApp(MaterialApp(
    title: 'RICK AND MORTY CARDS', 
    home: HomeScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
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
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro ao carregar os dados'),
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
                          child: Column(
                        children: <Widget>[
                          _page < 25
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    RawMaterialButton(
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
                                                  textStyle:
                                                      TextStyle(fontSize: 30),
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
                                  ],
                                )
                              : Container(),
                          Divider(),
                          _page > 1
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    RawMaterialButton(
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
                                                  textStyle:
                                                      TextStyle(fontSize: 30),
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
                                  ],
                                )
                              : Container(),
                        ],
                      ))
                    ],
                  );
                }
            }
          },
        ),
      ],
    );
  }
}
