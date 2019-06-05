import 'package:pago_movil_bdv/models/Contact.dart';
import 'package:pago_movil_bdv/setting/database_client.dart';

updateContact(ContactModel contact){
  final DatabaseClient db = DatabaseClient();
  db.create().then((dd)async {
    print(contact.id);
    final updateContacts =  await db.updateContact(contact);
  });

}