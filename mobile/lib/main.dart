import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const DZApp());

const Color forest = Color(0xFF0B6B50);
const Color gold = Color(0xFFE9B96E);

class ServiceItem {
  final String name, description, category, url, tag;
  final IconData icon;
  const ServiceItem(this.name, this.description, this.category, this.url, this.icon,
      {this.tag = 'الموقع الرسمي'});
}

const services = <ServiceItem>[
  ServiceItem('تعبئة موبيليس', 'الدفع الإلكتروني وإعادة شحن الرصيد', 'فليكسي', 'https://e-paiement.mobilis.dz/', Icons.sim_card, tag: 'Mobilis'),
  ServiceItem('فضاء جازي E-Flexy', 'التعبئة وخدمات المشتركين', 'فليكسي', 'https://moncompte.djezzy.dz/', Icons.bolt, tag: 'Djezzy'),
  ServiceItem('تعبئة أوريدو', 'التعبئة والاشتراكات', 'فليكسي', 'https://estorm.ooredoo.dz/', Icons.wifi, tag: 'Ooredoo'),
  ServiceItem('دفع وتعبئة Idoom', 'تسديد الفواتير وتعبئة الإنترنت', 'إنترنت', 'https://paiement.algerietelecom.dz/', Icons.router, tag: 'Algérie Télécom'),
  ServiceItem('اتصالات الجزائر', 'العروض والاشتراكات وفضاء الزبون', 'إنترنت', 'https://www.algerietelecom.dz/', Icons.language),
  ServiceItem('بريد الجزائر', 'الخدمات البريدية والبطاقة الذهبية', 'مالية', 'https://www.poste.dz/', Icons.account_balance),
  ServiceItem('DZDS — البوابة الوطنية', 'الدخول المباشر إلى البوابة الوطنية للخدمات الرقمية', 'إداري', 'https://dzds.dz/', Icons.hub, tag: 'DZDS'),
  ServiceItem('وزارة الداخلية', 'الخدمات الإدارية والوثائق البيومترية', 'إداري', 'https://services.interieur.gov.dz/ar/', Icons.badge),
  ServiceItem('الحالة المدنية', 'بوابة الخدمات الرقمية للحالة المدنية', 'إداري', 'https://services.interieur.gov.dz/ar/', Icons.description),
  ServiceItem('جواز السفر البيومتري', 'بوابة خدمات جواز السفر', 'إداري', 'https://passeport.interieur.gov.dz/', Icons.travel_explore),
  ServiceItem('وزارة الشؤون الخارجية', 'الخدمات القنصلية والشؤون الخارجية', 'إداري', 'https://www.mfa.gov.dz/', Icons.public),
  ServiceItem('وزارة العدل', 'الخدمات القضائية والمعلومات', 'عدالة', 'https://www.mjustice.dz/', Icons.gavel),
  ServiceItem('الجريدة الرسمية', 'القوانين والمراسيم والنصوص التنظيمية', 'عدالة', 'https://www.joradp.dz/', Icons.menu_book),
  ServiceItem('ANEM', 'عروض العمل وخدمات طالبي العمل', 'عمل', 'https://www.anem.dz/', Icons.work),
  ServiceItem('وسيط ANEM', 'فضاء طالبي العمل', 'عمل', 'https://wassitonline.anem.dz/', Icons.person_search),
  ServiceItem('CNAS الهناء', 'خدمات المؤمن لهم اجتماعياً', 'ضمان', 'https://elhanaa.cnas.dz/', Icons.health_and_safety),
  ServiceItem('CASNOS', 'الضمان الاجتماعي لغير الأجراء', 'ضمان', 'https://www.casnos.dz/', Icons.medical_services),
  ServiceItem('الصندوق الوطني للتقاعد', 'خدمات المتقاعدين', 'ضمان', 'https://www.cnr.dz/', Icons.people_alt),
  ServiceItem('فضاء أولياء التلاميذ', 'متابعة النتائج والحياة المدرسية', 'تعليم', 'https://awlyaa.education.dz/', Icons.school),
  ServiceItem('وزارة التربية', 'الامتحانات والأخبار والخدمات', 'تعليم', 'https://www.education.gov.dz/', Icons.cast_for_education),
  ServiceItem('التعليم العالي', 'الوزارة والخدمات الجامعية', 'تعليم', 'https://www.mesrs.dz/', Icons.account_balance),
  ServiceItem('AADL', 'السكن والبرامج والخدمات', 'سكن', 'https://www.aadl.com.dz/', Icons.home_work),
  ServiceItem('وزارة السكن', 'برامج السكن والتعمير', 'سكن', 'https://www.mhuv.gov.dz/', Icons.apartment),
  ServiceItem('الضرائب', 'التصريحات والخدمات الجبائية', 'مالية', 'https://www.mfdgi.gov.dz/', Icons.receipt_long),
  ServiceItem('جبايتك Jibayatic', 'الخدمات والتصريح الجبائي عن بعد', 'مالية', 'https://jibayatic.mf.gov.dz/', Icons.receipt),
  ServiceItem('الرقم التعريفي الجبائي', 'خدمات التعريف الجبائي', 'مالية', 'https://nifenligne.mf.gov.dz/', Icons.numbers),
  ServiceItem('السجل التجاري Sidjilcom', 'خدمات المركز الوطني للسجل التجاري', 'تجارة', 'https://sidjilcom.cnrc.dz/', Icons.store),
  ServiceItem('وزارة التجارة', 'حماية المستهلك والخدمات التجارية', 'تجارة', 'https://www.commerce.gov.dz/', Icons.shopping_bag),
  ServiceItem('الجمارك الجزائرية', 'الخدمات والمعلومات الجمركية', 'تجارة', 'https://www.douane.gov.dz/', Icons.local_shipping),
  ServiceItem('وزارة الصحة', 'الأخبار والمعلومات الصحية الرسمية', 'صحة', 'https://www.sante.gov.dz/', Icons.local_hospital),
  ServiceItem('وزارة التكوين المهني', 'التكوين والتسجيلات المهنية', 'تعليم', 'https://www.mfep.gov.dz/', Icons.school),
  ServiceItem('سونلغاز', 'الكهرباء والغاز وخدمات الزبائن', 'فواتير', 'https://www.sonelgaz.dz/', Icons.bolt),
  ServiceItem('الجزائرية للمياه', 'المياه والخدمات والفواتير', 'فواتير', 'https://www.ade.dz/', Icons.water_drop),
  ServiceItem('SNTF', 'القطارات والتنقل', 'نقل', 'https://www.sntf.dz/', Icons.train),
  ServiceItem('الخطوط الجوية الجزائرية', 'الرحلات والحجز', 'نقل', 'https://airalgerie.dz/', Icons.flight),
  ServiceItem('وكالة الأنباء الجزائرية APS', 'الأخبار الوطنية', 'مواقع عامة', 'https://www.aps.dz/', Icons.newspaper),
];

