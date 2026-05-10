import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/providers/ai_provider.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final ChatUser _user = ChatUser(id: '1', firstName: 'Student');
  final ChatUser _ai = ChatUser(id: '2', firstName: 'UniBite AI');
  List<ChatMessage> _messages = [];
  
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();
  bool _isListening = false;
  bool _isTtsEnabled = true;

  @override
  void initState() {
    super.initState();
    _messages.add(ChatMessage(
      text: 'Hi there! I\'m your UniBite AI assistant. How can I help you eat today?',
      user: _ai,
      createdAt: DateTime.now(),
    ));
  }

  List<ChatUser> _typingUsers = [];

  Future<void> _onSend(ChatMessage message) async {
    setState(() {
      _messages.insert(0, message);
      _typingUsers.add(_ai);
    });

    final aiProvider = Provider.of<AIProvider>(context, listen: false);
    final response = await aiProvider.getChatResponse(message.text);

    final aiMessage = ChatMessage(
      text: response,
      user: _ai,
      createdAt: DateTime.now(),
    );

    setState(() {
      _messages.insert(0, aiMessage);
      _typingUsers.remove(_ai);
    });

    if (_isTtsEnabled) {
      await _tts.speak(response);
    }
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (val) {
          if (val.finalResult) {
            setState(() => _isListening = false);
            _onSend(ChatMessage(
              text: val.recognizedWords,
              user: _user,
              createdAt: DateTime.now(),
            ));
          }
        });
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('UniBite AI', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isTtsEnabled ? Icons.volume_up : Icons.volume_off, color: AppColors.primaryPink),
            onPressed: () => setState(() => _isTtsEnabled = !_isTtsEnabled),
          ),
        ],
      ),
      body: DashChat(
        currentUser: _user,
        onSend: _onSend,
        messages: _messages,
        typingUsers: _typingUsers,
        inputOptions: InputOptions(
          inputDecoration: InputDecoration(
            hintText: 'Ask me anything...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            filled: true,
            fillColor: Colors.grey.shade100,
          ),
          trailing: [
            IconButton(
              icon: Icon(_isListening ? Icons.mic : Icons.mic_none, color: AppColors.primaryPink),
              onPressed: _listen,
            ),
          ],
        ),
        messageOptions: const MessageOptions(
          showCurrentUserAvatar: true,
          showTime: true,
          currentUserContainerColor: AppColors.primaryPink,
        ),
      ),
    );
  }
}
