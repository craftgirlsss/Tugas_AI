import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas_ai/src/views/login.dart';

showProfileInformation(context, {String? nama, String? nim, String? email}){
    showCupertinoModalPopup(
      barrierColor: CupertinoColors.black.withOpacity(0.4),
      semanticsDismissible: true,
      barrierDismissible: true,
      context: context,
      builder: (contex) => CupertinoPopupSurface(
        isSurfacePainted: true,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: CupertinoColors.darkBackgroundGray,
            borderRadius: BorderRadius.circular(13),
            border: const Border(
              top: BorderSide(color: Colors.white30, width: 0.3)
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    image: const DecorationImage(image: AssetImage('assets/icons/ic_launcher.png'))
                  ),)
              ),
                const SizedBox(height: 5),
                DefaultTextStyle(
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  child: Text(nama ?? 'Gak ono jenenge')
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: DefaultTextStyle(
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.white54),
                    child: Text(email ?? '0')
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: DefaultTextStyle(
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.white54),
                    child: Text(nim ?? '0')
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CupertinoColors.systemRed
                  ),
                  onPressed: ()async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove('login').then((value) => Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => const LoginPage()), (route) => false));
                }, child: const Text("Log out", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),))
              ],
            ),
          ),
        ),
      )
    );
  }