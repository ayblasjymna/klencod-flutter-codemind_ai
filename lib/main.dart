
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const CodeMindApp());
}

const Color bg = Color(0xFF0B0F19);
const Color panel = Color(0xFF161E2D);
const Color blue = Color(0xFF5792FF);
const Color borderColor = Color(0xFF29364A);

class CodeMindApp extends StatelessWidget {
  const CodeMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CodeMind AI',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: blue,
          brightness: Brightness.dark,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget feature(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatScreen(initialPrompt: title),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: panel,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: blue, size: 30),
            const SizedBox(height: 18),
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF19243A),
          title: const Text(
            'CodeMind AI',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SettingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(18),
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF174A9C),
                      Color(0xFF172C50),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.smart_toy, size: 38),
                    SizedBox(height: 18),
                    Text(
                      'ماذا تريد أن تبرمج اليوم؟',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'اكتب فكرتك وسنساعدك على تحويلها إلى مشروع برمجي.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'أدوات البرمجة',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.15,
                children: [
                  feature(context, Icons.code,
                      'كتابة الأكواد', 'إنشاء أكواد كاملة'),
                  feature(context, Icons.android,
                      'تطبيقات أندرويد', 'بناء تطبيقات جديدة'),
                  feature(context, Icons.bug_report,
                      'إصلاح الأخطاء', 'تحليل وتصحيح الأكواد'),
                  feature(context, Icons.science,
                      'اختبار المشاريع', 'فحص البرامج والنتائج'),
                  feature(context, Icons.folder,
                      'إدارة المشاريع', 'تنظيم الملفات والمجلدات'),
                  feature(context, Icons.web,
                      'تطوير المواقع', 'إنشاء مواقع إلكترونية'),
                ],
              ),
              const SizedBox(height: 28),
              const Text(
                'ابدأ محادثة جديدة',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 55,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.chat),
                  label: const Text('ابدأ المحادثة'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ChatScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage(this.text, this.isUser);
}

class ChatScreen extends StatefulWidget {
  final String? initialPrompt;

  const ChatScreen({super.key, this.initialPrompt});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final List<ChatMessage> messages = [];

  @override
  void initState() {
    super.initState();

    messages.add(
      ChatMessage(
        'مرحباً بك في CodeMind AI.\n'
        'أنا مساعدك المتخصص في البرمجة.\n'
        'ما المشروع الذي تريد العمل عليه؟',
        false,
      ),
    );

    if (widget.initialPrompt != null) {
      controller.text = 'أريد المساعدة في ${widget.initialPrompt}';
    }
  }

  void sendMessage() {
    final text = controller.text.trim();

    if (text.isEmpty) return;

    setState(() {
      messages.add(ChatMessage(text, true));

      messages.add(
        ChatMessage(
          'تم استلام طلبك بنجاح.\n\n'
          'محرك الذكاء الاصطناعي لم يتم ربطه بعد. '
          'سيتم تفعيله في المرحلة القادمة.',
          false,
        ),
      );
    });

    controller.clear();

    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget messageBubble(ChatMessage message) {
    return Align(
      alignment: message.isUser
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 310),
        margin: const EdgeInsets.symmetric(vertical: 7),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: message.isUser
              ? const Color(0xFF174A9C)
              : panel,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              message.text,
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
              ),
            ),
            if (!message.isUser)
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  tooltip: 'نسخ الرد',
                  icon: const Icon(Icons.copy, size: 17),
                  onPressed: () {
                    Clipboard.setData(
                      ClipboardData(text: message.text),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم نسخ النص'),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF19243A),
          title: const Text('CodeMind AI'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'محادثة جديدة',
              onPressed: () {
                setState(() {
                  messages.clear();
                  messages.add(
                    ChatMessage(
                      'مرحباً! كيف أساعدك في البرمجة؟',
                      false,
                    ),
                  );
                });
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return messageBubble(messages[index]);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: panel,
                border: Border(
                  top: BorderSide(color: borderColor),
                ),
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        minLines: 1,
                        maxLines: 5,
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                          hintText: 'اكتب طلبك البرمجي...',
                          filled: true,
                          fillColor: bg,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: sendMessage,
                      icon: const Icon(
                        Icons.send_rounded,
                        color: blue,
                        size: 29,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الإعدادات'),
          backgroundColor: const Color(0xFF19243A),
        ),
        body: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            const ListTile(
              leading: Icon(Icons.smart_toy, color: blue),
              title: Text('CodeMind AI'),
              subtitle: Text('المساعد البرمجي الذكي'),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.shield, color: blue),
              title: Text('سياسات الحماية'),
              subtitle: Text('سيتم تجهيز لوحة القوانين في المرحلة القادمة'),
            ),
            const ListTile(
              leading: Icon(Icons.admin_panel_settings, color: blue),
              title: Text('لوحة المالك'),
              subtitle: Text('إدارة النظام والصلاحيات'),
            ),
            const ListTile(
              leading: Icon(Icons.info_outline, color: blue),
              title: Text('حول التطبيق'),
              subtitle: Text('CodeMind AI'),
            ),
          ],
        ),
      ),
    );
  }
}
