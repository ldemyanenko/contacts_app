import 'package:contacts_app/model/contact.dart';

abstract class DBService {
  Future initialise();

  Future<List<Contact>> loadContacts();

  Future initStore();

  void removeContact(Contact contact);

  void insertContact(Contact contact);

  void updateContact(Contact contact);
}
