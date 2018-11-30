import 'package:flutter/material.dart';
import '../ui/tiles.dart';
import '../utils/transaction.dart';

class GroupPage extends StatefulWidget {
  final List<Group> glist;
  GroupPage(this.glist);
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  List<Widget> gwlist = new List<Widget>();
  @override
  void initState() {
    print('----------------------------------------');
    print(widget.glist);
    super.initState();
    for (int i = 0; i < widget.glist.length; i++) {
      gwlist.add(new GroupTile(widget.glist[i].gname, () {
        print("Goto Group " + widget.glist[i].gname);
      }));
      gwlist.add(new Divider());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: gwlist
    );
  }
}
