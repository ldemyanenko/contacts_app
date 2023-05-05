import 'package:contacts_app/bloc/contacts_bloc.dart';
import 'package:contacts_app/ui/item/contact_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              context.pushNamed(
                'add_contact',
              );
            },
            child: const Text(
              "ADD CONTACT",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ContactsBloc, ContactsState>(
        builder: (BuildContext context, state) {
          if (state is InitialState) {
            // add ContactsLoadInProgressState  || when needed
            return const Center(child: CircularProgressIndicator());
          }

          var contacts = (state as ContactsLoadedState).contacts;

          return ListView(
            children: contacts.map((e) => ContactItem(contact: e)).toList(),
          );
        },
      ),
    );
  }
}
