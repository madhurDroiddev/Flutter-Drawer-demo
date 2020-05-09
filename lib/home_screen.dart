import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterdrawerdemo/Pages.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<DrawerModal> drawerItems = List();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  StreamController<int> _drawerSelectedTab;
  int tab = 0;
  TabController tabController;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    // You need to dispose each StreamController when screen destroyed
    _drawerSelectedTab?.close();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(length: 7, vsync: this);
    _drawerSelectedTab = StreamController.broadcast();

    for (int i = 0; i < 6; i++)
      drawerItems.add(DrawerModal(
          id: i, title: "Item " + (i + 1).toString(), isSelected: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.dehaze),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            }),
        title: Text("Drawer demo"),
      ),
      body: Container(
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: <Widget>[
            Pages(page: 1, color: Colors.green),
            Pages(page: 2, color: Colors.deepOrange),
            Pages(page: 3, color: Colors.purple),
            Pages(page: 4, color: Colors.purpleAccent),
            Pages(page: 5, color: Colors.deepPurpleAccent),
            Pages(page: 6, color: Colors.blueAccent),
            Pages(page: 7, color: Colors.yellowAccent),
          ],
        ),
      ),
      drawer: leftDrawer(),
    );
  }

  leftDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                    Text(
                      "User Name",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )),
          StreamBuilder<int>(
              stream: _drawerSelectedTab.stream,
              initialData: tab,
              builder: (context, snapshot) {
                drawerItems.forEach((element) {
                  if (element.id == tab) {
                    element.isSelected = true;
                  } else {
                    element.isSelected = false;
                  }
                });
                return ListView.builder(
                  shrinkWrap: true,
                  // ShrinkWrap must be true when you use ListView.builder in Column Widget
                  itemBuilder: (buildContext, index) {
                    return drawerItem(modal: drawerItems[index]);
                  },
                  itemCount: drawerItems.length,
                );
              })
        ],
      ),
    );
  }

  drawerItem({@required DrawerModal modal}) {
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: () {
            _drawerSelectedTab.sink.add(modal.id);
            tabController.index = modal.id;
            tab = modal.id; // Saved last selected tab
            closeDrawer();
          },
          leading: Container(
            width: 5,
            color: modal.isSelected ? Colors.blue : Colors.grey,
          ),
          title: Text(modal.title),
        ),
        Container(
          height: 1,
          color: Colors.grey[400],
        )
      ],
    );
  }

  closeDrawer() {
    if (_scaffoldKey.currentState.isDrawerOpen) {
      Navigator.pop(context);
    }
  }
}

class DrawerModal {
  int id;
  String title;
  bool isSelected;

  DrawerModal({
    @required this.id,
    @required this.title,
    @required this.isSelected,
  });
}
