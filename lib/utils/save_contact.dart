import 'package:pago_movil_bdv/setting/database_client.dart';
import 'package:pago_movil_bdv/models/Contact.dart';

Future<void> save_contact({String codeBank, String codeMobile, String mobile, String dni, String name}) async{

  final DatabaseClient db = DatabaseClient();
  await db.create().then((dd){
    ContactModel contact = new ContactModel();
    contact.name = name;
    contact.codeMobile = codeMobile;
    contact.mobile = mobile;
    contact.codeBank = codeBank;
    contact.dni= dni;

    db.upsertContact(contact).then((ContactModel contact){
    });

  });

}