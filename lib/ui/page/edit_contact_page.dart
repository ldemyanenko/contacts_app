import 'package:contacts_app/bloc/contacts_bloc.dart';
import 'package:contacts_app/model/contact.dart';
import 'package:contacts_app/ui/page/update_comtact_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditContactPage extends StatefulWidget {
  final Contact contact;

  const EditContactPage({Key? key, required this.contact}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EditContactPageState();
  }
}

class EditContactPageState extends UpdateContactPageState<EditContactPage> {
  @override
  void initState() {
    cFirstName.text = widget.contact.firstName;
    cLastName.text = widget.contact.lastName;
    cPhoneNumber.text = widget.contact.phoneNumber;
    cFirstName.text = widget.contact.firstName;
    cAddress.text = widget.contact.streetAddress1;
    cAddress2.text = widget.contact.streetAddress2;
    cCity.text = widget.contact.city;
    cState.text = widget.contact.state;
    cZip.text = widget.contact.zipCode;

    super.initState();
  }

  @override
  Widget get mainButton => IconButton(
      icon: const Text(
        'Update',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        if (formKey.currentState?.validate() == true) {
          var contact = widget.contact.copyWith(
              firstName: cFirstName.text,
              lastName: cLastName.text,
              phoneNumber: cPhoneNumber.text.replaceAll("+", "").replaceAll("(", "-").replaceAll(" ", "").replaceAll(")", "-"),
              streetAddress1: cAddress.text,
              streetAddress2: cAddress2.text,
              city: cCity.text,
              state: cState.text,
              zipCode: cZip.text);

          GoRouter.of(context).pop();
          GoRouter.of(context).pop();
          context.read<ContactsBloc>().add(UpdateContact(contact));
        }
      });

  @override
  String get pageTitle => "Edit contact";
}
