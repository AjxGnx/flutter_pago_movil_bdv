import 'package:flutter/material.dart';
import 'package:pago_movil_bdv/models/Contact.dart';
import 'package:pago_movil_bdv/main.dart';

class ContactItem extends StatelessWidget {
  final ContactModel _contact;

  ContactItem(this._contact);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Map<String,String> data = {
          'codeBank': _contact.codeBank,
          'codeMobile': _contact.codeMobile,
          'mobile': _contact.mobile,
          'dni': _contact.dni,
        };
        Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) =>
              Home(data:data)
        ));
      },
      leading: CircleAvatar(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        child: Text(_contact.name[0].toUpperCase()),
      ),
      title: Text(
          _contact.name[0].toUpperCase() + '' + _contact.name.substring(1)),
      subtitle: Text(
          _contact.codeBank + '  ' + _contact.codeMobile + _contact.mobile +
              '  ' + _contact.dni),
    );
  }
}
