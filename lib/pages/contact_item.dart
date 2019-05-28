import 'package:flutter/material.dart';
import 'package:pago_movil_bdv/models/Contact.dart';

class ContactItem extends StatelessWidget {
  final ContactModel _contact;
  ContactItem(this._contact);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        print(_contact.name);
      },
      leading: CircleAvatar(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        child: Text(_contact.name[0]),
      ),
      title: Text(_contact.name),
      subtitle: Text(_contact.codeBank+'  '+ _contact.phone+'  '+ _contact.dni),
    );
  }
}
