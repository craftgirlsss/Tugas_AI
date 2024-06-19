import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uas_ai/src/components/gradient_text.dart';
import 'package:uas_ai/src/components/greetings_text.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 10,
        title: Text("Tugas AI", style: GoogleFonts.sourceCodePro(color: Colors.white),),
        actions: [
          IconButton(
            onPressed: (){},
            icon: CircleAvatar(
              onBackgroundImageError: (exception, stackTrace) => Image.asset('assets/icons/ic_launcher.png'),
              backgroundImage: const AssetImage('assets/icons/ic_launcher.png'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            GradientText(
              text: "Sugeng ${greeting()}",
              gradient: LinearGradient(colors: [
                Colors.green.shade300,
                Colors.blue.shade700,
              ]),
              style: GoogleFonts.sourceCodePro(fontSize: 30, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}