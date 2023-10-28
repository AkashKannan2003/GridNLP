import 'package:chatbot/Constants/constants.dart';
import 'package:chatbot/Screens/widgets/ChatMessage.dart';
import 'package:chatbot/Screens/widgets/Drawer.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  late bool isFilled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: primaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          Container(
            decoration:  BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [scaffoldBackgroundColor, cardColor],
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  color: primaryColor,
                  child: ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return _messages[index];
                    },
                  ),
                ),
              ),
              _buildMessageComposer(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      color: primaryColor,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A3F),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            isFilled = value.isNotEmpty;
                          });
                        },
                        maxLines: null,
                        controller: _textController,
                        decoration: const InputDecoration(
                          hintText: "Message",
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(color: Colors.white54),
                        onSubmitted: _handleSubmitted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Container(
            decoration: BoxDecoration(
              color: isFilled
                  ? const Color(0xFFEA3799)
                  : const Color(0xFF1A1A3F),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.send_rounded,
                color: Colors.white54,
              ),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text, backgroundColor: Colors.redAccent, isUser: true,
    );
    setState(() {
      _messages.add(message);
    });

    // Simulate a response message (you can replace this with your actual response logic)
    Future.delayed(const Duration(seconds: 1), () {
      ChatMessage responseMessage = const ChatMessage(
        text: 'This is a response message.', backgroundColor: Colors.white70, isUser: false,
      );
      setState(() {
        _messages.add(responseMessage);
      });
    });
  }
}
