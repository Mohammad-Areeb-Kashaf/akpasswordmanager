import 'dart:io';

import 'package:ak_password_manager/screens/view_password.dart';
import 'package:ak_password_manager/utilities/encryption.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';

class PasswordManager {
  final _firestore = FirebaseFirestore.instance;
  final labelController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final noteController = TextEditingController();
  var encrypter = Encrypter(AES(EncryptionPassword().key));
  var encryption = EncryptionPassword();

  getPasswords(userUid) {

    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('${userUid}pass').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              color: Color(0xFF616161),
            ));
          } else if(snapshot.hasData) {
            try {
              return ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  var label = data['password_item']['label'];
                  var username = data['password_item']['username'];
                  var email = data['password_item']['email'];
                  var password = data['password_item']['password'];
                  var note = data['password_item']['note'];
                  var id = data['password_item']['id'];
                  var decryptedLabel = encryption.decryptPassword(label, encrypter);
                  var decryptedUsername = encryption.decryptPassword(username, encrypter);
                  var decryptedEmail = encryption.decryptPassword(email, encrypter);
                  var decryptedPassword = encryption.decryptPassword(password, encrypter);
                  var decryptedNote = encryption.decryptPassword(note, encrypter);
                  return ListTile(
                    title: Text(decryptedLabel),
                    subtitle: Text(decryptedEmail),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPassword(label: decryptedLabel, username: decryptedUsername, email: decryptedEmail, password: decryptedPassword, note: decryptedNote, id: id, userUid: userUid, labelController: labelController, usernameController: usernameController, emailController: emailController, passwordController: passwordController, noteController: noteController,)));
                    },
                  );
                }).toList(),
              );
            } catch (e) {
              print(e);
            }
          }
          return const Center(
            child: Text(
              'There are no entries',
              style: TextStyle(
                color: Color(0xFFBDBDBD),
                fontSize: 20,
              ),
            ),
          );
        });
  }

  setPassword(userUid, labelName, userName, email, password, userEmail,
      [note]) async {
    var id = await getId(userUid);
    var encryptedLabel = encryption.encryptPassword(labelName, encrypter);
    var encryptedUsername = encryption.encryptPassword(getText(userName) ? userName : 'null', encrypter);
    var encryptedEmail = encryption.encryptPassword(email, encrypter);
    var encryptedPassword = encryption.encryptPassword(getText(password) ? password : 'null', encrypter);
    var encryptedNote = encryption.encryptPassword(getText(note) ? note : 'null', encrypter);

    var data = {
      'password_item': {
        'id': id,
        'label': encryptedLabel,
        'username': encryptedUsername,
        'email': encryptedEmail,
        'password': encryptedPassword,
        'note': encryptedNote,
      }
    };
    await _firestore.doc('${userUid}pass/${userUid + id.toString()}').set(data);
    setId(id: id, userUid: userUid);
  }

  Future<int> getId(userUid) async {
    try {
      var data = await _firestore.doc('$userUid/$userUid').get();
      var id = data['id'];
      return id + 1;
    } catch (e) {
      return 0 + 1;
    }
  }

  Future<num> getCurrentId(userUid) async {
    try {
      var request = await _firestore.doc('$userUid/$userUid').get();
      var id = request['id'];
      return id;
    } catch (e) {
      return 0;
    }
  }
  deletePassword({required id, required userUid}) async {
    var data = _firestore.doc('${userUid}pass/${userUid + id.toString()}');
    await data.delete();
  }
  setId({required id, required userUid}) async {
    var data = {
      'id': id,
    };
    await _firestore.doc('$userUid/$userUid').set(data);
  }
  updatePassword({label, username, email, password, note, id, userUid}) async {
    var encryptedLabel = encryption.encryptPassword(getText(label) ? label : 'null', encrypter);
    var encryptedUsername = encryption.encryptPassword(getText(username) ? username : 'null', encrypter);
    var encryptedEmail = encryption.encryptPassword(getText(email) ? email : 'null', encrypter);
    var encryptedPassword = encryption.encryptPassword(getText(password) ? password: 'null', encrypter);
    var encryptedNote = encryption.encryptPassword(getText(note) ? note : 'null', encrypter);
    var data = {
      'password_item': {
        'id': id,
        'label': encryptedLabel,
        'username': encryptedUsername,
        'email': encryptedEmail,
        'password': encryptedPassword,
        'note': encryptedNote,
      }
    };
    await _firestore.doc('${userUid}pass/${userUid+id.toString()}').update(data);
  }
  
  getText(text) {
    if (text == '') {
      return false;
    } else {
      return true;
    }
  }
}
