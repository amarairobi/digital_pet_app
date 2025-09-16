import 'package:flutter/material.dart'; // import: need to access a lib that's defined in dart, standard library used for 90% of apps, gives access to visual components: app bar, scaffold, and text

void main() { 
  runApp(MyApp());  // main entry point in flutter app, tells flutter to start building/displaying MyApp widget
}

class MyApp extends StatelessWidget { // the constructor, the main initiation for objects to be used w/ variables and methods
  @override
  Widget build(BuildContext context) {
    return MaterialApp(  // grab all the common features for theme, nav and the title
      home: DefaultTabController( // default screen for app, makes coordination for the tabs
        length: 4,
        child: _TabsNonScrollableDemo(), // deal with tab bar/view inside widget
      ),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget { // makes content like tapping work
  @override
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController; // brain, keeps track of all the tabs.
  
  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';
  
  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) { // restore change/ keep stuff the same
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() { // life cycle methods, flutter makes the calls automatically
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this, // required to make animation run smoothly
    );
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() { // when you change or create, get rid of the old one and load/keep the new one
    _tabController.dispose(); // release all the resources, prevents memory leaks
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // For the To do task hint: consider defining the widget and name of the tabs here
    final tabs = ['Tab 1', 'Tab 2', 'Tab 3', 'Tab 4'];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Digital Pet App'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [for (final tab in tabs) Tab(text: tab)],
        ),
      ),
      body: TabBarView(
        controller: _tabController, 
        children: [
   
          Container( // container for colors
            color: Colors.orange[100],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Alert"),
                          content: Text("Welcome to the digital pet app. Press OK to return to home."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK"),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      "Welcome to Tab 1",
                      style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.network(
                    'https://images.unsplash.com/photo-1601758228041-f3b2795255f1?w=400',
                    width: 200,
                    height: 200,
                  ),
                ],
              ),
            ),
          ),

   
          Container(
            color: Colors.green[100],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: "Enter text here"),
                  ),
                  SizedBox(height: 20),
                  Image.network(
                    'https://hips.hearstapps.com/hmg-prod/images/dog-puppy-on-garden-royalty-free-image-1586966191.jpg?crop=0.752xw:1.00xh;0.175xw,0&resize=1200:*',
                    width: 250,
                    height: 250,
                  ),
                ],
              ),
            ),
          ),

         
          Container(
            color: Colors.blue[100],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1574158622682-e40e69881006?w=400',
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Button pressed in Tab 3!")),
                      );
                    },
                    child: Text("Click me"),
                  ),
                ],
              ),
            ),
          ),

       
          Container( 
            color: Colors.yellow[100],
            child: ListView(
              padding: EdgeInsets.all(8),
              children: [
                Card(child: ListTile(title: Text("Item 1"))),
                Card(child: ListTile(title: Text("Item 2"))),
                Card(child: ListTile(title: Text("Item 3"))),
                Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/4/4d/Cat_November_2010-1a.jpg',
                    width: 250,
                    height: 250,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}