import 'package:contacts_app/bloc/contacts_bloc.dart';
import 'package:contacts_app/model/contact.dart';
import 'package:contacts_app/ui/page/update_comtact_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddContactPageState();
  }
}

class AddContactPageState extends UpdateContactPageState<AddContactPage> {
  @override
  String get pageTitle => "Add contact";

  @override
  Widget get mainButton => IconButton(
      icon: const Text(
        'Save',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        if (formKey.currentState?.validate() == true) {
          var contact = Contact(
              contactID: const Uuid().v1(),
              firstName: cFirstName.text,
              lastName: cLastName.text,
              phoneNumber: cPhoneNumber.text.replaceAll("+", "").replaceAll("(", "-").replaceAll(" ", "").replaceAll(")", "-"),
              streetAddress1: cAddress.text,
              streetAddress2: cAddress2.text,
              city: cCity.text,
              state: cState.text,
              zipCode: cZip.text);

          GoRouter.of(context).pop();
          context.read<ContactsBloc>().add(AddContact(contact));
        }
      });
}
