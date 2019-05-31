class ContactModel{
  ContactModel();

  int id;
  String name;
  String codeMobile;
  String mobile;
  String codeBank;
  String dni;

  static final columns = ["id", "name","codeMobile","mobile","codeBank","dni"];

  Map<String, dynamic> toMap() {
    Map<String, dynamic>  map = {
      "name": name,
      "codeMobile": codeMobile,
      "mobile": mobile,
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
    contact.codeMobile = map["codeMobile"];
    contact.mobile = map["mobile"];
    contact.codeBank = map["codeBank"];
    contact.dni = map["dni"];

    return contact;
  }



}