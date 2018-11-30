import 'package:flutter/material.dart';
import '../utils/transaction.dart';

class TransTile extends StatelessWidget {
  final Transaction t;
  TransTile(this.t);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(t.from+" -> "+t.to+" : "+t.amt.toString()),
    );
  }
}

class GroupTile extends StatelessWidget {
  final String gname;
  final VoidCallback _onTap;
  GroupTile(this.gname, this._onTap);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => _onTap(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Image(
							image: new AssetImage('assets/userPic.png'),
							height: 60.0,
							width: 60.0,
						  ),
              SizedBox(
                width: 8.0,
              ),
              Text(gname, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              Expanded(
                child: Container(),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Color(0x33000000),
              ),

            ],
          ),
        ),
      ),
    );
  }
}