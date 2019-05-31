class ContactModel{
  ContactModel();

  int id;
  String name;
  String phone;
  String codeBank;
  String dni;

  static final columns = ["id", "name","phone","codeBank","dni"];

  Map<String, dynamic> toMap() {
    Map<String, dynamic>  map = {
      "name": name,
      "phone": phone,
      "codeBank": codeBank,
      "dni": dni,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  static fromMap(Map map) {
    ContactModel contact = new ContactModel();
    contact.id = map["id"];
    contact.name = map["name"];
    contact.phone = map["phone"];
    contact.codeBank = map["codeBank"];
    contact.dni = map["dni"];

    return contact;
  }



}