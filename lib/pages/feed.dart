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

  _navigateToCreatePage() async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext ctx) {
      return CreatePage();
    }));

    // Refresh the feed
    _getFeedFuture = _getFeed();
  }

  Future _getFeed() async {
    _posts = [];

    Query _query = _firestore
        .collection("posts")
        .orderBy("created", descending: true)
        .limit(10);

    QuerySnapshot _querySnapshot = await _query.getDocuments();

    print(_querySnapshot.documents.length);

    _postDocuments = _querySnapshot.documents;

    for (int i = 0; i < _postDocuments.length; ++i) {
      Widget w = ListTile(
        title: Text(_postDocuments[i].data["text"]),
        subtitle: Text(_postDocuments[i].data["owner_name"]),
      );

      _posts.add(w);
    }

    return _postDocuments;
  }

  _getItems() {
    List<Widget> _items = [];

    Widget _composeBox = GestureDetector(
      child: ComposeBox(),
      onTap: _navigateToCreatePage,
    );

    _items.add(_composeBox);

    Widget separator = Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        "Recent Posts",
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
    );

    _items.add(separator);

    Widget feed = FutureBuilder(
        future: _getFeedFuture,
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  height: 16.0,
                ),
                Text("Loading..."),
              ],
            );
          } else if (snapshot.data.length == 0) {
            return Text("No data to display");
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: _posts,
            );
          }
        });

    _items.add(feed);

    return _items;
  }

  @override
  void initState() {
    super.initState();

    _getFeedFuture = _getFeed();
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
