import 'package:pago_movil_bdv/setting/database_client.dart';
import 'package:pago_movil_bdv/models/Contact.dart';

list_contact(){

  final DatabaseClient db = DatabaseClient();
  return db.create().then((data) async{

    List<ContactModel> latestContacts =  await db.getContact();
    return (latestContacts);
    });
  }

