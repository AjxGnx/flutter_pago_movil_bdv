import 'package:flutter/material.dart';
import 'package:pago_movil_bdv/utils/save_contact.dart';
import 'package:pago_movil_bdv/pages/contact_list.dart';

class AddNameContact extends StatefulWidget {
  Map<String, String> data;

  AddNameContact(this.data);

  @override
  _AddNameContactState createState() => _AddNameContactState();
}

class _AddNameContactState extends State<AddNameContact> {
  @override
  initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1)).then((_) => showSnack());
  }

  final snackBarSent = SnackBar(
    content: Text('Mensaje Enviado con Exito'),
    duration: Duration(seconds: 3),
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void showSnack() {
    if (widget.data['sms'] == 'true') {
      _scaffoldKey.currentState.showSnackBar(snackBarSent);
    }
  }

  @override
  Widget build(BuildContext context) {
    double _screenAncho = MediaQuery.of(context).size.width;
    double _screenAlto = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Pago Clave BDV'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(top: _screenAlto / 20, left: 10, right: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Completa este campo';
                    }
                  },
                  controller: _nameController,
                ),
                Container(
                  width: 120,
                  height: 60,
                  padding: EdgeInsets.only(top: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: RaisedButton(
                      color: Colors.redAccent,
                      child: Text(
                        'Guardar',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await save_contact(
                              codeBank: widget.data['codeBank'],
                              codeMobile: widget.data['codeMobile'],
                              mobile: widget.data['mobile'],
                              dni: widget.data['dni'],
                              name: _nameController.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ContactList(save: true)));
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
