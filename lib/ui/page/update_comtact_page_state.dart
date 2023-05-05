import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

abstract class UpdateContactPageState<T extends StatefulWidget> extends State<T> {
  final formKey = GlobalKey<FormState>();
  final cFirstName = TextEditingController();
  final cLastName = TextEditingController();
  final cAddress = TextEditingController();
  final cPhoneNumber = TextEditingController();
  final cAddress2 = TextEditingController();
  final cCity = TextEditingController();
  final cState = TextEditingController();
  final cZip = TextEditingController();

  String get pageTitle;

  Widget get mainButton;

  @override
  Widget build(BuildContext context) {
    TextFormField inputFistName = TextFormField(
      controller: cFirstName,
      autofocus: true,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      inputFormatters: [
        LengthLimitingTextInputFormatter(45),
      ],
      decoration: const InputDecoration(
        labelText: 'Fist name',
        icon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value?.isEmpty == true) {
          return 'Required';
        }
        return null;
      },
    );

    TextFormField inputLastName = TextFormField(
      controller: cLastName,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      inputFormatters: [
        LengthLimitingTextInputFormatter(25),
      ],
      decoration: const InputDecoration(
        labelText: 'Last name',
        icon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value?.isEmpty == true) {
          return 'Required';
        }
        return null;
      },
    );

    TextFormField inputAddress1 = TextFormField(
      controller: cAddress,
      inputFormatters: [
        LengthLimitingTextInputFormatter(45),
      ],
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Address',
        icon: Icon(Icons.location_on),
      ),
      validator: (value) {
        if (value?.isEmpty == true) {
          return 'Required';
        }
        return null;
      },
    );

    var maskFormatter = MaskTextInputFormatter(mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

    TextFormField inputPhoneNumber = TextFormField(
      controller: cPhoneNumber,
      maxLength: 20,
      inputFormatters: [maskFormatter],
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        labelText: "Phone",
        icon: Icon(Icons.phone),
      ),
      validator: (value) {
        if (value?.isEmpty == true) {
          return 'Required';
        }
        return null;
      },
    );

    TextFormField inputAddress2 = TextFormField(
      controller: cAddress2,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Alternative address',
        icon: Icon(Icons.location_on_outlined),
      ),
    );

    TextFormField inputCity = TextFormField(
      controller: cCity,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
        labelText: 'City',
        icon: Icon(Icons.location_city),
      ),
    );

    TextFormField inputState = TextFormField(
      controller: cState,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
        labelText: 'State',
        icon: Icon(Icons.emoji_flags_outlined),
      ),
    );

    TextFormField inputZip = TextFormField(
      controller: cZip,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Zip',
        icon: Icon(Icons.mail),
      ),
    );

    final picture = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 120.0,
          height: 120.0,
          child: const CircleAvatar(
            child: Icon(
              Icons.person,
              size: 60,
            ),
          ),
        ),
      ],
    );

    ListView content = ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        const SizedBox(height: 20),
        picture,
        Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              inputFistName,
              inputLastName,
              inputPhoneNumber,
              inputAddress1,
              inputAddress2,
              inputCity,
              inputState,
              inputZip,
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(pageTitle),
        actions: <Widget>[
          Container(
            width: 80,
            child: mainButton,
          )
        ],
      ),
      body: content,
    );
  }
}
