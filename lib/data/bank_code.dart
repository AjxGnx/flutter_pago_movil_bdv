import 'package:flutter/material.dart';



class BankCode extends StatefulWidget {
  @override
  _BankCodeState createState() => _BankCodeState();
}

class _BankCodeState extends State<BankCode> {

  int selected = null;
  List<DropdownMenuItem> listCodeBank = [];

  void loadData() {
    listCodeBank = [];
    listCodeBank.add(DropdownMenuItem(
      child: Text('BANCO VENEZUELA'),
      value: 0102,
    ));
    listCodeBank.add(DropdownMenuItem(
      child: Text('BANCO MERCANTIL'),
      value: 0105,
    ));
    listCodeBank.add(DropdownMenuItem(
      child: Text('BANCO OCCIDENTAL DE DESCUENTO'),
      value: 0116,
    ));
    listCodeBank.add(DropdownMenuItem(
      child: Text('BANCO BANESCO'),
      value: 0134,
    ));
    listCodeBank.add(DropdownMenuItem(
      child: Text('BANCO BICENTENARIO'),
      value: 0175,
    ));
    listCodeBank.add(DropdownMenuItem(
      child: Text('BANCO CARIBE'),
      value: 0114,
    ));
    listCodeBank.add(DropdownMenuItem(
      child: Text('BANCO EXTERIOR'),
      value: 0115,
    ));
    listCodeBank.add(DropdownMenuItem(
      child: Text('BANCO DEL TESORO'),
      value: 0163,
    ));
    listCodeBank.add(DropdownMenuItem(
      child: Text('BANCO VENEZOLANO DE CREDITO'),
      value: 0104,
    ));
    listCodeBank.add(DropdownMenuItem(
      child: Text('BANCO CARONI'),
      value: 0128,
    ));
    listCodeBank.add(DropdownMenuItem(
      child: Text('BANCO PLAZA'),
      value: 0138,
    ));
    listCodeBank.add(DropdownMenuItem(
      child: Text('BANCO FONDO COMUN'),
      value: 0151,
    ));
    listCodeBank.add(DropdownMenuItem(
      child: Text('100% BANCO'),
      value: 0156,
    ));
    listCodeBank.add(DropdownMenuItem(
      child: Text('BANCO DEL SUR'),
      value: 0157,
    ));
    listCodeBank.add(DropdownMenuItem(
      child: Text('BANCO AGRICOLA'),
      value: 0166,
    ));
    listCodeBank.add(DropdownMenuItem(
      child: Text('BANCRECER'),
      value: 0168,
    ));
    listCodeBank.add(DropdownMenuItem(
      child: Text('MI BANCO'),
      value: 0169,
    ));
    listCodeBank.add(DropdownMenuItem(
      child: Text('BANCO ACTIVO'),
      value: 0171,
    ));
    listCodeBank.add(DropdownMenuItem(
      child: Text('BANCAMIGA'),
      value: 0172,
    ));
    listCodeBank.add(DropdownMenuItem(
      child: Text('BANPLUS'),
      value: 0174,
    ));
    listCodeBank.add(DropdownMenuItem(
      child: Text('BCO FUERZA ARMADA NAC. BOL'),
      value: 0177,
    ));
    listCodeBank.add(DropdownMenuItem(
      child: Text('BANCO NAC. DE CREDITO'),
      value: 0191,
    ));
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    double _screenAncho = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: 5),
      height: 59,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black45, width: 1),
          borderRadius: BorderRadius.circular(10)
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: selected,
          items: listCodeBank,
          hint: Text('Banco Receptor'),
          onChanged: (value) {
            selected = value;
            setState(() {

            });
          },
        ),
      ),
    );
  }
}

