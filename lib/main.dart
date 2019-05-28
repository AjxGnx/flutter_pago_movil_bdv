import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pago_movil_bdv/data/bank_code.dart';
import 'package:pago_movil_bdv/data/mobile_code.dart';
import 'package:pago_movil_bdv/pages/add_name_contact.dart';
import 'package:pago_movil_bdv/pages/contact_list.dart';
import 'package:pago_movil_bdv/utils/list_contact.dart';

void main() {
  runApp(
      MaterialApp(
          theme: ThemeData(primaryColor: Colors.redAccent), home: Home())
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _chexbox = false;
  String _codeBank = null;
  String _codeMobile = null;
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _dniController = TextEditingController();


  void _valueChanged(bool value) => setState(() => _chexbox = value);


  @override
  Widget build(BuildContext context) {
    double _screenAncho = MediaQuery
        .of(context)
        .size
        .width;
    double _screenAlto = MediaQuery
        .of(context)
        .size
        .height;


    return Scaffold(
        appBar: AppBar(
          title: Text('Pago Clave BDV'),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: _screenAlto / 20),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 5),
                            height: 59,
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.black45, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: _codeBank,
                                items: listCodeBank,
                                hint: Text('Banco Receptor'),
                                onChanged: (value) {
                                  _codeBank = value;
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: IconButton(
                              icon: Icon(
                                Icons.contacts,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                print(list_contact());
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ContactList(list_contact())
                                        ));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Container(
                                width: _screenAncho / 2.1,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black45, width: 1),
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.only(left: 5),
                                height: 61,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: _codeMobile,
                                    items: listCodeMobile,
                                    hint: Text('Prefijo'),
                                    onChanged: (value) {
                                      _codeMobile = value;
                                      setState(() {
                                        print(value);
                                      });
                                    },
                                  ),
                                ),
                              )),
                          Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            width: _screenAncho / 2.1,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Numero celular',
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                              ),
                              controller: _mobileController,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 10, right: 9, top: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Cedula',
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                          ),
                          controller: _dniController,
                        )),
                    Container(
                        padding: EdgeInsets.only(left: 10, right: 9, top: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Monto',
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                          ),
                        )),
                    Container(
                      child: CheckboxListTile(
                        value: _chexbox,
                        onChanged: _valueChanged,
                        title: new Text('Agregar a pagos frecuentes?'),
                        activeColor: Colors.red,
                      ),
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
                            'PAGAR',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if (_chexbox == true) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddNameContact({
                                            'codeBank': _codeBank,
                                            'codeMobile': _codeMobile,
                                            'mobile': _mobileController.text,
                                            'dni': _dniController.text,
                                          })));
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
