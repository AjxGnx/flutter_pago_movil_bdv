import 'package:flutter/material.dart';
import 'package:pago_movil_bdv/models/Contact.dart';
import 'package:pago_movil_bdv/pages/contact_item.dart';
import 'package:pago_movil_bdv/utils/list_contact.dart';
import 'package:pago_movil_bdv/main.dart';

class ContactList extends StatefulWidget {


  bool save;
  ContactList({this.save: false});

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {

  @override
  initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1)).then(
            (_) => showSnack()
    );
  }

  final snackbar = SnackBar(
    content: Text('Contacto Guardado con exito'),
    duration: Duration(seconds: 5),
  );
   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnack() {
    if(widget.save){
      _scaffoldKey.currentState.showSnackBar(snackbar);
  }}



  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
      future: list_contact(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Text('Cargando...');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return createListView(context, snapshot);
        }
      },
    );
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Pago Clave BDV'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Home()
                ));
              },
                ),
              ),
              body: futureBuilder,
            );
          }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<ContactModel> values = snapshot.data;
    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return ContactItem(values[index]);
      },
    );
  }
}
