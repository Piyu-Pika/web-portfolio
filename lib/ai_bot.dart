import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class MyAiScreen extends StatefulWidget {
  const MyAiScreen({super.key});

  @override
  State<MyAiScreen> createState() => _MyAiScreenState();
}

class _MyAiScreenState extends State<MyAiScreen> {
  final _textController = TextEditingController();
  final gemini = Gemini.instance;
  final List<ChatMessage> _messages = [];

  final String portfolioInfo = '''
    Name: Piyush Bhardwaj
    Role: Flutter Developer | Computer Science Student
    Skills: Flutter, Dart, Firebase, Python, C, C++, Android SDK, Git, GitHub
    Projects:
    1. GSIP (March 2024)
    2. MY AI (Personal Project, March 2024)
    3. Anime Quote App (Personal Project, March 2024)
    4. CodSoft Quote Model (Codsoft, May 2024)
    5. Cancer Predictor (YBI Foundation, May 2024)
    6. Purchase Prediction and MicroUniversity (YBI Foundation, March 2024)
    7. Codsoft To-do List (Codsoft, March 2024)
    Education:
    - B.Tech in Computer Science, Chaudhary Charan Singh University (2022-2026)
    Certifications:
    - C++ (Letsupgrade)
    - Python (GUVI)
    - AI for India 2.0 (GUVI)
    - Introduction to Flutter (CareerNinja)
  ''';

  Future<void> _sendMessage() async {
    if (_textController.text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        text: _textController.text,
        isUser: true,
      ));
    });

    String prompt = '''
    Based on the following portfolio information:
    $portfolioInfo
    
    Please respond to this user query:
    ${_textController.text}
    
    Respond as if you're an AI assistant for this portfolio owner.
    ''';

    final response = await gemini.text(prompt);
    setState(() {
      _messages.add(ChatMessage(
        text: response?.content?.parts?.last.text ??
            'Sorry, I could not process that.',
        isUser: false,
      ));
    });

    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Portfolio AI'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Ask about my portfolio...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[800],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatMessage({super.key, required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) CircleAvatar(child: Text('AI')),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: isUser ? Colors.deepPurple[100] : Colors.grey[800],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(text),
                ),
              ],
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 10),
            const CircleAvatar(child: Icon(Icons.person)),
          ],
        ],
      ),
    );
  }
}
