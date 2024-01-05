import 'package:flutter/cupertino.dart';
import 'package:vcard_project/db/db_helper.dart';
import 'package:vcard_project/models/contact_model.dart';

class ContactProvider extends ChangeNotifier{

  List<ContactModel> contactList = [];
  final db = DbHelper();

  Future<int> insertContact(ContactModel contactModel) {
    return db.insertContact(contactModel);
  }

  Future<void> getAllContacts() async{
    contactList = await db.getAllContacts();
    notifyListeners();
  }
}