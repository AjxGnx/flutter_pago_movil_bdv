import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pago_movil_bdv/data/bank_code.dart';
import 'package:pago_movil_bdv/data/mobile_code.dart';
import 'package:pago_movil_bdv/pages/add_name_contact.dart';
import 'package:pago_movil_bdv/pages/contact_list.dart';
import 'package:sms/sms.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(primaryColor: Colors.red, accentColor: Colors.redAccent),
      home: Home()));
}

class Home extends StatefulWidget {
  Map<String, String> data;

  Home({this.data});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _chexbox = false;
  bool _loading = false;
  String _codeBank = null;
  String _codeMobile = null;
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _dniController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  final snackBar = SnackBar(
    content: Text('Pago Enviado con Exito'),
    duration: Duration(seconds: 5),
  );
  final snackBarFail = SnackBar(
    content: Text('Ocurrio un problema al enviar su mensaje'),
    duration: Duration(seconds: 5),
  );

  void _valueChanged(bool value) => setState(() => _chexbox = value);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.data != null) {
      _codeBank = widget.data['codeBank'];
      _codeMobile = widget.data['codeMobile'];
      _dniController.text = widget.data['dni'];
      _mobileController.text = widget.data['mobile'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _screenAncho = MediaQuery.of(context).size.width;
    double _screenAlto = MediaQuery.of(context).size.height;

    Widget _openLoading() {
      return _loading
          ? Container(
              color: Colors.black12,
              width: _screenAncho,
              height: _screenAlto,
              child: Center(
                  child: new CircularProgressIndicator(
                backgroundColor: Colors.redAccent,
              )))
          : Text('');
    }

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Pago Clave BDV'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.contacts,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactList()));
              },
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.only(top: _screenAlto / 20),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding:
                                EdgeInsets.only(left: 7, bottom: 20, right: 7),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: 8, bottom: 20, top: 20),
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
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: _screenAncho / 2.1,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              left: 8, bottom: 20, top: 20),
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
                                  width: _screenAncho / 64,
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
                              padding: EdgeInsets.only(
                                  left: 7, right: 7, bottom: 20),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Completa este campo';
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: 'Cedula',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                controller: _dniController,
                              )),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 7, right: 7, bottom: 20),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Completa este campo';
                                  }
                                },
                                controller: _amountController,
                                decoration: InputDecoration(
                                  labelText: 'Monto',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                              )),
                          widget.data == null
                              ? Container(
                                  child: CheckboxListTile(
                                    value: _chexbox,
                                    onChanged: _valueChanged,
                                    title:
                                        new Text('Agregar a pagos frecuentes?'),
                                    activeColor: Colors.red,
                                  ),
                                )
                              : Text(''),
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
                                  if (_formKey.currentState.validate()) {
                                    if (_chexbox == true) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddNameContact({
                                                    'codeBank': _codeBank,
                                                    'codeMobile': _codeMobile,
                                                    'mobile':
                                                        _mobileController.text,
                                                    'dni': _dniController.text,
                                                  })));
                                    } else {
                                      SmsSender sender = new SmsSender();
                                      SmsMessage message = SmsMessage(
                                          '2662',
                                          'PAGAR ' +
                                              '$_codeBank' +
                                              ' ${_codeMobile + _mobileController.text}' +
                                              ' ${_dniController.text}' +
                                              ' ${_amountController.text + ',00'}');
                                      message.onStateChanged.listen((state) {
                                        if (state == SmsMessageState.Sending) {
                                          setState(() {
                                            _loading = true;
                                          });
                                        } else if (state ==
                                            SmsMessageState.Delivered) {
                                          setState(() {
                                            _loading = false;
                                            _codeBank = null;
                                            _codeMobile = null;
                                            _mobileController.text = '';
                                            _dniController.text = '';
                                            _amountController.text = '';
                                          });
                                          _scaffoldKey.currentState
                                              .showSnackBar(snackBar);
                                        } else if (state ==
                                            SmsMessageState.Fail) {
                                          setState(() {
                                            _loading = false;
                                          });
                                          _scaffoldKey.currentState
                                              .showSnackBar(snackBarFail);
                                        }
                                      });
                                      sender.sendSms(message);
                                    }
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            _openLoading()
          ],
        ));
  }
}
