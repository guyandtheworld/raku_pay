import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String payer;
  final String receiver;
  final int amount;
  final bool paid_status;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['payer'] != null),
        assert(map['receiver'] != null),
        assert(map['amount'] != null),
        assert(map['paid_status'] != null),
        payer = map['payer'],
        receiver = map['receiver'],
        amount = map['amount'],
        paid_status = map['paid_status'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$payer:$amount>";
}

class PayGroup {
  final String creator;
  final String groupName;
  final List<String> participants;
  final DocumentReference reference;

  PayGroup.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['creator'] != null),
        assert(map['name'] != null),
        creator = map['creator'],
        groupName = map['name'],
        participants = map['participants'].cast<String>();

  PayGroup.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Group<$creator:$groupName>";
}
