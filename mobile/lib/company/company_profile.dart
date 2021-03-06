import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyProfilePage extends StatefulWidget {
  final dynamic company;

  const CompanyProfilePage({Key? key, this.company}) : super(key: key);

  @override
  State<CompanyProfilePage> createState() => _CompanyProfilePageState();
}

class _CompanyProfilePageState extends State<CompanyProfilePage> {
  final _baseUrl = 'http://192.168.1.29:5000/companies';

  @override
  void initState() {
    super.initState();
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

  String formatter(String url) {
    return _baseUrl + url;
  }

  NetworkImage getImage(String imageUrl) {
    String url = formatter(imageUrl);
    return NetworkImage(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Profile'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${widget.company['companyName']}",
                  style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.blueGrey,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "${widget.company['province']}, ${widget.company['country']}",
              style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                            title: const Text(
                              'Hiring Fields',
                              textAlign: TextAlign.center,
                            ),
                            content: Container(
                                width: 300.0,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        widget.company['companyFields'].length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(widget
                                            .company['companyFields'][index]),
                                      );
                                    })));
                      });
                },
                child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      "Hiring Fields",
                      style: TextStyle(
                          letterSpacing: 2.0, fontWeight: FontWeight.w300),
                    ))),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  "${widget.company['description']}",
                  style: const TextStyle(fontWeight: FontWeight.w300),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                    onPressed: () {
                      try {
                        _launchPhoneCall('tel:${widget.company['contact']}');
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
                    icon: const Icon(Icons.call),
                    label: const Text('Call user')),
                TextButton.icon(
                    onPressed: () {
                      try {
                        _launchEmail('mailto:${widget.company['email']}');
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
                    icon: const Icon(Icons.email),
                    label: const Text('Send mail')),
                TextButton.icon(
                    onPressed: () {
                      String addressToCopy =
                          '${widget.company['address']}, ${widget.company['city']}, ${widget.company['province']}, ${widget.company['country']}';

                      Clipboard.setData(ClipboardData(text: addressToCopy));
                      Fluttertoast.showToast(
                          msg: 'Address copied to clipboard',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 14.0);
                    },
                    icon: const Icon(Icons.map),
                    label: const Text('Copy address')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
