import 'dart:convert';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:jokes_app/Constants/constants.dart';
import 'package:jokes_app/Models/jokes_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///Var
  String _linkAPI = 'https://api.chucknorris.io/jokes/random';

  ///Method
  Future<JokesModel> fetchData() async {
    JokesModel jokesModel;
    http.Response response = await http.get(Uri.parse(_linkAPI));
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    jokesModel = JokesModel.fromJson(jsonResponse);
    return jokesModel;
  }

  ///Init State
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///Size
    final Size s = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Jokes App'),
      ),
      body: Container(
        height: s.height,
        width: s.width,
        child: FutureBuilder<JokesModel>(
          future: fetchData(),
          builder: (BuildContext context, AsyncSnapshot<JokesModel> snapshot) {
            ///Assigned Variable
            final v = snapshot.data;

            ///Conditions
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: s.height * 0.60,
                  width: s.width,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${v.value}",
                            style: GoogleFonts.lateef(
                              textStyle: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.share)),
                            IconButton(
                              onPressed: () {
                                FlutterClipboard.copy(v.value).then(
                                  (value) => showToastMsg(
                                    "Copied Text Successfully!",
                                  ),
                                );
                              },
                              icon: Icon(Icons.copy),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Created at : ${v.createdAt}",
                        style: GoogleFonts.lateef(
                          textStyle: TextStyle(
                            fontSize: 20.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Updated at : ${v.updatedAt}",
                        style: GoogleFonts.lateef(
                          textStyle: TextStyle(
                            fontSize: 20.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
