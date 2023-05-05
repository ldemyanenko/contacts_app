import 'package:contacts_app/bloc/contacts_bloc.dart';
import 'package:contacts_app/model/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:contacts_app/utils.dart';

class ContactPage extends StatelessWidget {
  final Contact contact;

  const ContactPage({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, kToolbarHeight),
            child: AppBar(
              elevation: 0,
              actions: <Widget>[
                IconButton(
                  color: Colors.white,
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    context.pushNamed('edit_contact', pathParameters: <String, String>{'id': contact.contactID}, extra: contact);
                  },
                ),
                IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      Utils.shareContact(contact);
                    }),
                IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text("Removing an contact"),
                                content: const Text("Are you sure you want to delete this contact?"),
                                actions: [
                                  TextButton(
                                    child: const Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).maybePop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text("OK"),
                                    onPressed: () {
                                      GoRouter.of(context).pop();
                                      GoRouter.of(context).pop();
                                      context.read<ContactsBloc>().add(RemoveContact(contact));
                                    },
                                  )
                                ],
                              ));
                    }),
              ],
            )),
        body: content(context));
  }

  ListView content(context) {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            buildHeader(context, contact.name),
            buildInformation(contact.phoneNumber, contact.phoneNumber, contact.name),
          ],
        )
      ],
    );
  }

  Padding buildInformation(phoneNumber, email, nome) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text(phoneNumber),
              subtitle: const Text(
                "Phone",
                style: TextStyle(color: Colors.black54),
              ),
              leading: IconButton(
                icon: const Icon(Icons.phone, color: Colors.indigo),
                onPressed: () {
                  //_launchCaller(phoneNumber);
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.message),
                onPressed: () {
                  Utils.launchSms(phoneNumber);
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(contact.state),
                      const Text(
                        "state",
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(contact.zipCode),
                      const Text(
                        "zip code",
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(contact.city),
                      const Text(
                        "City",
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                    ],
                  )
                ],
              ),
              leading: IconButton(icon: const Icon(Icons.location_city, color: Colors.indigo), onPressed: () {}),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(contact.streetAddress1),
              subtitle: const Text(
                "Address",
                style: TextStyle(color: Colors.black54),
              ),
              leading: IconButton(
                icon: const Icon(Icons.location_on_rounded, color: Colors.indigo),
                onPressed: () {
                  //_launchCaller(phoneNumber);
                },
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(contact.streetAddress2.isEmpty ? "(empty)" : contact.streetAddress2),
              subtitle: const Text(
                "Alternative address",
                style: TextStyle(color: Colors.black54),
              ),
              leading: IconButton(
                icon: const Icon(Icons.location_on_outlined, color: Colors.indigo),
                onPressed: () {
                  //_launchCaller(phoneNumber);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildHeader(BuildContext context, String name) {
    return Container(
      decoration: const BoxDecoration(color: Colors.indigo),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.40,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 40),
          const Icon(
            Icons.person,
            color: Colors.white,
            size: 160,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
