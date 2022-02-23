import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:jokes_app/Models/jokes_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///Var
  String apiURL = 'https://api.chucknorris.io/jokes/random';

  ///Map
  Map data;

  ///Method
  Future<JokesModel> fetchData() async {
    JokesModel jokesModel;
    http.Response response = await http.get(Uri.parse(apiURL));
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
        title: Text('Jokes Application'),
      ),
      body: Container(
        height: s.height,
        width: s.width,
        child: FutureBuilder<JokesModel>(
          future: fetchData(),
          builder: (BuildContext context, AsyncSnapshot<JokesModel> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final v = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: s.height * 0.60,
                  width: s.width,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
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
                                onPressed: () {}, icon: Icon(Icons.copy)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                    ),
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
              ],
            );
          },
        ),
      ),
    );
  }
}
/*
                
                Text('1 ${val.categories}'),
                
                Text('2 ${val.createdAt}'),
                
                Text('3 ${val.iconUrl}'),
                
                Text('4 ${val.id}'),
                
                Text('5 ${val.updatedAt}'),
                
                Text('6 ${val.url}'),
                
                Text('7 ${val.value}'),
                
                Image.network(val.iconUrl, height: 100),
                

*/
