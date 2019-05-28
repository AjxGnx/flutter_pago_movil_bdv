import 'package:pago_movil_bdv/setting/database_client.dart';
import 'package:pago_movil_bdv/models/Contact.dart';

void save_contact({String codeBank, String codeMobile, String mobile, String dni, String name}){

  final DatabaseClient db = DatabaseClient();
  db.create().then((dd){
    ContactModel contact = new ContactModel();
    contact.name = name;
    contact.phone = '$codeMobile$mobile';
    contact.codeBank = codeBank;
    contact.dni= dni;

    db.upsertContact(contact).then((ContactModel contact){
    });

  });

}