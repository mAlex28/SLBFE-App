import 'package:flutter/material.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/services/api_services.dart';
import 'package:mobile/services/shared_services.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _complainTopicController =
      TextEditingController();
  final TextEditingController _complainDespController = TextEditingController();

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
    return Drawer(
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
    ));
  }
}
