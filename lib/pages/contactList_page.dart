// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:contact_app_local_database/pages/newContact_page.dart';
import 'package:contact_app_local_database/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              child: Consumer<ContactProvider>(
                builder: (context, prvider, _) => ListTile(
                  title: Text(
                    '${prvider.contactList.length}  Contacts',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 5, right: 5, bottom: 10, top: 5),
                child: Consumer<ContactProvider>(
                  builder: (Context, provider, _) => ListView.builder(
                    itemCount: provider.contactList.length,
                    itemBuilder: (context, index) {
                      final contact = provider.contactList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.deepOrange,
                              child: Center(
                                child: Text(
                                  contact.name.substring(0, 1).toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            title: Text(contact.name),
                          ),
                        ),
                      );
                    },
                  ),
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
