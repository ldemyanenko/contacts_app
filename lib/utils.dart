import 'dart:convert';
import 'package:contacts_app/model/contact.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils{

  static Future<List<Contact>> readContactsFromAssets() async{
    String jsonStr = await rootBundle.loadString('assets/json/initial_contacts.json');
    List<dynamic> jsonList = json.decode(jsonStr);
    List<Contact> contacts = jsonList.map((e) => Contact.fromJson(e)).toList();
    return contacts;
  }

  static launchSms(String number) async {
    // Android
    String uri = "sms:$number";
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      String uri = "sms:$number";
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  static void shareContact(Contact contact) {
    Share.share("Nome: ${contact.name} \nTel: ${contact.phoneNumber} \nAddress: ${contact.streetAddress1}");
  }
}