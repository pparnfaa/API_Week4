import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api_week4/model/user_data.dart';

class SimpleApiCall extends StatefulWidget {
  const SimpleApiCall({super.key});

  @override
  State<SimpleApiCall> createState() => _SimpleApiCallState();
}

class _SimpleApiCallState extends State<SimpleApiCall> {
  List<UserData> users = [];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users/'));
          
      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> jsonList = jsonDecode(response.body);
        
        setState(() {
          users = jsonList.map((item) => UserData.fromJson(item)).toList();
        });

        //print(users);
      } else {
        print('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple API Call')),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            leading: Text('${users[index].id}'),
            title: Text('${users[index].name}'),
            subtitle: Text('${users[index].email}'),
            trailing: Text('${users[index].username}'),
          );
        }
      ),
    );
  }
}