import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:application_task/data/core/api_constants.dart';
import 'package:application_task/data/model/countries.dart';
import 'package:application_task/data/model/user.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();
  String  name = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( name.isEmpty ? 'Profile' : 'Home Screen'),
        centerTitle: true,
      ),
        body: name.isEmpty ? Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(12.0),
                child : TextField(
                  controller: controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Your Name',
                    hintText: 'Enter Your Name',
                  ),
                )
            ),
            ElevatedButton(
              onPressed: () {
                name = controller.text.toString();
                setState(() {

                });
              },
              child: Text('Next'),
            )
          ],
        ) : Column(
          mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FutureBuilder<User>(
                  future: getUser(name),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Name: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              Text('Gender: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              Text('Probability: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              Text('Count: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(snapshot.data!.name, style: TextStyle(fontSize: 16,),),
                              Text(snapshot.data!.gender, style: TextStyle(fontSize: 16,),),
                              Text(snapshot.data!.probability.toString(), style: TextStyle(fontSize: 16,),),
                              Text(snapshot.data!.count.toString(), style: TextStyle(fontSize: 16,),),
                            ],
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    // By default, show a loading spinner.
                    return Container();
                  },
                ),
                FutureBuilder<Countries>(
                  future: getCountry(name),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text('Country Flags: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          SizedBox(height: 16,),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              for(int i = 0; i < snapshot.data!.countryList.length; i++)
                                Image.network('https://flagcdn.com/16x12/${snapshot.data!.countryList[i].country_id.toLowerCase()}.png')


                            ],
                          )

                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return Container();
                  },
                )
              ],
            ),
    );
  }

  Future<User> getUser(String name) async {
    final response = await http
        .get(Uri.parse(ApiConstants.BASE_URL+'?name=$name'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<Countries> getCountry(String name) async {
    final response = await http
        .get(Uri.parse(ApiConstants.CONTRY_URL+'?name=$name'));

    if (response.statusCode == 200) {
      return Countries.fromJson(jsonDecode(response.body)['country']);
    } else {
      throw Exception('Failed to load Contries');
    }
  }
}
