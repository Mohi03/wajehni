import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  Locale? _locale;

  void _pingServer() async {
    const serverUrl = 'https://wojhati.onrender.com/';
    try {
      await http.get(Uri.parse(serverUrl));
    } catch (e) {}
  }

  void setThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    _pingServer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wejehni',
      theme: ThemeData(
        fontFamily: 'Segoe UI',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF22C55E),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 2,
          shadowColor: Colors.green.withAlpha(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            shadowColor: Colors.green.withAlpha(25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: const Color(0xFF22C55E),
            foregroundColor: Colors.white,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF22C55E),
          brightness: Brightness.dark,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shadowColor: Colors.green.withAlpha(23),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            shadowColor: Colors.green.withAlpha(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: const Color(0xFF22C55E),
            foregroundColor: Colors.white,
          ),
        ),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 1,
        ),
      ),
      themeMode: _themeMode,
      locale: _locale,
      home: MainNavigation(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Directionality(textDirection: TextDirection.rtl, child: HomePage()),
    Directionality(textDirection: TextDirection.rtl, child: SettingsPage()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'الإعدادات',
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      setState(() {
        isDarkMode = isDark;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'الإعدادات',
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 1,
        ),
        body: Container(
          color: isDark ? const Color(0xFF1a1a1a) : const Color(0xFFf8f9fa),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile(
                  title: Text(
                    'الوضع الليلي',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                    final mode = value ? ThemeMode.dark : ThemeMode.light;
                    MyApp.of(context)?.setThemeMode(mode);
                  },
                  secondary: Icon(
                    isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                // In SettingsPage, replace the language SwitchListTile with a DropdownButton for language selection.
                // Use AppLocalizations for all text, including specialty dropdown, buttons, and app name.
                // Example for the language dropdown:
                // Row(
                //   children: [
                //     Icon(
                //       Icons.language,
                //       color: isDark ? Colors.white : Colors.black87,
                //     ),
                //     const SizedBox(width: 12),
                //     Text(
                //       'اللغة',
                //       style: TextStyle(
                //         fontWeight: FontWeight.bold,
                //         color: isDark ? Colors.white : Colors.black87,
                //       ),
                //     ),
                //     const SizedBox(width: 16),
                //     DropdownButton<Locale>(
                //       value: Localizations.localeOf(context),
                //       items: [
                //         DropdownMenuItem(
                //           value: const Locale('ar'),
                //           child: Text('العربية'),
                //         ),
                //         DropdownMenuItem(
                //           value: const Locale('en'),
                //           child: Text('الإنجليزية'),
                //         ),
                //       ],
                //       onChanged: (locale) {
                //         if (locale != null) {
                //           MyApp.of(context)?.setLocale(locale);
                //         }
                //       },
                //     ),
                //   ],
                // ),
                // App Info Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withAlpha(25),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.school,
                                color: Theme.of(context).colorScheme.primary,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'الإصدار: 1.0.0',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDark
                                          ? Colors.white60
                                          : Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'تطبيق وجهني يساعدك في اختيار التخصص الجامعي المناسب لك بناءً على إجاباتك على مجموعة من الأسئلة المخصصة لكل تخصص. هذا التطبيق إصدار تجريبي وقد يحتوي على بعض الأخطاء أو المشاكل. نرحب بأي ملاحظات أو اقتراحات لتحسين التجربة.',
                          style: TextStyle(
                            fontSize: 15,
                            color: isDark ? Colors.white70 : Colors.black54,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Instructions Card (How to use)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.purple.withAlpha(25),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.help_outline,
                                color: Colors.purple,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: AutoSizeText(
                                'كيفية الاستخدام',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                                maxLines: 1,
                                minFontSize: 12,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildInstructionStep(
                          context,
                          '1',
                          'اختر شعبتك',
                          Icons.category,
                        ),
                        _buildInstructionStep(
                          context,
                          '2',
                          'أجب على الأسئلة بصدق ودقة',
                          Icons.edit,
                        ),
                        _buildInstructionStep(
                          context,
                          '3',
                          'احصل على التوصيات المناسبة',
                          Icons.recommend,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Support Card (moved up)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.red.withAlpha(25),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.support_agent,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: AutoSizeText(
                                'الدعم الفني',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                                maxLines: 1,
                                minFontSize: 12,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withAlpha(25),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.email,
                              color: Theme.of(context).colorScheme.primary,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            'البريد الإلكتروني',
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            'ONJPA57@gmail.com',
                            style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                          trailing: Icon(
                            Icons.copy,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                          onTap: () async {
                            await Clipboard.setData(
                              ClipboardData(text: 'ONJPA57@gmail.com'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'تم النسخ',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                duration: const Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            );
                          },
                        ),
                        // Instagram Link
                        ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.pink.withAlpha(25),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.pink,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            'إنستغرام',
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            '@on.youths57',
                            style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                          trailing: Icon(
                            Icons.open_in_new,
                            color: Colors.pink,
                            size: 20,
                          ),
                          onTap: () async {
                            final url = Uri.parse(
                              'https://www.instagram.com/on.youths57?igsh=MzlleWs4cTBtODAw',
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                        ),
                        // Facebook Link (restored)
                        ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue.withAlpha(25),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.facebook,
                              color: Colors.blue,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            'فيسبوك',
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            'صفحة الفيسبوك',
                            style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                          trailing: Icon(
                            Icons.open_in_new,
                            color: Colors.blue,
                            size: 20,
                          ),
                          onTap: () async {
                            final url = Uri.parse(
                              'https://www.facebook.com/share/1GFE5AQ6CN/',
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                        ),
                        // Registration Form Link
                        ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.green.withAlpha(25),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.assignment,
                              color: Colors.green,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            'نموذج التسجيل',
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            'رابط الالتحاق',
                            style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                          trailing: Icon(
                            Icons.open_in_new,
                            color: Colors.green,
                            size: 20,
                          ),
                          onTap: () async {
                            final url = Uri.parse(
                              'https://forms.gle/G76ABDGG2Pms1M7b6',
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Features Section (modern grid layout, no card)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.green, size: 24),
                          const SizedBox(width: 12),
                          Flexible(
                            child: AutoSizeText(
                              'المميزات',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                              maxLines: 1,
                              minFontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1.1,
                        children: [
                          _buildFeatureGridItem(
                            icon: Icons.quiz,
                            title: 'الاختبارات المخصصة',
                            description: 'أسئلة لكل تخصص',
                            color: Colors.green,
                            isDark: isDark,
                          ),
                          _buildFeatureGridItem(
                            icon: Icons.lightbulb,
                            title: 'الاقتراحات الذكية',
                            description: 'الاقتراحات بناءً على الإجابات',
                            color: Colors.green,
                            isDark: isDark,
                          ),
                          _buildFeatureGridItem(
                            icon: Icons.touch_app,
                            title: 'واجهة مبسطة',
                            description: 'تصميم بسيط وسهل',
                            color: Colors.green,
                            isDark: isDark,
                          ),
                          _buildFeatureGridItem(
                            icon: Icons.update,
                            title: 'تحديثات مستمرة',
                            description: 'التحسينات القادمة',
                            color: Colors.green,
                            isDark: isDark,
                          ),
                        ],
                      ),
                    ],
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

  Widget _buildInstructionStep(
    BuildContext context,
    String step,
    String description,
    IconData icon,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                step,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: AutoSizeText(
              description,
              style: TextStyle(
                fontSize: 15,
                color: isDark ? Colors.white : Colors.black87,
              ),
              maxLines: 1,
              minFontSize: 10,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureGridItem({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      constraints: BoxConstraints(minHeight: 120), // Increase min height
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withAlpha(45), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 8,
      ), // More vertical padding
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 36),
          const SizedBox(height: 8),
          AutoSizeText(
            title,
            style: TextStyle(
              fontSize: 14, // Reduce font size
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.green.shade800,
            ),
            textAlign: TextAlign.center,
            maxLines: 2, // Allow up to 2 lines
            minFontSize: 9,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          AutoSizeText(
            description,
            style: TextStyle(
              fontSize: 12, // Reduce font size
              color: isDark ? Colors.white70 : Colors.green.shade700,
            ),
            textAlign: TextAlign.center,
            maxLines: 4, // Allow up to 4 lines
            minFontSize: 8,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> specialties = [
    {'value': '', 'label': '--اختر--'},
    {'value': 'Experimental Sciences', 'label': 'شعبة العلوم التجريبية'},
    {'value': 'Mathematics', 'label': 'شعبة الرياضيات'},
    {'value': 'Technical Mathematics', 'label': 'شعبة التقني رياضي'},
    {'value': 'Management and Economics', 'label': 'شعبة التسيير والاقتصاد'},
    {'value': 'Foreign Languages', 'label': 'شعبة اللغات الأجنبية'},
    {'value': 'Literature and Philosophy', 'label': 'شعبة الآداب والفلسفة'},
  ];

  String selectedSpecialty = '';
  String specialtyError = '';
  String answersError = '';
  bool loading = false;
  bool showQuestions = false;
  bool showSuggestions = false;
  bool isLoadingSuggestions = false;
  List<String> questions = [];
  String suggestionsText = '';
  int currentQuestionIndex = 0;
  Map<int, String> answers = {};

  Future<void> getQuestions() async {
    if (selectedSpecialty.isEmpty) {
      setState(() {
        specialtyError = 'الرجاء اختيار تخصص.';
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (specialtyError.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      specialtyError,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
          setState(() {
            specialtyError = '';
          });
        }
      });
      return;
    }

    // Check internet connectivity
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: const [
                Icon(Icons.wifi_off, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'لا يوجد اتصال بالإنترنت',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
      return;
    }

    setState(() {
      specialtyError = '';
      loading = true;
      isLoadingSuggestions = false;
      answersError = '';
    });

    try {
      final response = await http.post(
        Uri.parse('https://wojhati.onrender.com/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'specialty': selectedSpecialty}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final questionsText = data['questions'] as String?;

        if (questionsText != null && questionsText.trim().isNotEmpty) {
          final questionLines = questionsText
              .split('\n')
              .where((q) => q.trim().isNotEmpty)
              .toList();
          final firstQuestionIndex = questionLines.indexWhere(
            (q) => RegExp(r'^(\d+)[\.-]').hasMatch(q.trim()),
          );
          questions = firstQuestionIndex != -1
              ? questionLines.sublist(firstQuestionIndex)
              : questionLines;

          setState(() {
            showQuestions = true;
            showSuggestions = false;
            loading = false;
            isLoadingSuggestions = false;
          });
        } else {
          setState(() {
            answersError = 'تعذر استرداد الأسئلة. الرجاء المحاولة مرة أخرى.';
            loading = false;
          });
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (answersError.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          answersError,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
              setState(() {
                answersError = '';
              });
            }
          });
        }
      } else {
        setState(() {
          answersError = 'خطأ في الشبكة! الحالة: ${response.statusCode}';
          loading = false;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (answersError.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        answersError,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
            setState(() {
              answersError = '';
            });
          }
        });
      }
    } catch (e) {
      setState(() {
        answersError = 'فشل تحميل الأسئلة. ${e.toString()}';
        loading = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (answersError.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      answersError,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
          setState(() {
            answersError = '';
          });
        }
      });
    }
  }

  Future<void> submitAnswers() async {
    answersError = '';
    final studentAnswers = <Map<String, String>>[];

    for (int i = 0; i < questions.length; i++) {
      final answer = answers[i] ?? '';
      studentAnswers.add({'question': questions[i], 'answer': answer});
    }

    final allAnswered = studentAnswers.every(
      (item) => item['answer']!.isNotEmpty,
    );

    if (!allAnswered) {
      setState(() {
        answersError = 'الرجاء الإجابة على جميع الأسئلة قبل الإرسال.';
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (answersError.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      answersError,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
          setState(() {
            answersError = '';
          });
        }
      });
      return;
    }

    setState(() {
      loading = true;
      isLoadingSuggestions = true;
      answersError = '';
    });

    try {
      final response = await http.post(
        Uri.parse('https://wojhati.onrender.com/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'answers': studentAnswers,
          'specialty': selectedSpecialty,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final suggestions = data['suggestions'] as String?;

        setState(() {
          suggestionsText = suggestions ?? '';
          showSuggestions = true;
          showQuestions = false;
          loading = false;
          isLoadingSuggestions = false;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'تم إرسال الإجابات بنجاح',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        });
      } else {
        setState(() {
          answersError = 'خطأ في الشبكة! الحالة: ${response.statusCode}';
          loading = false;
          isLoadingSuggestions = false;
        });
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (answersError.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        answersError,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
            setState(() {
              answersError = '';
            });
          }
        });
      }
    } catch (e) {
      setState(() {
        answersError = 'فشل الحصول على الاقتراحات. ${e.toString()}';
        loading = false;
        isLoadingSuggestions = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (answersError.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      answersError,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
          setState(() {
            answersError = '';
          });
        }
      });
    }
  }

  void startOver() {
    setState(() {
      selectedSpecialty = '';
      specialtyError = '';
      answersError = '';
      showQuestions = false;
      showSuggestions = false;
      isLoadingSuggestions = false;
      questions = [];
      answers.clear();
      suggestionsText = '';
      currentQuestionIndex = 0;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: null,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 1,
      ),
      body: Stack(
        children: [
          Container(
            color: isDark ? const Color(0xFF1a1a1a) : const Color(0xFFf8f9fa),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 500),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: _buildContent(context),
                  ),
                ),
              ),
            ),
          ),
          if (loading)
            AnimatedOpacity(
              opacity: loading ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    color: Colors.black.withOpacity(0.25),
                    child: Center(
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: isDark ? Colors.grey[900] : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 36,
                            vertical: 40,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: CircularProgressIndicator(
                                  strokeWidth: 6,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 28),
                              Text(
                                isLoadingSuggestions
                                    ? 'جاري تحميل الاقتراحات'
                                    : 'جاري تحميل الأسئلة',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    Widget content;
    if (!showQuestions && !showSuggestions) {
      content = _buildMainPage(context);
    } else if (showQuestions && questions.isNotEmpty) {
      content = _buildQuestionsPage(context);
    } else {
      content = _buildSuggestionsPage(context);
    }

    return content;
  }

  Widget _buildMainPage(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final List<Map<String, String>> specialtiesLocalized = [
      {'value': '', 'label': '--اختر--'},
      {'value': 'Experimental Sciences', 'label': 'شعبة العلوم التجريبية'},
      {'value': 'Mathematics', 'label': 'شعبة الرياضيات'},
      {'value': 'Technical Mathematics', 'label': 'شعبة التقني رياضي'},
      {'value': 'Management and Economics', 'label': 'شعبة التسيير والاقتصاد'},
      {'value': 'Foreign Languages', 'label': 'شعبة اللغات الأجنبية'},
      {'value': 'Literature and Philosophy', 'label': 'شعبة الآداب والفلسفة'},
    ];

    return Column(
      children: [
        // Header Section
        Card(
          elevation: 6,
          shadowColor: Theme.of(context).colorScheme.primary.withAlpha(45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark ? Colors.grey[900] : Colors.white,
                      border: Border.all(
                        color: isDark
                            ? Colors.green.shade700
                            : Colors.green.shade200,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isDark
                              ? Colors.green.withOpacity(0.18)
                              : Colors.green.withOpacity(0.12),
                          blurRadius: 16,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(8),
                    child: ClipOval(
                      child: Image.asset('pics/1-01-01.png', fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'وجهني',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.green.shade800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'تطبيق لتحديد التخصصات المناسبة لك',
                  style: TextStyle(
                    fontSize: 17,
                    color: isDark ? Colors.white70 : Colors.green.shade700,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 28),
        // Selection Card
        Card(
          elevation: 4,
          shadowColor: Theme.of(context).colorScheme.primary.withAlpha(30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.category,
                      color: Theme.of(context).colorScheme.primary,
                      size: 26,
                    ),
                    const SizedBox(width: 14),
                    // Use Flexible + AutoSizeText for overflow-safe label
                    Flexible(
                      child: AutoSizeText(
                        'اختر التخصص',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.green.shade800,
                        ),
                        maxLines: 1,
                        minFontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                DropdownButtonFormField<String>(
                  value: selectedSpecialty,
                  decoration: InputDecoration(
                    hintText: '--اختر--',
                    hintStyle: TextStyle(
                      color: isDark ? Colors.white60 : Colors.black45,
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12, // slightly reduced for small screens
                      vertical: 12,
                    ),
                    helperText: selectedSpecialty.isEmpty
                        ? 'يرجى اختيار التخصص'
                        : null,
                    helperStyle: TextStyle(color: Colors.red, fontSize: 13),
                  ),
                  isExpanded: true, // Ensures dropdown uses all available width
                  dropdownColor: isDark
                      ? const Color(0xFF2a2a2a)
                      : Colors.white,
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontSize: 16,
                  ),
                  items: specialtiesLocalized.map((
                    Map<String, String> specialty,
                  ) {
                    return DropdownMenuItem<String>(
                      value: specialty['value'],
                      child: Text(
                        specialty['label']!,
                        style: TextStyle(
                          color: specialty['value']!.isEmpty
                              ? (isDark ? Colors.white60 : Colors.black45)
                              : (isDark ? Colors.white : Colors.black87),
                          fontSize: 16,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSpecialty = newValue ?? '';
                      questions = [];
                      currentQuestionIndex = 0;
                      answers.clear();
                      specialtyError = '';
                    });
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: selectedSpecialty.isEmpty ? null : getQuestions,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.play_arrow, size: 20),
                        const SizedBox(width: 8),
                        Flexible(
                          child: AutoSizeText(
                            'ابدأ الاختبار',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            minFontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionsPage(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Safety check to prevent errors
    if (questions.isEmpty || currentQuestionIndex >= questions.length) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text(
                'لا توجد أسئلة حالياً',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    questions = [];
                    currentQuestionIndex = 0;
                    answers.clear();
                    selectedSpecialty = '';
                    specialtyError = '';
                    showQuestions = false;
                  });
                },
                child: Text('العودة للصفحة الرئيسية'),
              ),
            ],
          ),
        ),
      );
    }

    // Load the current answer into the controller when the question changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // No need to update answerController here, as it's removed.
      // The answer is now directly in the 'answers' map.
    });

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.quiz,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'السؤال',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Progress indicator
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white24 : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: (currentQuestionIndex + 1) / questions.length,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'السؤال ${currentQuestionIndex + 1} من ${questions.length}',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
              const SizedBox(height: 24),

              // Question
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white10 : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isDark ? Colors.white24 : Colors.grey.shade300,
                  ),
                ),
                child: AutoSizeText(
                  questions[currentQuestionIndex],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black87,
                    height: 1.5,
                  ),
                  maxLines: 5,
                  minFontSize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 20),

              // Answer input (thinner, icons only on selection)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        answers[currentQuestionIndex] = 'نعم';
                      });
                    },
                    child: Container(
                      height: 48,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: (answers[currentQuestionIndex] == 'نعم')
                            ? Colors.green.shade600
                            : (isDark ? Colors.white12 : Colors.grey.shade100),
                        border: Border.all(
                          color: (answers[currentQuestionIndex] == 'نعم')
                              ? Colors.green.shade700
                              : (isDark
                                    ? Colors.white24
                                    : Colors.grey.shade300),
                          width: (answers[currentQuestionIndex] == 'نعم')
                              ? 2.0
                              : 1.0,
                        ),
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          if (answers[currentQuestionIndex] == 'نعم')
                            BoxShadow(
                              color: Colors.green.withAlpha(45),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (answers[currentQuestionIndex] == 'نعم') ...[
                              Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 22,
                              ),
                              const SizedBox(width: 8),
                            ],
                            Flexible(
                              child: AutoSizeText(
                                'نعم',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      (answers[currentQuestionIndex] == 'نعم')
                                      ? Colors.white
                                      : Colors.green.shade700,
                                ),
                                maxLines: 1,
                                minFontSize: 10,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        answers[currentQuestionIndex] = 'غير متأكد';
                      });
                    },
                    child: Container(
                      height: 48,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: (answers[currentQuestionIndex] == 'غير متأكد')
                            ? Colors.amber.shade600
                            : (isDark ? Colors.white12 : Colors.grey.shade100),
                        border: Border.all(
                          color: (answers[currentQuestionIndex] == 'غير متأكد')
                              ? Colors.amber.shade700
                              : (isDark
                                    ? Colors.white24
                                    : Colors.grey.shade300),
                          width: (answers[currentQuestionIndex] == 'غير متأكد')
                              ? 2.0
                              : 1.0,
                        ),
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          if (answers[currentQuestionIndex] == 'غير متأكد')
                            BoxShadow(
                              color: Colors.amber.withAlpha(45),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (answers[currentQuestionIndex] ==
                                'غير متأكد') ...[
                              Icon(
                                Icons.help_outline,
                                color: Colors.white,
                                size: 22,
                              ),
                              const SizedBox(width: 8),
                            ],
                            Flexible(
                              child: AutoSizeText(
                                'غير متأكد',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      (answers[currentQuestionIndex] ==
                                          'غير متأكد')
                                      ? Colors.white
                                      : Colors.amber.shade800,
                                ),
                                maxLines: 1,
                                minFontSize: 10,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        answers[currentQuestionIndex] = 'لا';
                      });
                    },
                    child: Container(
                      height: 48,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: (answers[currentQuestionIndex] == 'لا')
                            ? Colors.red.shade600
                            : (isDark ? Colors.white12 : Colors.grey.shade100),
                        border: Border.all(
                          color: (answers[currentQuestionIndex] == 'لا')
                              ? Colors.red.shade700
                              : (isDark
                                    ? Colors.white24
                                    : Colors.grey.shade300),
                          width: (answers[currentQuestionIndex] == 'لا')
                              ? 2.0
                              : 1.0,
                        ),
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          if (answers[currentQuestionIndex] == 'لا')
                            BoxShadow(
                              color: Colors.red.withAlpha(45),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (answers[currentQuestionIndex] == 'لا') ...[
                              Icon(Icons.cancel, color: Colors.white, size: 22),
                              const SizedBox(width: 8),
                            ],
                            Flexible(
                              child: AutoSizeText(
                                'لا',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: (answers[currentQuestionIndex] == 'لا')
                                      ? Colors.white
                                      : Colors.red.shade700,
                                ),
                                maxLines: 1,
                                minFontSize: 10,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Navigation buttons
              Row(
                children: [
                  if (currentQuestionIndex > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // Save current answer before going back
                          // answers[currentQuestionIndex] = answerController.text
                          //     .trim(); // Removed answerController
                          setState(() {
                            currentQuestionIndex--;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: isDark
                                ? Colors.white38
                                : Colors.grey.shade400,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back, size: 20),
                            const SizedBox(width: 8),
                            Text('السابق'),
                          ],
                        ),
                      ),
                    ),
                  if (currentQuestionIndex > 0) const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (answers[currentQuestionIndex] ?? '').isEmpty
                          ? () {
                              setState(() {
                                // showAnswerHint = true; // Removed unused variable
                              });
                            }
                          : () {
                              setState(() {
                                // showAnswerHint = false; // Removed unused variable
                              });
                              if (currentQuestionIndex < questions.length - 1) {
                                setState(() {
                                  currentQuestionIndex++;
                                });
                              } else {
                                // Submit all answers
                                submitAnswers();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            currentQuestionIndex < questions.length - 1
                            ? Theme.of(context).colorScheme.primary
                            : Colors.green,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            currentQuestionIndex < questions.length - 1
                                ? Icons.arrow_forward
                                : Icons.check_circle,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            currentQuestionIndex < questions.length - 1
                                ? 'التالي'
                                : 'إرسال',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Start over button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('تأكيد البدء من جديد'),
                        content: Text('هل أنت متأكد من إعادة البدء؟'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text('إلغاء'),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text('تأكيد'),
                          ),
                        ],
                      ),
                    );
                    if (confirmed == true) {
                      startOver();
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: isDark ? Colors.white38 : Colors.grey.shade400,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.refresh, size: 20),
                      const SizedBox(width: 8),
                      Text('إعادة البدء'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionsPage(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.lightbulb,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'الاقتراحات',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white10 : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isDark ? Colors.white24 : Colors.grey.shade300,
                  ),
                ),
                child: suggestionsText.trim().isEmpty
                    ? Column(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Theme.of(context).colorScheme.primary,
                            size: 32,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'لا توجد اقتراحات خاصة مطابقة للإجابات الحالية',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'الرجاء المحاولة مرة أخرى',
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    : Text(
                        suggestionsText.replaceAll(RegExp(r' {2,3}'), ' '),
                        style: TextStyle(
                          fontSize: 15,
                          color: isDark ? Colors.white : Colors.black87,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.justify,
                      ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: startOver,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.refresh, size: 20),
                      const SizedBox(width: 8),
                      Flexible(
                        child: AutoSizeText(
                          'إعادة البدء',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          minFontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
