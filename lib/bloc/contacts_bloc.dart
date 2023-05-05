import 'package:contacts_app/model/contact.dart';
import 'package:contacts_app/service/db_service.dart';
import 'package:contacts_app/service/shared_preferences_service.dart';
import 'package:contacts_app/service_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  var dbService = locator<DBService>();
  var sharedPrefService = locator<SharedPrefService>();

  List<Contact> contacts = [];

  ContactsBloc() : super(InitialState()) {
    on<Initialisation>((event, emit) async {
      if (!sharedPrefService.readIsDbInitialised()) {
        await dbService.initialise();
        sharedPrefService.saveIsDbInitialised(true);
      }

      //emit(ContactsLoadInProgressState()); // It will be useful in case if reading contacts will be from another repository and be async. As for now there is no point in it
      contacts = await dbService.loadContacts();
      emit(ContactsLoadedState(List.from(contacts)));
    });

    on<RemoveContact>((event, emit) {
      dbService.removeContact(event.contact);
      contacts.remove(event.contact);
      emit(ContactsLoadedState(List.from(contacts)));
    });

    on<AddContact>((event, emit) {
      dbService.insertContact(event.contact);
      contacts.insert(0, event.contact);
      emit(ContactsLoadedState(List.from(contacts)));
    });

    on<UpdateContact>((event, emit) {
      dbService.updateContact(event.contact);
      var contact = event.contact;
      var index = contacts.indexWhere((item) => item.contactID == contact.contactID);
      contacts.removeAt(index);
      contacts.insert(index, contact);
      emit(ContactsLoadedState(List.from(contacts)));
    });
  }
}

abstract class ContactsEvent {}

class Initialisation extends ContactsEvent {}

class LoadContacts extends ContactsEvent {}

class AddContact extends ContactsEvent {
  final Contact contact;

  AddContact(this.contact);
}

class RemoveContact extends ContactsEvent {
  final Contact contact;

  RemoveContact(this.contact);
}

class UpdateContact extends ContactsEvent {
  final Contact contact;

  UpdateContact(this.contact);
}

abstract class ContactsState extends Equatable {}

class InitialState extends ContactsState {
  @override
  List<Object?> get props => [];
}

// class ContactsLoadInProgressState extends ContactsState {
//   @override
//   List<Object?> get props => [];
// }

class ContactsLoadedState extends ContactsState {
  final List<Contact> contacts;

  ContactsLoadedState(this.contacts);

  @override
  List<Object?> get props {
    return [contacts];
  }
}
