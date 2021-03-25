import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nara_app/models/user.dart';
import 'package:nara_app/services/auth.dart';
import 'package:nara_app/services/database.dart';
import 'package:nara_app/views/changename.dart';
import 'package:nara_app/views/home.dart';

import 'package:nara_app/Reg_and_logo/Registration.dart';
import 'package:nara_app/Reg_and_logo/SignInPage.dart';
import 'package:nara_app/main.dart';
import 'package:nara_app/views/loading.dart';
import 'package:provider/provider.dart';

import 'package:velocity_x/velocity_x.dart';

import 'changepassword.dart';



void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Profile(),
    );
  }
}
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();


  int _selectedIndex=0;



  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    //chamge mame
    void showname(){
       showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
        return AlertDialog(
          title: Text(''),content: SingleChildScrollView(
          child:ChangeName(),),
        );
      },
      );
    }
    //change password
    void showpass(){
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(''),content: SingleChildScrollView(
            child:ChangePass(),),
          );
        },
      );
    }



    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;

          return Form(
              key: _formKey,
              child: Scaffold(
                body: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      //   colors: [const Color(0XFFF50057),const Color(0XFFF44336)],
                        colors: [ Colors.redAccent,Colors.redAccent[100]],
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.bottomCenter,
                        stops: [0.0,0.8],
                        tileMode: TileMode.mirror
                    ),
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children:<Widget> [

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                            child: Text("PROFILE",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.white)),
                          ),
                              HStack( [
                                GestureDetector(
                                  child: VxBox(child:'${userData.username}'.text.red600.bold.makeCentered().p16()).red200.roundedLg.make(),
                                  onTap: ()=> showname(),//_showMyName();

                                ),
                              ]),
                              SizedBox(height: 20,),

                          HStack( [
                            GestureDetector(
                              child: VxBox(child:Row(children:["Favorite".text.bold.red600.makeCentered(), Icon(Icons.favorite,color: Colors.redAccent,),],).p16()).red200.roundedLg.make(),
                              onTap: (){
                              //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                              },
                            ),
                          ]),
                          SizedBox(height: 20,),
                          HStack([
                            GestureDetector(
                              child: VxBox(child: "Change Password".text.bold.red600.makeCentered().p16()).red200.roundedLg.make(),
                              onTap: ()=> showpass(),
                            )
                          ]),
                         SizedBox(height: 20),
                         /* Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HStack([
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    child: VxBox(child: "New Account".text.red600.bold.makeCentered().p16()).red200.roundedLg.make(),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Registration()));
                                    },

                                  ),
                                ),],
                              ),

                              HStack([
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    child: VxBox(child: "Sign-in".text.red600.bold.makeCentered().p16()).red200.roundedLg.make(),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInPage()));
                                    },
                                  ),
                                ),],
                              ),

                            ],
                          ),*/
                          HStack([
                            GestureDetector(
                              child: VxBox(child: "Sign out".text.bold.red600.makeCentered().p16()).red200.roundedLg.make(),
                              onTap: ()async {
                                await _auth.signOut();
                              //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInPage()));
                              },
                            )
                          ]),
                        //  FlatButton(onPressed: () async{ await _auth.signOut();}, child: Text('out')),

                        ],
                      ),
                    ),
                  ),
                ),



                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  unselectedFontSize: 14,
                  selectedFontSize: 13,
                  selectedItemColor:Colors.blueGrey,
                  unselectedItemColor:Colors.redAccent,
                  items: [
                    BottomNavigationBarItem(icon:Icon(Icons.home),//_selectedIndex==0?Icon(Icons.home,color: Colors.blueGrey):Icon(Icons.home,color: Colors.redAccent,),
                      label:'Home',
                    ),
                    BottomNavigationBarItem(icon: Icon(Icons.account_circle),label: 'Profile',),
                  ],
                  onTap: _onItemTapped,
                ),

              ),
        );
        }
        else{
          return Loading();
        }
      },
    );


  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
      if (_selectedIndex == 0) Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      else  Navigator.push(context,MaterialPageRoute(builder: (context)=>Profile()));
    });
  }

  //change password
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Password',style: TextStyle(color: Colors.redAccent),),
          content:SingleChildScrollView(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container( margin:EdgeInsets.all(4), width: 200,height: 50,
                  child:TextField(obscureText: true, obscuringCharacter: '*',
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Current Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),)),
                  ),
                ),
                Container(margin:EdgeInsets.all(4), width: 200,height: 50,
                  child:TextField(obscureText: true, obscuringCharacter: '*',
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "New Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
                Container(margin:EdgeInsets.all(4), width: 200,height: 50,
                  child:TextField(obscureText: true, obscuringCharacter: '*',
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "re-enter NewPassword",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Apply',style: TextStyle(color: Colors.redAccent),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel',style: TextStyle(color: Colors.redAccent),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  //change name
 /* Future<void> _showMyName() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Name',style: TextStyle(color: Colors.redAccent),),
          content:SingleChildScrollView(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container( margin:EdgeInsets.all(4), width: 200,height: 50,
                  child:TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Your Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),)),
                        onChanged: (val) => setState(()=>name=val),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Apply',style: TextStyle(color: Colors.redAccent),),
              onPressed: () async{
                print(name);
               /* if(_formname.currentState.validate()){
                  await DatabaseService(uid: user.uid).updateUserData(name);
                }*/
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel',style: TextStyle(color: Colors.redAccent),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }*/
}