import 'package:pago_movil_bdv/setting/database_client.dart';

delete_contact(int id){
  final DatabaseClient db = DatabaseClient();
  db.create().then((dd)async {
   final deleteContacts =  await db.deleteContact(id);
  });

}