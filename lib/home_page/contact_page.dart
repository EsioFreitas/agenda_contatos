import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Contact _editedContante;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.contact == null)
      _editedContante =  Contact();
    else
      _editedContante = Contact.fromMap(widget.contact.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(_editedContante.name ?? "Novo Contato"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child: Icon(Icons.save),
          backgroundColor: Colors.red),
    );
  }
}
