import 'package:contact_app_local_database/db/db_helper.dart';
import 'package:contact_app_local_database/models/contact_model.dart';
import 'package:flutter/cupertino.dart';

class ContactProvider extends ChangeNotifier {
  List<ContactModel> contactList = [];

  getAllContacts() {
    return DBHelper.getAllContacts().then((value) {
      contactList = value;
      notifyListeners();
    });
  }

  Future<bool>addNewContact(ContactModel contactModel) async {
    final rowId = await DBHelper.insertContact(contactModel);
    if (rowId > 0 ) {
      contactModel.id = rowId;
      contactList.add(contactModel);
      notifyListeners();
      return true;
    }
    return false;
  }
}
