
import 'package:flutter/material.dart';

void main() {
  runApp(const CodeMindApp());
}

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
        scaffoldBackgroundColor: const Color(0xFF0B0F19),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3978F6),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controller = TextEditingController();

  void sendMessage() {
    if (controller.text.trim().isEmpty) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('سيتم ربط الذكاء الاصطناعي في المرحلة القادمة'),
      ),
    );

    controller.clear();
  }

  Widget featureCard(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161E2D),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF29364A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF5792FF), size: 28),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF111827),
          title: const Row(
            children: [
              Icon(Icons.code, color: Color(0xFF5792FF)),
              SizedBox(width: 10),
              Text(
                'CodeMind AI',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                const Text(
                  'مرحباً بك في CodeMind',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'مساعدك الذكي لإنشاء وبرمجة واختبار المشاريع.',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 28),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF174A9C),
                        Color(0xFF172C50),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.smart_toy, size: 38),
                      SizedBox(height: 14),
                      Text(
                        'ماذا تريد أن تبرمج اليوم؟',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'اكتب فكرتك وسنساعدك على تحويلها إلى مشروع برمجي.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  'أدوات البرمجة',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 14),

                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.25,
                  children: [
                    featureCard(
                      Icons.code,
                      'كتابة الأكواد',
                      'إنشاء أكواد كاملة',
                    ),
                    featureCard(
                      Icons.android,
                      'تطبيقات أندرويد',
                      'بناء تطبيقات جديدة',
                    ),
                    featureCard(
                      Icons.bug_report,
                      'إصلاح الأخطاء',
                      'تحليل وتصحيح الأكواد',
                    ),
                    featureCard(
                      Icons.science,
                      'اختبار المشاريع',
                      'فحص البرامج والنتائج',
                    ),
                    featureCard(
                      Icons.folder_open,
                      'إدارة المشاريع',
                      'تنظيم الملفات والمجلدات',
                    ),
                    featureCard(
                      Icons.web,
                      'تطوير المواقع',
                      'إنشاء مواقع إلكترونية',
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                const Text(
                  'ابدأ مشروعك',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF161E2D),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF34445E),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          maxLines: 3,
                          minLines: 1,
                          decoration: const InputDecoration(
                            hintText: 'صف المشروع الذي تريد إنشاءه...',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: sendMessage,
                        icon: const Icon(
                          Icons.send_rounded,
                          color: Color(0xFF5792FF),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                const Center(
                  child: Text(
                    'CodeMind AI • مساعدك البرمجي الذكي',
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 12,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
