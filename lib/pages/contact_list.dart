import 'package:flutter/material.dart';
import 'package:pago_movil_bdv/models/Contact.dart';
import 'package:pago_movil_bdv/pages/contact_item.dart';
import 'package:pago_movil_bdv/utils/list_contact.dart';

class ContactList extends StatelessWidget {
  final Future<List<ContactModel>> _contacts;
  ContactList(this._contacts);

  @override
  Widget build(BuildContext context) {

    var futureBuilder = new FutureBuilder(
      future: list_contact(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Text('loading...');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return createListView(context, snapshot);
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Pago Clave BDV'),
      ),
      body: futureBuilder,
    );
  }
  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<ContactModel> values = snapshot.data;
    print(values);
    List<ContactItem> _buildContactList(){

      return values
          .map((contact) => ContactItem(contact)).toList();

    }
    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return ContactItem(values[index]);
      },
    );
  }

}
