import 'dart:io';

import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Contact _editedContante;
  bool _userEdited = false;
  final _nameControler = TextEditingController();
  final _emailControler = TextEditingController();
  final _phoneControler = TextEditingController();

  final _nameFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.contact == null)
      _editedContante = Contact();
    else {
      _editedContante = Contact.fromMap(widget.contact.toMap());
      _nameControler.text = _editedContante.name;
      _emailControler.text = _editedContante.email;
      _phoneControler.text = _editedContante.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(_editedContante.name ?? "Novo Contato"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_editedContante.name.isNotEmpty &&
                  _editedContante.name != null) {
                Navigator.pop(context, _editedContante);
              } else {
                FocusScope.of(context).requestFocus(_nameFocus);
              }
            },
            child: Icon(Icons.save),
            backgroundColor: Colors.red),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  ImagePicker.pickImage(source: ImageSource.camera).then((file){
                    setState(() {
                      _editedContante.img = file.path;
                    });
                  });
                },
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: _editedContante.img != null
                              ? FileImage(File(_editedContante.img))
                              : AssetImage('images/images.png'))),
                ),
              ),
              TextField(
                  decoration: InputDecoration(labelText: "Nome"),
                  focusNode: _nameFocus,
                  onChanged: (text) {
                    _userEdited = true;
                    setState(() {
                      _editedContante.name = text;
                    });
                  },
                  controller: _nameControler),
              TextField(
                  controller: _emailControler,
                  decoration: InputDecoration(labelText: "Email"),
                  onChanged: (text) {
                    _userEdited = true;
                    _editedContante.email = text;
                  },
                  keyboardType: TextInputType.emailAddress),
              TextField(
                  controller: _phoneControler,
                  decoration: InputDecoration(labelText: "Phone"),
                  onChanged: (text) {
                    _userEdited = true;
                    _editedContante.phone = text;
                  },
                  keyboardType: TextInputType.phone),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar Alterações"),
              content: Text("Se sair as alterações serão perdidas"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
