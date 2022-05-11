import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/citizen/citizen_profile.dart';
import 'package:mobile/custom/cutom_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _baseUrl = 'http://192.168.1.29:5000/citizens';

  int _page = 1;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  List _citizens = [];

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await http.get(Uri.parse("$_baseUrl?page=$_page"));
      setState(() {
        var bodyData = json.decode(res.body);
        _citizens = bodyData['data'];
      });
    } catch (err) {
      print('Something went wrong');
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      _page += 1;
      try {
        final res = await http.get(Uri.parse("$_baseUrl?_page=$_page"));

        final List fetchedCitizens = json.decode(res.body);
        if (fetchedCitizens.isNotEmpty) {
          setState(() {
            _citizens.addAll(fetchedCitizens);
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        print('load Something went wrong!');
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  void _launchEmail(url) async {
    var newUrl = Uri.parse(url);
    if (await canLaunchUrl(newUrl)) {
      await launchUrl(newUrl);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchPhoneCall(url) async {
    var newUrl = Uri.parse(url);

    if (await canLaunchUrl(newUrl)) {
      await launchUrl(newUrl);
    } else {
      throw 'Could not launch $url';
    }
  }

  // The controller for the ListView
  late ScrollController _controller;

  @override
  void initState() {
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Citizens'),
      ),
      drawer: const CustomDrawer(),
      backgroundColor: const Color(0xfff1f2f6),
      body: _isFirstLoadRunning
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: _citizens.length,
                    itemBuilder: (_, index) => Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 8.0, right: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CitizenProfilePage(
                                        citizen: _citizens[index],
                                      )));
                        },
                        child: Card(
                          elevation: 4,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: Text(_citizens[index]['name']),
                                subtitle: Text(_citizens[index]['profession']),
                                trailing: _citizens[index]['isVerified']
                                    ? const Icon(
                                        Icons.verified,
                                        color: Colors.green,
                                        semanticLabel: 'Verified',
                                      )
                                    : const Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                        semanticLabel: 'Not Verified',
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  _citizens[index]['description'],
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: List.from(
                                        _citizens[index]['qualifications'].map(
                                          (value) => Text(
                                            '${value.split(',')}',
                                            style: const TextStyle(
                                                color: Colors.grey),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                          ),
                                        ),
                                      ))),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  IconButton(
                                    icon: const Icon(Icons.call),
                                    onPressed: () {
                                      try {
                                        _launchPhoneCall(
                                            'tel:${_citizens[index]['contact']}');
                                      } catch (e) {
                                        Fluttertoast.showToast(
                                            msg: 'Could not launch phone',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.grey,
                                            textColor: Colors.white,
                                            fontSize: 14.0);
                                      }
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    icon: const Icon(Icons.email),
                                    onPressed: () {
                                      try {
                                        _launchEmail(
                                            'mailto:${_citizens[index]['email']}');
                                      } catch (e) {
                                        Fluttertoast.showToast(
                                            msg: 'Could not launch email',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.grey,
                                            textColor: Colors.white,
                                            fontSize: 14.0);
                                      }
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // when the _loadMore function is running
                if (_isLoadMoreRunning == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),

                // When nothing else to load
                if (_hasNextPage == false)
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                    color: Colors.amber,
                    child: const Center(
                      child: Text('All citizens are fetched'),
                    ),
                  ),
              ],
            ),
    );
  }
}
