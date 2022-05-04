import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/services/api_services.dart';
import 'package:mobile/services/shared_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isVerified = false;
//TODO: qualifications

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _complainTopicController =
      TextEditingController();
  final TextEditingController _complainDespController = TextEditingController();

  // Future _complain(email, complainTitle, complainText) async {
  //   Response response = await post(
  //       Uri.parse('http://192.168.1.29:5000/citizen/complains'),
  //       body: {
  //         "email": email,
  //         "complainTitle": complainTitle,
  //         "complainText": complainText,
  //       });

  //   if (response.statusCode == 201) {
  //     print('success');
  //   } else {
  //     print(response.statusCode);
  //   }
  // }

  Future _complainDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text(
              'Add a complain',
              textAlign: TextAlign.center,
            ),
            content: SizedBox(
              height: 300,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                        autofocus: true,
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            hintText: 'Email address')),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                        controller: _complainTopicController,
                        autofocus: true,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            hintText: 'What are you complaining?')),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                        controller: _complainDespController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        maxLength: 1000,
                        autofocus: true,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            hintText: 'Describe your complain')),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () async {
                    APIService.makeComplains(
                            _emailController.text.trim(),
                            _complainTopicController.text.trim(),
                            _complainDespController.text.trim())
                        .then((value) => Navigator.of(context).pop());

                    _emailController.clear();
                    _complainTopicController.clear();
                    _complainDespController.clear();
                  },
                  child: const Text('Submit')),
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () => SharedService.logout(context),
              icon: const Icon(Icons.logout))
        ],
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(
            height: 120.0,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'SLBFE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Citizens'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, homeRoute, (route) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.business_rounded),
            title: const Text('Companies'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, companyHomeRoute, (route) => false);
            },
          ),
          ListTile(
            leading: const Icon(Icons.comment),
            title: const Text('Complain'),
            onTap: () async {
              await _complainDialog();
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_rounded),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context); // close the drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text('Logout'),
            onTap: () => SharedService.logout(context),
          ),
        ],
      )),
      backgroundColor: const Color(0xfff1f2f6),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
        child: users(),
      ),
    );
  }

  Widget users() {
    return Card(
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            title: Text('Alex Smith'),
            subtitle: Text('Software engineer'),
            trailing: Icon(
              Icons.verified,
              color: Colors.green,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.call),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.email),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
    //   return FutureBuilder(
    //     builder: (context, AsyncSnapshot<String> model) {
    //       print(model.hasError);
    //       if (model.hasData) {
    //         // print(model.data);
    //         return Center(
    //           child: Text(model.data!),
    //         );
    //       } else {
    //         return Center(
    //           child: Text("Cannot get data"),
    //         );
    //       }

    //       // switch (model.connectionState) {
    //       //   case ConnectionState.waiting:
    //       //   case ConnectionState.active:

    //       //   default:
    //       //     return const Center(
    //       //       child: CircularProgressIndicator(),
    //       //     );
    //       // }
    //     },
    //     future: APIService.getUsersProfile(),
    //   );
  }
}
