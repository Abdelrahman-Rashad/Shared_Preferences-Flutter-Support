import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var namecontroller = new TextEditingController();
  String name = "";
  @override
  void initState() {
    loadname();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: namecontroller,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "name",
                    suffixIcon: Icon(Icons.person)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "$name",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  save(namecontroller.text.toString());
                },
                child: Text("save")),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    getname();
                  });
                },
                child: Text("get name")),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  delete();
                },
                child: Text("delete")),
          ],
        ),
      ),
    );
  }

  loadname() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString("name") ?? "";
    });
  }

  save(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("name", name);
    print(preferences.getString("name"));
  }

  getname() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString("name") ?? "error";
    });
  }

  delete() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = "";
    });
    preferences.remove("name");
  }
}
