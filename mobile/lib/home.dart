import 'package:flutter/material.dart';
import 'package:mobile/services/api_services.dart';
import 'package:mobile/services/shared_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () => SharedService.logout(context),
              icon: Icon(Icons.logout))
        ],
      ),
      body: users(),
    );
  }

  Widget users() {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<String> model) {
        if (model.hasData) {
          return Center(
            child: Text(model.data!),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      future: APIService.getUsersProfile(),
    );
  }
}