class DZApp extends StatefulWidget {
  const DZApp({super.key});
  @override
  State<DZApp> createState() => _DZAppState();
}

class _DZAppState extends State<DZApp> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() => _themeMode = prefs.getBool('dark_mode') == true ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> _toggleTheme() async {
    final next = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    setState(() => _themeMode = next);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', next == ThemeMode.dark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DZ Smart Services',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: forest, brightness: Brightness.light),
        scaffoldBackgroundColor: const Color(0xFFF4F7F5),
        appBarTheme: const AppBarTheme(centerTitle: false, elevation: 0, backgroundColor: Color(0xFFF4F7F5)),
        cardTheme: CardThemeData(elevation: 0, color: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(seedColor: forest, brightness: Brightness.dark),
        cardTheme: CardThemeData(elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      ),
      home: Hub(dark: _themeMode == ThemeMode.dark, onToggleTheme: _toggleTheme),
    );
  }
}

class Hub extends StatefulWidget {
  final bool dark;
  final VoidCallback onToggleTheme;
  const Hub({super.key, required this.dark, required this.onToggleTheme});
  @override
  State<Hub> createState() => _HubState();
}

class _HubState extends State<Hub> {
  int _tab = 0;
  String _query = '';
  String _category = 'الكل';
  final Set<String> _favorites = {};

