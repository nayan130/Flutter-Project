import 'package:flutter/material.dart';
import 'package:meal_system_management/model/member_model.dart';
import 'package:meal_system_management/provider/add_member_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class MemberDetails extends StatefulWidget {
  static const String routeName = '/member_details';

  @override
  State<MemberDetails> createState() => _MemberDetailsState();
}

class _MemberDetailsState extends State<MemberDetails> {
  late int id;

  @override
  void didChangeDependencies() {
    id = ModalRoute.of(context)!.settings.arguments as int;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Member details'),
      ),
      body: Center(
        child: Consumer<AddMemberProvider>(
          builder: (context, provider, _) => FutureBuilder<MemberInfo>(
              future: provider.getMemberDetailsById(id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final model = snapshot.data;
                  return ListView(
                    children: [
                      model!.image == null
                          ? Image.asset('images/login_place_holder.png')
                          : Card(
                              child: Image.file(
                                File(model.image!),
                                width: double.infinity,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                            child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                model.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      final url =
                                          Uri.parse('tel:${model.phone}');
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url);
                                      } else {
                                        throw 'Cannot Launch';
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.phone,
                                      color: Colors.green,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      final url =
                                          Uri.parse('sms:${model.phone}');
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url);
                                      } else {
                                        throw 'Cannot Launch';
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.message,
                                      color: Colors.green,
                                    ),
                                  ),
                                  Text(model.phone)
                                ],
                              ),
                            ),
                          ],
                        )),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Card(
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Text(
                      //               model.email!,
                      //             ),
                      //           ),
                      //           IconButton(
                      //             onPressed: () async {
                      //               final Uri emailLaunchUri = Uri(
                      //                 scheme: 'mailto',
                      //                 path: model.email,
                      //               );
                      //
                      //               launchUrl(emailLaunchUri);
                      //             },
                      //             icon: const Icon(
                      //               Icons.email,
                      //               color: Colors.green,
                      //             ),
                      //           ),
                      //         ],
                      //       )),
                      // ),
                    ],
                  );
                }
                if (snapshot.hasError) {
                  return const Text('Field fetch data');
                }
                return const CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}
