import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uas_ai/src/controllers/auth_controller.dart';

class ChatControllers extends GetxController {
  AuthController authController = Get.find();
  var chatModels = <ChatModels>[].obs;
  var isLoading = false.obs;

  Future<bool> insertMessage({String? message, bool? isSender}) async {
    int? id = authController.userModels[0].id;
    print("ini id auth $id");
    isLoading(true);
    List result = await Supabase.instance.client.from('tugas_ai_chat').insert([{
      'message' : message,
      'auth_id' : id,
      'is_sender' : isSender
    }]).select();
    print(result);
    if(result.length == 0){
      isLoading(false);
      return false;
    }else{
      isLoading(false);
      return true;
    }
  }

  Future<bool> getHistoryMessages() async {
    int? id = authController.userModels[0].id;
    print("ini id auth $id");
    isLoading(true);
    List? result = await Supabase.instance.client.from('tugas_ai_chat').select('*').eq('auth_id', id!);
    print(result);
    if(result.isEmpty){
      isLoading(false);
      return false;
    }else{
      chatModels.value = result.map((value) => ChatModels.fromJson(value)).toList();
      isLoading(false);
      return true;
    }
  }
}

class ChatModels {
  String? messages;
  bool? isSender;
  
  ChatModels({
    this.isSender,
    this.messages
  });

  factory ChatModels.fromJson(Map<String?, dynamic> json){
    return ChatModels(
      isSender: json['is_sender'],
      messages: json['message']
    );
  }
}