  static const _categories = ['الكل', 'فليكسي', 'إنترنت', 'إداري', 'عدالة', 'عمل', 'ضمان', 'تعليم', 'سكن', 'مالية', 'تجارة', 'صحة', 'فواتير', 'نقل', 'مواقع عامة'];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() => _favorites.addAll(prefs.getStringList('favorites') ?? []));
  }

  Future<void> _toggleFavorite(ServiceItem item) async {
    setState(() {
      if (!_favorites.add(item.name)) _favorites.remove(item.name);
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _favorites.toList());
  }

  Future<void> _openService(ServiceItem item) async {
    try {
      final launched = await launchUrl(Uri.parse(item.url), mode: LaunchMode.externalApplication);
      if (!launched && mounted) _showMessage('تعذر فتح الرابط. تحقق من اتصال الإنترنت.');
    } catch (_) {
      if (mounted) _showMessage('حدث خطأ أثناء فتح الموقع.');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), behavior: SnackBarBehavior.floating));
  }

  @override
  Widget build(BuildContext context) {
    final filtered = services.where((s) {
      final matchesCategory = _category == 'الكل' || s.category == _category;
      final matchesQuery = ('${s.name} ${s.description} ${s.category} ${s.tag}').toLowerCase().contains(_query.trim().toLowerCase());
      final matchesTab = _tab != 2 || _favorites.contains(s.name);
      return matchesCategory && matchesQuery && matchesTab;
    }).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Row(children: [
            Container(width: 34, height: 34, decoration: BoxDecoration(color: forest, borderRadius: BorderRadius.circular(11)), child: const Icon(Icons.grid_view_rounded, color: Colors.white, size: 20)),
            const SizedBox(width: 10),
            const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('DZ SMART', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.1, fontSize: 17)),
              Text('SERVICES • ALGERIA', style: TextStyle(fontSize: 9, letterSpacing: 1.5, color: Colors.grey)),
            ]),
          ]),
          actions: [
            IconButton(tooltip: 'تغيير المظهر', onPressed: widget.onToggleTheme, icon: Icon(widget.dark ? Icons.light_mode : Icons.dark_mode)),
            IconButton(tooltip: 'حول التطبيق', onPressed: () => showAboutDialog(context: context, applicationName: 'DZ Smart Services', applicationVersion: '2.1.0', children: const [Text('دليل مستقل للوصول إلى الخدمات والمواقع الجزائرية. تُستكمل المعاملات والدفع لدى الجهات الرسمية نفسها.')]), icon: const Icon(Icons.info_outline)),
          ],
        ),
        body: SafeArea(
          child: Column(children: [
            if (_tab == 0) _hero(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TextField(
                onChanged: (value) => setState(() => _query = value),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'ابحث عن خدمة، مؤسسة أو موقع...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                ),
              ),
            ),
            if (_tab != 2)
              SizedBox(
                height: 46,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: _categories.map((category) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: ChoiceChip(label: Text(category), selected: _category == category, onSelected: (_) => setState(() => _category = category)),
                  )).toList(),
                ),
              ),
            Expanded(
              child: filtered.isEmpty
                  ? _emptyState()
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(14, 10, 14, 18),
                      children: [
                        if (_tab == 0 && _query.isEmpty && _category == 'الكل') ...[
                          _sectionHeading('الخدمات الأكثر استخداماً', 'وصول سريع إلى الخدمات اليومية'),
                          _featuredGrid(),
                          const SizedBox(height: 12),
                          _sectionHeading('جميع الخدمات', '${services.length} خدمة وموقع'),
                        ] else
                          _sectionHeading(_tab == 2 ? 'خدماتك المحفوظة' : 'نتائج الخدمات', '${filtered.length} نتيجة'),
                        ...filtered.map(_serviceCard),
                      ],
                    ),
            ),
          ]),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _tab,
          onDestinationSelected: (value) => setState(() {
            _tab = value;
            if (value == 0) { _query = ''; _category = 'الكل'; }
          }),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
            NavigationDestination(icon: Icon(Icons.grid_view_rounded), label: 'كل الخدمات'),
            NavigationDestination(icon: Icon(Icons.bookmark_border), selectedIcon: Icon(Icons.bookmark), label: 'المفضلة'),
          ],
        ),
      ),
    );
  }

  Widget _hero() => Container(
    margin: const EdgeInsets.fromLTRB(14, 5, 14, 2),
    padding: const EdgeInsets.all(21),
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [Color(0xFF082F27), Color(0xFF0B7657), Color(0xFF15966C)], begin: Alignment.topRight, end: Alignment.bottomLeft),
      borderRadius: BorderRadius.circular(27),
      boxShadow: [BoxShadow(color: forest.withValues(alpha: .18), blurRadius: 20, offset: const Offset(0, 8))],
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Row(children: [Icon(Icons.public, color: gold, size: 19), SizedBox(width: 7), Text('منصتك الرقمية الجزائرية', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600))]),
      const SizedBox(height: 13),
      const Text('خدماتك اليومية،\nأقرب وأسهل.', style: TextStyle(color: Colors.white, fontSize: 28, height: 1.2, fontWeight: FontWeight.w900)),
      const SizedBox(height: 8),
      const Text('بوابات إدارية، تعبئة الرصيد، فواتير، تعليم، نقل وأكثر في مكان واحد.', style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5)),
      const SizedBox(height: 18),
      Wrap(spacing: 7, runSpacing: 8, children: [
        _quickAction('فليكسي', Icons.flash_on, () => setState(() => _category = 'فليكسي')),
        _quickAction('الإدارات', Icons.account_balance, () => setState(() => _category = 'إداري')),
        _quickAction('Idoom', Icons.router, () => _openService(services[3])),
        _quickAction('DZDS', Icons.hub, () => _openService(services[6])),
      ]),
    ]),
  );

  Widget _quickAction(String label, IconData icon, VoidCallback action) => ActionChip(
    avatar: Icon(icon, size: 16, color: Colors.white),
    label: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
    backgroundColor: Colors.white.withValues(alpha: .14),
    side: const BorderSide(color: Colors.white24),
    onPressed: action,
  );

  Widget _sectionHeading(String title, String subtitle) => Padding(
    padding: const EdgeInsets.fromLTRB(3, 12, 3, 12),
    child: Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
        const SizedBox(height: 3),
        Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 11)),
      ])),
      const Icon(Icons.arrow_back_ios_new, size: 14, color: Colors.grey),
    ]),
  );

  Widget _featuredGrid() => GridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    childAspectRatio: 1.7,
    children: [
      _featured('فليكسي الشبكات', 'موبيليس • جازي • أوريدو', Icons.sim_card, () => setState(() => _category = 'فليكسي')),
      _featured('البوابة DZDS', 'الخدمات الرقمية الوطنية', Icons.hub, () => _openService(services[6])),
      _featured('دفع الفواتير', 'Idoom • كهرباء • ماء', Icons.receipt_long, () => setState(() => _category = 'فواتير')),
      _featured('الخدمات الإدارية', 'وثائق وبوابات حكومية', Icons.account_balance, () => setState(() => _category = 'إداري')),
    ],
  );

  Widget _featured(String title, String subtitle, IconData icon, VoidCallback onTap) => Material(
    color: Theme.of(context).colorScheme.surface,
    borderRadius: BorderRadius.circular(18),
    child: InkWell(borderRadius: BorderRadius.circular(18), onTap: onTap, child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon, color: forest, size: 23),
        const SizedBox(height: 7),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
        const SizedBox(height: 3),
        Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.grey, fontSize: 10)),
      ]),
    )),
  );

  Widget _serviceCard(ServiceItem item) {
    final favorite = _favorites.contains(item.name);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _openService(item),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Row(children: [
            Container(width: 48, height: 48, decoration: BoxDecoration(color: isDark ? forest.withValues(alpha: .22) : const Color(0xFFE2F2EA), borderRadius: BorderRadius.circular(15)), child: Icon(item.icon, color: isDark ? const Color(0xFF8ED7B5) : forest)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(item.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
              const SizedBox(height: 4),
              Text(item.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurfaceVariant)),
              const SizedBox(height: 7),
              Text('${item.category}  •  ${item.tag}', style: const TextStyle(fontSize: 10, color: forest, fontWeight: FontWeight.bold)),
            ])),
            IconButton(tooltip: favorite ? 'إزالة من المفضلة' : 'إضافة إلى المفضلة', onPressed: () => _toggleFavorite(item), icon: Icon(favorite ? Icons.bookmark : Icons.bookmark_border, color: favorite ? forest : null)),
            Icon(Icons.open_in_new, size: 15, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ]),
        ),
      ),
    );
  }

  Widget _emptyState() => Center(child: Padding(
    padding: const EdgeInsets.all(28),
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(_tab == 2 ? Icons.bookmark_border : Icons.search_off, size: 45, color: Colors.grey),
      const SizedBox(height: 12),
      Text(_tab == 2 ? 'لا توجد خدمات محفوظة بعد' : 'لم نعثر على نتائج', style: const TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 5),
      const Text('جرّب تغيير كلمة البحث أو التصنيف.', style: TextStyle(color: Colors.grey, fontSize: 12)),
    ]),
  ));
}
