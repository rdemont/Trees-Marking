

import 'package:flutter/material.dart';

import '../businessObj/markedTree.dart';

class MarkedTreeWidget extends StatefulWidget {

  final List<MarkedTree> items;
  

  const MarkedTreeWidget(
      {super.key,
      required this.items});

  @override
  State<MarkedTreeWidget> createState() => _MarkedTreeWidgetState();
}



class _MarkedTreeWidgetState extends State<MarkedTreeWidget> {

  @override
  void initState() {
    //_loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Text("Salut");
  }
}


