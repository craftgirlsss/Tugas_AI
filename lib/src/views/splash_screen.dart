import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uas_ai/src/controllers/auth_controller.dart';
import 'package:uas_ai/src/views/index.dart';
import 'package:uas_ai/src/views/login.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  AuthController authController = Get.put(AuthController());
  
  Future<bool> getLoginInformation()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('login') ?? false;
  }

  @override
  void initState() {
    super.initState();
    permissionServiceCall(context);
    getLoginInformation().then((value) {
      Future.delayed(const Duration(seconds: 2), (){
        if(value){
          authController.loginWithUUID().then((value){ 
            print("Ini value UUID $value");
            Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => const ChatRoomScreen()), (route) => false);
          }
        );
        }else{
          Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => const LoginPage()), (route) => false);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    image: const DecorationImage(image: AssetImage('assets/icons/ic_launcher.png'))
                  ),)
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CupertinoActivityIndicator(color: Colors.white60),
              ),
              const Text("Ndolek i informasimu...")
            ],
          )),
      ),
    );
  }

  Future permissionServiceCall(BuildContext context) async {  
    final permissionStatusStorage = await Permission.storage.status;
    if (permissionStatusStorage.isDenied) {
        await Permission.storage.request();
    } else if (permissionStatusStorage.isPermanentlyDenied) {
        await openAppSettings();
    } else {
      print(permissionStatusStorage);
    }
    
    final permissionStatusCamera = await Permission.camera.status;
    if (permissionStatusCamera.isDenied) {
        await Permission.camera.request();
    } else if (permissionStatusCamera.isPermanentlyDenied) {
        await openAppSettings();
    } else {
      print(permissionStatusCamera);
    }

    final permissionStatusPhotos = await Permission.photos.status;
    if (permissionStatusPhotos.isDenied) {
        await Permission.photos.request();
    } else if (permissionStatusPhotos.isPermanentlyDenied) {
        await openAppSettings();
    } else {
      print(permissionStatusPhotos);
    }
  }
}