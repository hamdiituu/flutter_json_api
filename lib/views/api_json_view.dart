import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_json_api/models/user_model.dart';

class ApiJsonView extends StatefulWidget {
  const ApiJsonView({Key? key}) : super(key: key);

  @override
  _ApiJsonViewState createState() => _ApiJsonViewState();
}

class _ApiJsonViewState extends State<ApiJsonView> {
  Future<List<User>> getUsers() async {
    try {
      var response =
          await Dio().get('https://jsonplaceholder.typicode.com/users');
      if (response.statusCode == 200) {
        List<User> model =
            (response.data as List).map((e) => User.fromJson(e)).toList();
        return model;
      }
      throw Future.error('Bir Hata Oluştu!');
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    getUsers();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Api JSON'),
        ),
        body: FutureBuilder<List<User>>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var userList = snapshot.data!;
              return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    User user = userList[index];
                    return ListTile(
                      title: Text(user.name),
                      leading: Icon(Icons.person),
                      subtitle: Text(user.phone),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('Hata Oluştu!');
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
          future: getUsers(),
        ));
  }
}
