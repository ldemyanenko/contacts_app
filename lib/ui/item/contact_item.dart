import 'package:contacts_app/model/contact.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;

  const ContactItem({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      leading: CircleAvatar(
        child: Text(
          contact.name.substring(0, 1).toUpperCase(),
          style: const TextStyle(fontSize: 26, color: Colors.white60),
        ),
      ),
      title: Text(
        contact.name,
        style: const TextStyle(fontSize: 17),
      ),
      subtitle: contact.phoneNumber.toString().isNotEmpty ? Text(contact.phoneNumber) : null,
      onTap: () {
        context.pushNamed('contact', pathParameters: <String, String>{'id': contact.contactID}, extra: contact);
      },
    );
  }
}
