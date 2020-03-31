import 'dart:async';
import 'dart:ffi';
import 'package:flutterapp/Pages/Myaccount.dart';
import 'package:flutterapp/Pages/loading.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/ui/signin.dart';
import 'package:flutterapp/ui/widgets/signout.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/enum/connectivity_status.dart';
import 'package:flutterapp/services%20status/network_service.dart';
import 'package:location/location.dart';
import 'package:flutterapp/firestore/saveLocation.dart';
import 'package:provider/provider.dart';


void main() => runApp(SignInPage());
class Home extends StatefulWidget {
  Home({Key key, this.uid})
      : super(key: key); //update this to include the uid in the constructor

  final String uid;
  StreamSubscription subscription;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _count = 0;
  var name='';
  var email='';

  String _networkStatus2 = '';
  Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> subscription;
  Location _location;
// Method to convert the connectivity to a string value
  String getConnectionValue(var connectivityResult) {
    String status = '';
    switch (connectivityResult) {
      case ConnectivityResult.mobile:
        status = 'Mobile';

        break;
      case ConnectivityResult.wifi:
        status = 'Wi-Fi';

        break;
      case ConnectivityResult.none:
        status = 'None';

        break;
      default:
        status = 'None';

        break;
    }
    return status;
  }



  @override
  void initState() {

    super.initState();

    _handleRefresh();
    _location = Location();
    print('userToken:' + widget.uid);

    widget.subscription = _location.onLocationChanged().listen((locData) async {
      widget.subscription.pause();
      await Firestore.instance
          .collection('Drivers')
          .document(widget.uid)
          .updateData({'lat': locData.latitude, 'lng': locData.longitude});
      widget.subscription.resume();
      checkConnectivity2();

      //checkConnectivity2();

      //print('fuck'+locData.toString());
      /*  saveDriverLocation(
locData: locData,
        uID: widget.uid

      );*/
      //print('Location:${locData.toString()}');
    });
  }

  void checkConnectivity2() {
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          var conn = getConnectionValue(result);
          setState(() {
            _networkStatus2 = conn;
            //print(_networkStatus2);
            //lastUpdateStatus();
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    lastUpdateStatus();
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Future Academy"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('Drivers')
              .document(widget.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            // name = snapshot.data['name'];
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              //name = snapshot.data['name'];
                return Text('');
              default :

                name = snapshot.data['name'];
                email = snapshot.data['email'];


                return Center(

                );
            }
          }),
      drawer: Drawer(
        child: ListView(padding: const EdgeInsets.all(0), children: <Widget>[
          //Container(),

          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/future.jpg"),


            ),
            accountName: Text(

              name,
              style: TextStyle(fontSize: 20),
            ),
            accountEmail: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                child: Text(
                  email,
                  style: TextStyle(fontSize: 15),
                )),
            /* decoration: BoxDecoration(color:Colors.blueGrey),*/
          ),
          InkWell(
            onTap:(){

            },
            child: ListTile(
                title:Text("Home"),
                leading: Icon(Icons.home)
            ),
          ),
          InkWell(
            onTap:(){ Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MyAccount(uid: widget.uid)));
        },
            child: ListTile(
                title:Text("My account"),
                leading: Icon(Icons.person)
            ),
          ),
          InkWell(
            onTap:(){launch('tel:01221732299');},
            child: ListTile(
                title:Text("Contact Us"),
                leading: Icon(Icons.call)
            ),
          ),
          Divider(),
          InkWell(
            onTap:(){
              //_handleRefresh();
              FirebaseAuth.instance.signOut().then((currentUser) =>
                  Firestore.instance
                      .collection("Drivers")
                      .document(widget.uid)
                      .get()
                      .then((DocumentSnapshot result) =>

                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      LogoutPage()), (Route<dynamic> route) => false)));

            },
            child: ListTile(
                title:Text("Logout"),
                leading: Icon(Icons.exit_to_app)
            ),
          )
        ]),
      ),

      //GetLocationPage(),


    );
  }

  Future<Null> _handleRefresh() async {
    await new Future.delayed(new Duration(seconds: 1));

    setState(() {
      _count += 1;
    });

    return null;
  }

//update location to firebase
  Future<void> lastUpdateStatus() async {
    if (_networkStatus2 == "Wi-Fi") {
      await Firestore.instance
          .collection('Drivers')
          .document(widget.uid)
          .updateData({'status': 'Wi-Fi'});
    }
    if (_networkStatus2 == "Mobile") {
      await Firestore.instance
          .collection('Drivers')
          .document(widget.uid)
          .updateData({'status': 'Mobile'});
    }
  }

}
