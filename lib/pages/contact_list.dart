import 'package:flutter/material.dart';
import 'package:pago_movil_bdv/models/Contact.dart';
import 'package:pago_movil_bdv/pages/contact_item.dart';
import 'package:pago_movil_bdv/utils/list_contact.dart';
import 'package:pago_movil_bdv/main.dart';

class ContactList extends StatefulWidget {


  bool save;
  bool delete;
  bool update;
  ContactList({this.save: false,this.delete: false, this.update:false});

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

  final snackBarSave = SnackBar(
    content: Text('Contacto Guardado con exito'),
    duration: Duration(seconds: 5),
  );
  final snackBarDelete = SnackBar(
    content: Text('Contacto Eliminado con exito'),
    duration: Duration(seconds: 5),
  );
  final snackBarUpdate = SnackBar(
    content: Text('Contacto Editado con exito'),
    duration: Duration(seconds: 5),
  );
   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnack() {
    if(widget.save){
      _scaffoldKey.currentState.showSnackBar(snackBarSave);
  }
    if(widget.delete){
      _scaffoldKey.currentState.showSnackBar(snackBarDelete);
    }
    if(widget.update){
      _scaffoldKey.currentState.showSnackBar(snackBarUpdate);
    }
  }



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
