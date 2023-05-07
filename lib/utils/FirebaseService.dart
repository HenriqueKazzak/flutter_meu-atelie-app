import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meu_atelie/config/firebase_options.dart';

import '../models/AbstractModel.dart';

class FirebaseService {

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  late final FirebaseAuth _auth = FirebaseAuth.instance;
  late final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User> getCurrentUser() async{
    return _auth.currentUser!;

  }

  Future<UserCredential> signIn(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);

  }

  Future<UserCredential> signUp(String email, String password,String name, String phone) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User? user = userCredential.user;
    user?.updateDisplayName(name);
    user?.updatePhoneNumber(phone as PhoneAuthCredential);
    log(user.toString());
    return userCredential;
  }

  Future<void> signOut() async {
    return _auth.signOut();
  }

  Future<bool> isSignedIn() async {
    final currentUser = _auth.currentUser;
    return currentUser != null;
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser
        ?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOutGoogle() async {
    await GoogleSignIn().signOut();
  }

  Future<DocumentReference<Map<String, dynamic>>> save<T extends AbstractModel>(
      String collection, T model) {
    return _firestore.collection(collection).add(model.toJson());
  }

  Future<User> updateUser(String nome, String telefone) async{
    try {
      User user =  _auth.currentUser!;
      user.updateDisplayName(nome);
      user.updatePhoneNumber(telefone as PhoneAuthCredential);
      return user;
    } catch (e) {
      return _auth.currentUser!;
    }
  }

  Future<bool> updatePassword(String email, String oldPassword, String password) async{
    try {
      User user =  _auth.currentUser!;
      user.reauthenticateWithCredential(EmailAuthProvider.credential(email: email, password: oldPassword));
      user.updatePassword(password);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  void deleteUser() {
    User user = _auth.currentUser!;
    user.delete();
  }
}
