// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:contact_app_local_database/pages/newContact_page.dart';
import 'package:flutter/material.dart';

class ContactListPage extends StatelessWidget {
  static const routeName = '/contact-list';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Card(
              elevation: 3,
              child: ListTile(
                title: Text(
                  // '${contactList.length}  Contacts',
                  'Contact List',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(NewContactPage.routeName);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
