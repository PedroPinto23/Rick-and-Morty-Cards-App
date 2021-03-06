import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowProfile extends StatelessWidget {
  final List data;

  final int i;

  ShowProfile(this.data, this.i);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 255, 210, 38),
          Color.fromARGB(255, 25, 217, 253)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        padding: EdgeInsets.all(10),
        child: Card(
            borderOnForeground: true,
            color: Colors.yellow,
            child: Container(
                padding: EdgeInsets.all(20),
                child: ListView(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              data[i]['name'],
                              style: GoogleFonts.bangers(
                                  color: Colors.blue,
                                  textStyle: TextStyle(fontSize: 42)),
                            ),
                            Text(
                              'origin location: ' + data[i]['origin']['name'],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.acme(
                                  color: Colors.blue,
                                  textStyle: TextStyle(fontSize: 22)),
                            ),
                            Divider(),
                            Hero(
                              tag: data[i]['id'],
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.blue, width: 5)),
                                  child: Image.network(
                                    data[i]['image'],
                                    height: 180,
                                    width: 180,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Text(
                          'Status: ' + data[i]['status'],
                          style: GoogleFonts.acme(
                              color: Colors.blue,
                              textStyle: TextStyle(fontSize: 22)),
                        ),
                        Divider(),
                        Text(
                          'Species: ' + data[i]['species'],
                          style: GoogleFonts.acme(
                              color: Colors.blue,
                              textStyle: TextStyle(fontSize: 22)),
                        ),
                        Divider(),
                        Text(
                          'Gender: ' + data[i]['gender'],
                          style: GoogleFonts.acme(
                              color: Colors.blue,
                              textStyle: TextStyle(fontSize: 22)),
                        ),
                        Divider(),
                        Text(
                          'Location: ' + data[i]['location']['name'],
                          style: GoogleFonts.acme(
                              color: Colors.blue,
                              textStyle: TextStyle(fontSize: 22)),
                        ),
                        Divider(),
                        RawMaterialButton(
                          fillColor: Colors.blue,
                          child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.arrow_back,
                                    color: Colors.yellow,
                                    size: 30,
                                  ),
                                  Text(
                                    'BACK',
                                    style: GoogleFonts.bangers(
                                      color: Colors.yellow,
                                      textStyle: TextStyle(fontSize: 28),
                                    ),
                                  ),
                                ],
                              )),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          shape: StadiumBorder(),
                        )
                      ],
                    ),
                  ],
                ))));
  }
}
