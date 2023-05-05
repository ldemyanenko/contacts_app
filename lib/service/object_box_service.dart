import 'package:contacts_app/objectbox.g.dart';
import 'package:contacts_app/utils.dart';
import 'package:contacts_app/model/contact.dart';
import 'package:contacts_app/service/db_service.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ObjectBoxService extends DBService {
  late final Store _store;

  /// Initializes the ObjectBox Store object.
  Future<void> initStore() async {
    final appDocumentsDirextory = await getApplicationDocumentsDirectory();
    _store = Store(
      getObjectBoxModel(),
      directory: path.join(appDocumentsDirextory.path, 'contacts-db'),
    );

    return;
  }

  /// Getter for the store object.
  Store get store => _store;

  @override
  Future initialise() async {
    var contacts = await Utils.readContactsFromAssets();
    final box = store.box<Contact>();
    box.putMany(contacts.reversed.toList()); // reverse the order so the latest one had the hirghest id
    return;
  }

  @override
  Future<List<Contact>> loadContacts() async {
    final box = store.box<Contact>();
    var contacts = box.getAll();
    return contacts.reversed.toList(); //reverse the order to show the latest on the top
  }

  @override
  void removeContact(Contact contact) {
    final box = store.box<Contact>();
    box.remove(contact.id);
  }

  @override
  void insertContact(Contact contact) {
    final box = store.box<Contact>();
    box.put(contact);
  }

  @override
  void updateContact(Contact contact) {
    final box = store.box<Contact>();
    box.put(contact);
  }
}
