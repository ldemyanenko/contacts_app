import 'package:contacts_app/bloc/contacts_bloc.dart';
import 'package:contacts_app/model/contact.dart';
import 'package:contacts_app/service/db_service.dart';
import 'package:contacts_app/service/shared_preferences_service.dart';
import 'package:contacts_app/service_locator.dart';
import 'package:contacts_app/ui/page/add_contact_page.dart';
import 'package:contacts_app/ui/page/contact_page.dart';
import 'package:contacts_app/ui/page/edit_contact_page.dart';
import 'package:contacts_app/ui/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await locator<SharedPrefService>().init();
  await locator<DBService>().initStore();

  runApp(const ContactsApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          name: "contact",
          path: 'contact/:id',
          builder: (BuildContext context, GoRouterState state) {
            return ContactPage(contact: state.extra as Contact);
          },
        ),
        GoRoute(
          name: "add_contact",
          path: 'add_contact',
          builder: (BuildContext context, GoRouterState state) {
            return const AddContactPage();
          },
        ),
        GoRoute(
          name: "edit_contact",
          path: 'edit_contact/:id',
          builder: (BuildContext context, GoRouterState state) {
            return EditContactPage(contact: state.extra as Contact);
          },
        ),
      ],
    ),
  ],
);

class ContactsApp extends StatefulWidget {
  const ContactsApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return ContactsAppState();
  }
}

class ContactsAppState extends State<ContactsApp> {
  late ContactsBloc contactsBloc = ContactsBloc();

  @override
  void initState() {
    contactsBloc = ContactsBloc();
    contactsBloc.add(Initialisation());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => contactsBloc,
      child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Contacts app',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routerConfig: _router),
    );
  }
}
