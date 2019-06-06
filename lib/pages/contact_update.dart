import 'package:flutter/material.dart';
import 'package:pago_movil_bdv/data/bank_code.dart';
import 'package:pago_movil_bdv/data/mobile_code.dart';
import 'package:pago_movil_bdv/models/Contact.dart';
import 'package:pago_movil_bdv/utils/update_contact.dart';
import 'package:pago_movil_bdv/pages/contact_list.dart';


class UpdateContact extends StatefulWidget {
  ContactModel contact;
  UpdateContact({this.contact});

  @override
  _UpdateContactState createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {

  @override
  void initState(){
    if( widget.contact != null){
      _codeBank = widget.contact.codeBank;
      _codeMobile = widget.contact.codeMobile;
      _dniController.text = widget.contact.dni;
      _mobileController.text = widget.contact.mobile;
      _nameController.text = widget.contact.name;
    }
    super.initState();
  }

  String _codeBank = null;
  String _codeMobile = null;
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _dniController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    double _screenAncho = MediaQuery.of(context).size.width;
    double _screenAlto = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Pago Clave BDV'),
        ),
        body: ListView(
          children :<Widget>[
            Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.only(top: _screenAlto / 20),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 7, bottom: 20, right: 7),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 8,bottom: 20,top: 20),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10)))),
                            value: _codeBank,
                            items: listCodeBank,
                            hint: Text('Banco Receptor'),
                            onChanged: (value) {
                              _codeBank = value;
                              setState(() {});
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Completa este campo';
                              }
                            }),
                      ),
                    ),Container(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: _screenAncho / 2.1,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                                value: _codeMobile,
                                items: listCodeMobile,
                                hint: Text('Prefijo'),
                                onChanged: (value) {
                                  _codeMobile = value;
                                  setState(() {});
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Completa este campo';
                                  }
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: _screenAncho/64,
                          ),
                          Container(
                            width: _screenAncho / 2.1,
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Completa este campo';
                                }
                              },
                              decoration: InputDecoration(
                                labelText: 'Numero celular',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))),
                              ),
                              controller: _mobileController,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        padding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 20),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Completa este campo';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Cedula',
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                          ),
                          controller: _dniController,
                        )),
                    Container(
                        padding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 20),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Completa este campo';
                            }
                          },
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Nombre',
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                          ),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 130,
                          height: 60,
                          padding: EdgeInsets.only(top: 20,right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: RaisedButton(
                              color: Colors.grey,
                              child: Text(
                                'CANCELAR',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ContactList()
                                  )
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          width: 130,
                          height: 60,
                          padding: EdgeInsets.only(left: 10,top: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: RaisedButton(
                              color: Colors.redAccent,
                              child: Text(
                                'GUARDAR',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  ContactModel contact = ContactModel();
                                  contact.id = widget.contact.id;
                                  contact.name = _nameController.text;
                                  contact.codeBank = _codeBank;
                                  contact.codeMobile = _codeMobile;
                                  contact.mobile = _mobileController.text;
                                  contact.dni = _dniController.text;

                                  updateContact(contact);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ContactList(update: true)
                                      )
                                  );
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    )

                  ],
                ),
              ),
            ),
          )],
        )
      ),
    );
  }
}
