import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas_ai/src/controllers/auth_controller.dart';
import 'package:uas_ai/src/views/index.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PopScope(
          canPop: false,
          child: Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/success.gif', gaplessPlayback: false,),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Uhhuyyy, Berhasil gawe akun 🥳🥳🥳", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.blue)
                          )
                        ),
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          authController.loginWithUUID().then((value) {
                            if(value){
                              prefs.setBool('login', true).then((value) {
                                Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => const ChatRoomScreen()), (route) => false);
                              });
                            }else{
                              print("gagal login dengan UUID");
                            }
                          });
                        }, 
                        child: const Text("OK GASSSS...", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}