import 'package:objectbox/objectbox.dart';

@Entity()
class Contact {
  @Id(assignable: true)
  int id;
  final String contactID;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String streetAddress1;
  final String streetAddress2;
  final String city;
  final String state;
  final String zipCode;

  Contact({
    this.id = 0,
    required this.contactID,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.streetAddress1,
    required this.streetAddress2,
    required this.city,
    required this.state,
    required this.zipCode,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      contactID: json['contactID'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      streetAddress1: json['streetAddress1'],
      streetAddress2: json['streetAddress2'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zipCode'],
    );
  }

  get name => "$firstName $lastName";

  Map<String, dynamic> toJson() {
    return {
      'contactID': contactID,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'streetAddress1': streetAddress1,
      'streetAddress2': streetAddress2,
      'city': city,
      'state': state,
      'zipCode': zipCode,
    };
  }

  Contact copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? streetAddress1,
    String? streetAddress2,
    String? city,
    String? state,
    String? zipCode,
  }) {
    return Contact(
        contactID: contactID,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        streetAddress1: streetAddress1 ?? this.streetAddress1,
        streetAddress2: streetAddress2 ?? this.streetAddress2,
        city: city ?? this.city,
        state: state ?? this.state,
        zipCode: zipCode ?? this.zipCode,
        id: id);
  }
}
