import 'package:flutter/material.dart';
import 'package:pago_movil_bdv/models/Contact.dart';
import 'package:pago_movil_bdv/main.dart';
import 'package:pago_movil_bdv/utils/delete_contact.dart';
import 'package:pago_movil_bdv/pages/contact_list.dart';
import 'package:pago_movil_bdv/pages/contact_update.dart';

class ContactItem extends StatefulWidget {
  final ContactModel _contact;
  ContactItem(this._contact);

  @override
  _ContactItemState createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  bool selected = false;


  void _showAlert(String value) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            content: new Text(value),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UpdateContact(contact: widget._contact)
                      ));
                },
                child: new Text('Editar'),
              ),
              new FlatButton(
                onPressed: () {
                  delete_contact(widget._contact.id);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ContactList(delete: true)
                      ));
                },
                child: new Text('Eliminar'),
              )
            ],
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      onLongPress: (){
        setState(() {
          selected = !selected;
        });
        _showAlert('Acciones');
      },
      onTap: () {
        Map<String,String> data = {
          'codeBank': widget._contact.codeBank,
          'codeMobile': widget._contact.codeMobile,
          'mobile': widget._contact.mobile,
          'dni': widget._contact.dni,
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
        child: Text(widget._contact.name[0].toUpperCase()),
      ),
      title: Text(
          widget._contact.name[0].toUpperCase() + '' + widget._contact.name.substring(1)),
      subtitle: Text(
          widget._contact.codeBank + '  ' + widget._contact.codeMobile + widget._contact.mobile +
              '  ' + widget._contact.dni),
    );
  }
}
