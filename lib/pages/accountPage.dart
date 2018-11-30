import 'package:flutter/material.dart';
import '../utils/transaction.dart';
import '../ui/tiles.dart';

class AccountPage extends StatefulWidget {
  final String username;
  
  final List<Transaction> tlist;
  AccountPage(this.username, this.tlist);
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  double balance=1000.0;
  List<Widget> twlist = new List<Widget>();
  @override
  void initState(){
    super.initState();
    for(int i=0; i<widget.tlist.length; i++){
      twlist.add(new TransTile(widget.tlist[i]));
      twlist.add(new Divider());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: Text("Acount Info"),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Image(
							    image: new AssetImage('assets/userPic.png'),
							    height: 100.0,
							    width: 100.0,
						    ),
                  SizedBox(width: 16.0,),
                  Column(
                    children: <Widget>[
                      Text(widget.username, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                      Text("Balance: "+balance.toString(), style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Container(),
                      )
                    ],
                  )
                ],
              ),
            )
          ] + twlist,
        )
      )
    );
  }
}
