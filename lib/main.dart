import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:url_launcher/url_launcher.dart';
void main() => runApp(new MyApp());
class MyApp extends StatelessWidget{

  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
  TextEditingController nowa = new TextEditingController();
  TextEditingController pesan = new TextEditingController();
  String _activity = '+62';

  @override
  Widget build(BuildContext context){
    Color hexToColor(String code) {
      return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    }
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Welcome to Flutter",
        home: new Material(
            child: new Container (
                padding: const EdgeInsets.all(30.0),
                color: Colors.white,
                child: new Container(
                  child: new Center(
                      child: new Column(
                          children : [
                            new Padding(padding: EdgeInsets.only(top: 140.0)),
                            new Text('Wa Message',
                              style: new TextStyle(color: hexToColor("#F2A03D"), fontSize: 25.0),),
                            new Padding(padding: EdgeInsets.only(top: 50.0)),

                            new TextFormField(
                              controller: nowa,

                              decoration: new InputDecoration(
                                prefixText: "+62",
                                labelText: "Masukkan Nomor Whatsapp",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                                //fillColor: Colors.green
                              ),
//                              validator: (val) {
//                                if(val.length==0) {
//                                  return "Pesan tidak boleh kosong";
//                                }else{
//                                  return null;
//                                }
//                              },
                              keyboardType: TextInputType.phone,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ),

                            new Padding(padding: EdgeInsets.only(top: 10.0)),

                            new TextFormField(
                              controller: pesan,
                              decoration: new InputDecoration(
                                labelText: "Masukkan Pesan",
                                fillColor: Colors.white,
                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                  ),
                                ),
                                //fillColor: Colors.green
                              ),
//                              validator: (val) {
//                                if(val.length==0) {
//                                  return "Pesan tidak boleh kosong";
//                                }else{
//                                  return null;
//                                }
//                              },
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ),

                            new Padding(padding: EdgeInsets.only(top: 30.0)),

                            NiceButton(
                              radius: 40,
                              padding: const EdgeInsets.all(15),
                              text: "Kirim Pesan Whatsapp",
                              icon: Icons.account_circle,
                              gradientColors: [secondColor, firstColor],
                              onPressed: () {
                                if(nowa.text.isEmpty){
                                  Fluttertoast.showToast(
                                      msg: "Mohon maaf Silahkan isi No Wa Anda",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }else{

                                  FlutterOpenWhatsapp.sendSingleMessage("+62"+nowa.text, pesan.text);

//                                  launchWhatsApp(phone: "+62"+nowa.text, message: pesan.text);
                                }

                              },
                            )

                          ]
                      )
                  ),
                )
            )
        )
    );
  }

  void launchWhatsApp(
      {@required String phone,
        @required String message,
      }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?   phone=$phone&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

}