import 'package:flutter/material.dart';
import 'package:mobile/services/api_services.dart';
import 'package:mobile/services/shared_services.dart';

class CompanyHomePage extends StatefulWidget {
  const CompanyHomePage({Key? key}) : super(key: key);

  @override
  State<CompanyHomePage> createState() => _CompanyHomePageState();
}

class _CompanyHomePageState extends State<CompanyHomePage> {
  bool isVerified = false;

//TODO: qualifications
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Companies'),
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
            leading: Icon(Icons.account_circle),
            title: Text('Citizens'),
            onTap: () {
              Navigator.pop(context); // close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.business_rounded),
            title: Text('Companies'),
            onTap: () {
              Navigator.pop(context); // close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.comment),
            title: Text('Complain'),
            onTap: () {
              Navigator.pop(context); // close the drawer
            },
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
