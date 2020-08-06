// bloc is used for chat lazy list loading

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_provider.dart';
import 'package:rxdart/rxdart.dart';

class ChatListBloc {
  FirebaseProvider firebaseProvider;

  bool showIndicator = false;
  List<DocumentSnapshot> documentList;

  BehaviorSubject<List<DocumentSnapshot>> chatController;

  BehaviorSubject<bool> showIndicatorController;

  ChatListBloc() {
    chatController = BehaviorSubject<List<DocumentSnapshot>>();
    showIndicatorController = BehaviorSubject<bool>();
    firebaseProvider = FirebaseProvider();
  }

  Stream get getShowIndicatorStream => showIndicatorController.stream;

  Stream<List<DocumentSnapshot>> get chatStream => chatController.stream;

/*This method will automatically fetch first 10 elements from the document list */
  Future fetchFirstList(String classId, String email) async {
    try {
      documentList = await firebaseProvider.fetchFirstList(classId, email);
      print(documentList);
      chatController.sink.add(documentList);
      try {
        if (documentList.length == 0) {
          chatController.sink.addError("No Data Available");
        }
      } catch (e) {}
    } on SocketException {
      chatController.sink.addError(SocketException("No Internet Connection"));
    } catch (e) {
      print(e.toString());
      chatController.sink.addError(e);
    }
  }

/*This will automatically fetch the next 10 elements from the list*/
  fetchNextChats(String classId, String email) async {
    try {
      updateIndicator(true);
      List<DocumentSnapshot> newDocumentList =
          await firebaseProvider.fetchNextList(documentList, classId, email);
      documentList.addAll(newDocumentList);
      chatController.sink.add(documentList);
      try {
        if (documentList.length == 0) {
          chatController.sink.addError("No Data Available");
          updateIndicator(false);
        }
      } catch (e) {
        updateIndicator(false);
      }
    } on SocketException {
      chatController.sink.addError(SocketException("No Internet Connection"));
      updateIndicator(false);
    } catch (e) {
      updateIndicator(false);
      print(e.toString());
      chatController.sink.addError(e);
    }
  }

/*For updating the indicator below every list and paginate*/
  updateIndicator(bool value) async {
    showIndicator = value;
    showIndicatorController.sink.add(value);
  }

  void dispose() {
    chatController.close();
    showIndicatorController.close();
  }
}
