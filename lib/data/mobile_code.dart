import 'package:flutter/material.dart';

class MobileCode extends StatefulWidget {
  @override
  _MobileCodeState createState() => _MobileCodeState();
}

class _MobileCodeState extends State<MobileCode> {
  int selected = null;
  List<DropdownMenuItem> lisCodeMobile = [];

  void loadData() {
    lisCodeMobile = [];
    lisCodeMobile.add(DropdownMenuItem(
      child: Text('0412'),
      value: 0412,
    ));
    lisCodeMobile.add(DropdownMenuItem(
      child: Text('0414'),
      value: 0414,
    ));
    lisCodeMobile.add(DropdownMenuItem(
      child: Text('0424'),
      value: 0424,
    ));
    lisCodeMobile.add(DropdownMenuItem(
      child: Text('0416'),
      value: 0416,
    ));
    lisCodeMobile.add(DropdownMenuItem(
      child: Text('0426'),
      value: 0426,
    ));
  }
  @override
  Widget build(BuildContext context) {
    double _screenAncho = MediaQuery.of(context).size.width;
    loadData();
    return Container(
      width: _screenAncho/2.1,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black45, width: 1),
          borderRadius: BorderRadius.circular(10)
      ),
      padding: EdgeInsets.only(left: 5),
      height: 61,
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: selected,
          items: lisCodeMobile,
          hint: Text('Prefijo'),
          onChanged: (value) {
            selected = value;
            setState(() {});
          },
        ),
      ),
    );
  }
}
