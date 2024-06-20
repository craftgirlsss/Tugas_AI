import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:uas_ai/src/components/bottom_sheet_preview.dart';
import 'package:uas_ai/src/components/greetings_text.dart';
import 'package:uas_ai/src/controllers/auth_controller.dart';
import '../controllers/generate_ai_controller.dart';

enum TtsState { playing, stopped, paused, continued }

class ChatModels {
  String? text;
  bool? sender;

  ChatModels({this.sender, this.text});
}

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  SpeechToText speechToText = SpeechToText();
  AuthController authController = Get.find();
  GenerateController aiController = Get.put(GenerateController());
  TextEditingController textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  // FlutterTts flutterTts = FlutterTts();
  bool speechEnabled = false;
  String lastWords = '';
  TtsState ttsState = TtsState.stopped;
  bool get isPlaying => ttsState == TtsState.playing;
  bool get isStopped => ttsState == TtsState.stopped;
  bool get isPaused => ttsState == TtsState.paused;
  bool get isContinued => ttsState == TtsState.continued;
  List<ChatModels> textMessageBubble = [];
  bool _needsScroll = false;

  void _initSpeech() async {
    speechEnabled = await speechToText.initialize();
  }

  void startListening() async {
    await speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  // Future _speak(String text) async{
  //   var result = await flutterTts.speak(text);
  //   if (result == 1) setState(() => ttsState = TtsState.playing);
  // }

  // Future stopSpeak() async{
  //     var result = await flutterTts.stop();
  //     if (result == 1) setState(() => ttsState = TtsState.stopped);
  // }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
      textEditingController.text = result.recognizedWords;
    });
    if(result.finalResult){
      textMessageBubble.add(ChatModels(sender: true, text: result.recognizedWords));
      textEditingController.clear();
      aiController.postPromptGemini([Content.text(result.recognizedWords)]).then(
        (value) {
          textMessageBubble.add(ChatModels(sender: false, text: value));
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut
          );
          _needsScroll = true;
          // _speak(value);
        }
      );
    }
  }
  

  @override
  void initState() {
    _initSpeech();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_needsScroll) {
      _scrollToEnd();
      _needsScroll = false;
    }
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 10,
          title: Obx(() => Text("Sugeng ${greeting().toLowerCase()}, ${authController.userModels[0].nama}", overflow: TextOverflow.fade, style: GoogleFonts.sourceCodePro(color: Colors.white, fontSize: 18),)),
          actions: [
            Obx(() => IconButton(
                onPressed: authController.isLoading.value ? (){} : () async {
                  showProfileInformation(context, nama: authController.userModels[0].nama, nim: authController.userModels[0].nim, email: authController.userModels[0].email);
                },
                icon: CircleAvatar(
                  onBackgroundImageError: (exception, stackTrace) => Image.asset('assets/icons/ic_launcher.png'),
                  backgroundImage: const AssetImage('assets/icons/ic_launcher.png'),
                ),
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover
                )
              ),
            ),
            SafeArea(
              child: Obx(() => aiController.isLoading.value ? 
              SingleChildScrollView(
                controller: _scrollController,
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 50),
                  child: Column(
                    children: List.generate(textMessageBubble.length, (index) => BubbleSpecialThree(
                      isSender: textMessageBubble[index].sender ?? true,
                      text: textMessageBubble[index].text ?? '',
                      color: textMessageBubble[index].sender == true ? CupertinoColors.activeGreen : CupertinoColors.activeBlue,
                      tail: true,
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 16),
                      ),
                    )
                  ),
                ) : SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 70),
                  child: Column(
                    children: List.generate(textMessageBubble.length, (index) => 
                    CupertinoContextMenu(
                      enableHapticFeedback: true,
                      actions: [
                        CupertinoContextMenuAction(
                          onPressed: () async {
                            await Clipboard.setData(ClipboardData(text: textMessageBubble[index].text ?? '')).then((value) => Navigator.pop(context));
                          },
                          isDefaultAction: true,
                          trailingIcon: CupertinoIcons.doc_on_clipboard_fill,
                          child: const Text('Copy'),
                        ),
                      ],
                      child: DefaultTextStyle(
                        style: const TextStyle(),
                        child: BubbleSpecialThree(
                          seen: true,
                          isSender: textMessageBubble[index].sender ?? true,
                          text: textMessageBubble[index].text ?? '',
                          color: textMessageBubble[index].sender == true ? CupertinoColors.activeGreen : CupertinoColors.activeBlue,
                          tail: true,
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 16),
                          ),
                      ),
                      ),
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipOval(
                    child: Material(
                      color: speechToText.isNotListening ? CupertinoColors.systemBlue : CupertinoColors.activeGreen, // Button color
                      child: InkWell(
                        splashColor: Colors.red, // Splash color
                        onTap:  speechToText.isNotListening ? startListening : stopListening,
                        child: AnimatedSize(
                          duration: const Duration(milliseconds: 800),
                          curve: speechToText.isNotListening ? Curves.fastLinearToSlowEaseIn : Curves.fastEaseInToSlowEaseOut,
                          child: SizedBox(width: speechToText.isNotListening ? 32 : 50, height: speechToText.isNotListening ? 32 : 50, child: Icon(speechToText.isNotListening ? CupertinoIcons.mic : CupertinoIcons.mic_fill, color: Colors.white, size: 22))),
                      ),
                    ),
                  ),
                const SizedBox(width: 10), 
                Expanded(
                  child: SizedBox(
                    height: 30,
                    child: Obx(() => CupertinoTextField(
                        textInputAction: TextInputAction.go,
                        onSubmitted: aiController.isLoading.value ? (value) {} : (value) {
                          setState(() {
                            textMessageBubble.add(ChatModels(sender: true, text: textEditingController.text));
                          });
                          aiController.postPromptGemini([Content.text(textEditingController.text)]).then(
                            (value) {
                              textMessageBubble.add(ChatModels(sender: false, text: value));
                              // _speak(value);
                              setState(() {
                                _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeInOut
                                );
                                _needsScroll = true;
                              });
                            }
                          );
                          textEditingController.clear();
                        },
                        enableSuggestions: true,
                        padding: const EdgeInsets.only(left: 10),
                        textAlignVertical: TextAlignVertical.center,
                        controller: textEditingController,
                        style: const TextStyle(color: Colors.white, fontFamily: "SF-Pro-Bold", fontSize: 17),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white54, width: 0.4)
                        ),
                        cursorColor: CupertinoColors.systemBlue,
                        keyboardType: TextInputType.multiline,
                        placeholder: "Tulis ning kene...",
                        placeholderStyle: const TextStyle(color: Colors.white38),
                      ),
                    ),
                  )
                ),
                const SizedBox(width: 10),
                ClipOval(
                  child: Material(
                    color: CupertinoColors.activeGreen, // Button color
                    child: Obx(() => InkWell(
                        splashColor: Colors.red, // Splash color
                        onTap: aiController.isLoading.value ? (){} : () {
                          HapticFeedback.vibrate();
                          setState(() {
                            textMessageBubble.add(ChatModels(sender: true, text: textEditingController.text));
                          });
                          aiController.postPromptGemini([Content.text(textEditingController.text)]).then(
                            (value) {
                              textMessageBubble.add(ChatModels(sender: false, text: value));
                              // _speak(value);
                              setState(() {
                                _scrollController.animateTo(
                                  _scrollController.position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeInOut
                                );
                                _needsScroll = true;
                              });
                            }
                          );
                          textEditingController.clear();
                        },
                        child: const SizedBox(width: 32, height: 32, child: Icon(CupertinoIcons.arrow_up, color: Colors.white, size: 22)),
                      ),
                    ),
                  ),
                )    
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  _scrollToEnd() async {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(microseconds: 200), curve: Curves.easeInOut);
  }
}