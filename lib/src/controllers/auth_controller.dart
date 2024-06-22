import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uas_ai/src/helpers/random_string.dart';
import 'package:uas_ai/src/models/user_models.dart';

class AuthController extends GetxController{
  var isLoading = false.obs;
  var userModels = <UserModels>[].obs;

  Future<bool> login({String? nim, String? password}) async {
    String? uuid;
    isLoading(true);
    List result = await Supabase.instance.client.from('tugas_ai_auth').select('*').eq('nim', nim!).eq('password', password!).limit(1);
    if(result.length == 0){
      isLoading(false);
      return false;
    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(await prefs.setBool('login', true)){
        userModels.value = result.map((e) => UserModels.fromJson(e)).toList();
        uuid = userModels[0].uuid;
        if(await prefs.setString('uuid', userModels[0].uuid!)){
          print("ini UUID setelah login dengan nim dan password $uuid");
        }
        isLoading(false);
        return true;
      }else{
        isLoading(false);
        return false;
      }
    }
  }

  Future<bool> register({String? nim, String? email, String? fullName, String? password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uuid = getRandomString(20);
    isLoading(true);
    List result = await Supabase.instance.client.from('tugas_ai_auth').insert([
      {
        'nama' : fullName,
        'nim'  : nim, 
        'uuid' : uuid,
        'email': email,
        'password' : password
      }
    ]).select();

    print(result);
    if(result.length == 0){
      return false;
    }else{
      if(await prefs.setString('uuid', uuid)){
        isLoading(false);
        return true;
      }
      isLoading(false);
      return false;
    }
  }

  Future<bool> loginWithUUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uuid = prefs.getString('uuid');
    print("ini UUID $uuid");
    isLoading(true);
    List? result = await Supabase.instance.client.from('tugas_ai_auth').select('*').eq('uuid', uuid!).limit(1);
    print(result);
    if(result.isEmpty){
      isLoading(false);
      return false;
    }else{
      userModels.value = result.map((e) => UserModels.fromJson(e)).toList();
      isLoading(false);
      return true;
    }
  }
}