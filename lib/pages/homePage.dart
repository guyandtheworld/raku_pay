import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import './groupPage.dart';
import './personalPage.dart';
import './accountPage.dart';
import '../utils/transaction.dart';

import 'models.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //Sample data for account page
  // List<Transaction> tlist = [
  //   new Transaction("abcd", "efgh", "", "", 1000.0),
  //   new Transaction("efgh", "ijkl", "", "", 200.0),
  //   new Transaction("efgh", "abcd", "", "", 500.0),
  // ];

  List<Group> glist = [
    new Group("Kuriakose", "Go Trip", ["Kuriakose", "Tino", "Jithin"],
        [100.0, 20.0, 500.0], [false, false, false]),
    new Group("Kuriakose", "OMR funds", ["Kuriakose", "Tino", "Jithin"],
        [200.0, 200.0, 500.0], [false, false, false]),
  ];

  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            MaterialButton(
              onPressed: () {
                print("Profile Pressed");
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new AccountPage(tlist)));
              },
              child: Image(
                image: new AssetImage('assets/userPic.png'),
                height: 40.0,
                width: 40.0,
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
          ],
          title: new Text(
            "AppName",
            style: new TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.deepPurpleAccent,
          bottom: TabBar(
            indicatorColor: Colors.white,
            controller: controller,
            tabs: <Tab>[
              Tab(
                child: new Text(
                  "Groups",
                  style: new TextStyle(color: Colors.white),
                ),
              ),
              Tab(
                child: new Text(
                  "Personal",
                  style: new TextStyle(color: Colors.white),
                ),
              ),
              Tab(
                child: new Text(
                  "Budgets",
                  style: new TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            print("TAB" + controller.index.toString() + controller.toString());

            // ***  CREATING A NEW GROUP ***
            Map<String, dynamic> map = new Map();
            map.addAll({
              'name': "Some Name",
              'creator': "adarsh",
              'participants': ['tino', 'jithin', 'kuriakose'],
            });
            Firestore.instance.collection('group').add(map);
          },
          child: new Icon(Icons.add),
        ),
        // body: _buildBody(context),
        body: TabBarView(
          controller: controller,
          children: <Widget>[
            new GroupPage(glist),
            new PersonalPage(),
            new PersonalPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('group').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        print(snapshot.data.documents);
        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  // Loading the database

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return Container(
        child: ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    ));
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final group = PayGroup.fromSnapshot(data);
    print('-------------------------------');
    print(group.toString());
    return Padding(
        // key: ValueKey(record.payer),
        // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        // child: Container(
        //   decoration: BoxDecoration(
        //     color: getColor(record.paid_status),
        //     border: Border.all(color: Colors.grey),
        //     borderRadius: BorderRadius.circular(5.0),
        //   ),
        //   child: ListTile(
        //     title: Text(record.payer),
        //     subtitle: Text(convertBool(record.paid_status)),
        //     trailing: Text(record.amount.toString()),
        //     onTap: () => updatePayment(record),
        //   ),
        // ),
        );
  }
}
