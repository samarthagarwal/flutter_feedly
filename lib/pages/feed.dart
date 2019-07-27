import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feedly/pages/create.dart';
import 'package:flutter_feedly/widgets/compose_box.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<Widget> _posts = [];
  List<DocumentSnapshot> _postDocuments = [];
  Future _getFeedFuture;

  Firestore _firestore = Firestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  _navigateToCreatePage() {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx) {
      return CreatePage();
    }));
  }

  Future _getFeed() async {
    Query _query = _firestore
        .collection("posts")
        .orderBy("created", descending: true)
        .limit(10);

    QuerySnapshot _querySnapshot = await _query.getDocuments();

    print(_querySnapshot.documents.length);

    _postDocuments = _querySnapshot.documents;

    return _postDocuments;
  }

  _getItems() {
    List<Widget> _items = [];

    Widget _composeBox = GestureDetector(
      child: ComposeBox(),
      onTap: _navigateToCreatePage,
    );

    _items.add(_composeBox);

    return _items;
  }

  @override
  void initState() {
    super.initState();

    _getFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.rss_feed),
        title: Text("Your Feed"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: _getItems(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCreatePage,
        child: Icon(Icons.add),
      ),
    );
  }
}
