import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const DzServiceApp());

const navy = Color(0xFF101827);
const panel = Color(0xFF202B3D);
const teal = Color(0xFF00A88A);
const amber = Color(0xFFFFB21A);

class DzServiceApp extends StatefulWidget {
  const DzServiceApp({super.key});
  @override
  State<DzServiceApp> createState() => _DzServiceAppState();
}

class _DzServiceAppState extends State<DzServiceApp> {
  bool dark = true;
  @override
  void initState() { super.initState(); _load(); }
  Future<void> _load() async {
    final p = await SharedPreferences.getInstance();
    if (mounted) setState(() => dark = p.getBool('dz_dark') ?? true);
  }
  Future<void> toggle() async {
    setState(() => dark = !dark);
    final p = await SharedPreferences.getInstance();
    await p.setBool('dz_dark', dark);
  }
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Dz Service',
    debugShowCheckedModeBanner: false,
    themeMode: dark ? ThemeMode.dark : ThemeMode.light,
    theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: teal), scaffoldBackgroundColor: const Color(0xFFF3F6FA)),
    darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark, colorScheme: ColorScheme.fromSeed(seedColor: teal, brightness: Brightness.dark), scaffoldBackgroundColor: navy),
    home: HomePage(dark: dark, onTheme: toggle),
  );
}

class Service {
  final String title, subtitle, category, url;
  final IconData icon;
  const Service(this.title, this.subtitle, this.category, this.url, this.icon);
}

const serviceItems = <Service>[
  Service('موبيليس Flexy','التعبئة وخدمات المشتركين','الاتصالات','https://e-paiement.mobilis.dz/',Icons.sim_card),
  Service('جازي E-Flexy','التعبئة وإدارة الخط','الاتصالات','https://moncompte.djezzy.dz/',Icons.bolt),
  Service('أوريدو eStorm','التعبئة والعروض','الاتصالات','https://estorm.ooredoo.dz/',Icons.wifi),
  Service('دفع Idoom','تسديد فاتورة الهاتف والإنترنت','الفواتير','https://paiement.algerietelecom.dz/',Icons.router),
  Service('اتصالات الجزائر','العروض وفضاء الزبون','الاتصالات','https://www.algerietelecom.dz/',Icons.language),
  Service('بريد الجزائر','الخدمات البريدية والبطاقة الذهبية','البريد وCCP','https://www.poste.dz/',Icons.account_balance),
  Service('BaridiMob','الخدمات الرقمية لبريد الجزائر','البريد وCCP','https://www.poste.dz/',Icons.phone_android),
  Service('ECCP','فضاء الحساب البريدي','البريد وCCP','https://eccp.poste.dz/',Icons.account_balance_wallet),
  Service('DZDS — Dzair Digital Services','البوابة الوطنية للخدمات الرقمية','بوابات رقمية','https://dzds.dz/',Icons.hub),
  Service('وزارة الداخلية','الخدمات الإدارية والوثائق','الإدارة والوثائق','https://services.interieur.gov.dz/ar/',Icons.badge),
  Service('جواز السفر','بوابة جواز السفر البيومتري','الإدارة والوثائق','https://passeport.interieur.gov.dz/',Icons.travel_explore),
  Service('وزارة العدل','الخدمات القضائية','الإدارة والوثائق','https://www.mjustice.dz/',Icons.gavel),
  Service('الجريدة الرسمية','القوانين والمراسيم','الإدارة والوثائق','https://www.joradp.dz/',Icons.menu_book),
  Service('ANEM','التشغيل وعروض العمل','العمل والضمان','https://www.anem.dz/',Icons.work),
  Service('وسيط ANEM','فضاء طالبي العمل','العمل والضمان','https://wassitonline.anem.dz/',Icons.person_search),
  Service('CNAS الهناء','خدمات المؤمن لهم','العمل والضمان','https://elhanaa.cnas.dz/',Icons.health_and_safety),
  Service('CASNOS','الضمان لغير الأجراء','العمل والضمان','https://www.casnos.dz/',Icons.medical_services),
  Service('CNR','الصندوق الوطني للتقاعد','العمل والضمان','https://www.cnr.dz/',Icons.elderly),
  Service('فضاء أولياء التلاميذ','متابعة النتائج والحياة المدرسية','التعليم','https://awlyaa.education.dz/',Icons.school),
  Service('وزارة التربية','الأخبار والخدمات التعليمية','التعليم','https://www.education.gov.dz/',Icons.cast_for_education),
  Service('التعليم العالي','الجامعات والخدمات','التعليم','https://www.mesrs.dz/',Icons.account_balance),
  Service('AADL','السكن والبرامج','السكن','https://www.aadl.com.dz/',Icons.home_work),
  Service('وزارة السكن','السكن والتعمير','السكن','https://www.mhuv.gov.dz/',Icons.apartment),
  Service('الضرائب','الخدمات والتصريحات الجبائية','المالية','https://www.mfdgi.gov.dz/',Icons.receipt_long),
  Service('جبايتك','الخدمات الجبائية عن بعد','المالية','https://jibayatic.mf.gov.dz/',Icons.receipt),
  Service('السجل التجاري','Sidjilcom','الأعمال والتجارة','https://sidjilcom.cnrc.dz/',Icons.store),
  Service('وزارة التجارة','التجارة وحماية المستهلك','الأعمال والتجارة','https://www.commerce.gov.dz/',Icons.shopping_bag),
  Service('الجمارك','الجمارك الجزائرية','الأعمال والتجارة','https://www.douane.gov.dz/',Icons.local_shipping),
  Service('وزارة الصحة','المعلومات والخدمات الصحية','الصحة','https://www.sante.gov.dz/',Icons.local_hospital),
  Service('التكوين المهني','التسجيلات والتكوين','التعليم','https://www.mfep.gov.dz/',Icons.school),
  Service('سونلغاز','الكهرباء والغاز','الفواتير','https://www.sonelgaz.dz/',Icons.bolt),
  Service('الجزائرية للمياه','المياه والفواتير','الفواتير','https://www.ade.dz/',Icons.water_drop),
  Service('SNTF','القطارات','النقل','https://www.sntf.dz/',Icons.train),
  Service('الخطوط الجوية الجزائرية','الرحلات والحجز','النقل','https://airalgerie.dz/',Icons.flight),
  Service('وكالة الأنباء الجزائرية','الأخبار الوطنية APS','مواقع عامة','https://www.aps.dz/',Icons.newspaper),
];

class HomePage extends StatefulWidget {
  final bool dark;
  final VoidCallback onTheme;
  const HomePage({super.key, required this.dark, required this.onTheme});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tab = 0;
  String search = '';
  String category = 'الكل';
  final Set<String> favorites = {};
  final TextEditingController amountController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  final TextEditingController keyController = TextEditingController();
  final TextEditingController transferController = TextEditingController();
  static const categories = ['الكل','البريد وCCP','الاتصالات','الفواتير','بوابات رقمية','الإدارة والوثائق','العمل والضمان','التعليم','السكن','المالية','الأعمال والتجارة','الصحة','النقل','مواقع عامة'];

  @override
  void initState() { super.initState(); _loadFavorites(); }
  @override
  void dispose() { amountController.dispose(); accountController.dispose(); keyController.dispose(); transferController.dispose(); super.dispose(); }
  Future<void> _loadFavorites() async {
    final p = await SharedPreferences.getInstance();
    if (mounted) setState(() => favorites.addAll(p.getStringList('dz_favs') ?? []));
  }
  Future<void> _favorite(Service s) async {
    setState(() { if (!favorites.add(s.title)) favorites.remove(s.title); });
    final p = await SharedPreferences.getInstance();
    await p.setStringList('dz_favs', favorites.toList());
  }
  Future<void> _open(String url) async {
    try {
      final ok = await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      if (!ok && mounted) _message('تعذر فتح الرابط، تحقق من اتصال الإنترنت.');
    } catch (_) { if (mounted) _message('تعذر فتح الموقع حالياً.'); }
  }
  void _message(String s) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s), behavior: SnackBarBehavior.floating));
  Color get ink => Theme.of(context).colorScheme.onSurface;
  Color get tile => widget.dark ? const Color(0xFF20232A) : Colors.white;

  @override
  Widget build(BuildContext context) {
    final list = serviceItems.where((s) {
      final q = search.trim().toLowerCase();
      return (category == 'الكل' || s.category == category) &&
        (tab != 3 || favorites.contains(s.title)) &&
        ('${s.title} ${s.subtitle} ${s.category}'.toLowerCase().contains(q));
    }).toList();
    return Directionality(textDirection: TextDirection.rtl, child: Scaffold(
      appBar: AppBar(
        backgroundColor: widget.dark ? const Color(0xFF17191F) : Colors.white,
        title: const Text('Dz Service', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: .3)),
        centerTitle: true,
        leading: Builder(builder: (ctx) => IconButton(onPressed: () => Scaffold.of(ctx).openDrawer(), icon: const Icon(Icons.menu_rounded))),
        actions: [
          IconButton(onPressed: () => showSearch(context: context, delegate: _ServiceSearchDelegate((s) => _open(s.url))), icon: const Icon(Icons.search_rounded)),
          IconButton(onPressed: widget.onTheme, icon: Icon(widget.dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined)),
        ],
      ),
      drawer: _appDrawer(),
      body: SafeArea(child: Column(children: [
        if (tab == 0) _brandBanner(),
        Padding(padding: const EdgeInsets.fromLTRB(16, 12, 16, 8), child: TextField(
          onChanged: (v) => setState(() => search = v),
          decoration: InputDecoration(hintText: 'ابحث عن خدمة أو عملية...', prefixIcon: const Icon(Icons.search), filled: true, fillColor: tile, border: OutlineInputBorder(borderRadius: BorderRadius.circular(17), borderSide: BorderSide.none)),
        )),
        if (tab != 3)
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                for (final c in categories)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: ChoiceChip(
                      label: Text(c),
                      selected: category == c,
                      onSelected: (_) => setState(() => category = c),
                    ),
                  ),
              ],
            ),
          ),
        Expanded(child: tab == 2 && search.isEmpty && category == 'الكل' ? _toolsAndServices() : list.isEmpty ? _empty() : ListView(padding: const EdgeInsets.fromLTRB(14, 8, 14, 18), children: [
          _heading(tab == 3 ? 'المفضلة' : tab == 1 ? 'الأقسام والخدمات' : 'الخدمات المتاحة', '${list.length} خدمة'),
          ...list.map(_serviceTile),
        ])),
      ])),
      bottomNavigationBar: NavigationBar(selectedIndex: tab, onDestinationSelected: (v) => setState(() { tab = v; search = ''; category = 'الكل'; }), destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
        NavigationDestination(icon: Icon(Icons.apps), label: 'الأقسام'),
        NavigationDestination(icon: Icon(Icons.calculate_outlined), label: 'الأدوات'),
        NavigationDestination(icon: Icon(Icons.bookmark_border), selectedIcon: Icon(Icons.bookmark), label: 'المفضلة'),
      ]),
    ));
  }

  Widget _appDrawer() => Drawer(child: SafeArea(child: Column(children: [
    Container(width: double.infinity, padding: const EdgeInsets.fromLTRB(20, 28, 20, 22), decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF075E61), Color(0xFF10233B)])), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      DzServiceLogo(size: 66),
      SizedBox(height: 12), Text('Dz Service', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
      Text('تطوير سامر عبد النور', style: TextStyle(color: Colors.white70)),
      Text('خدمات الجزائر في مكان واحد', style: TextStyle(color: Colors.white70, fontSize: 12)),
    ])),
    Expanded(child: ListView(children: [
      _drawerItem(Icons.person_outline, 'رقم حسابي الشخصي', () { Navigator.pop(context); _ripDialog(); }),
      _drawerItem(Icons.bookmark_outline, 'حسابات CCP المحفوظة', () { Navigator.pop(context); _message('لا تحفظ كلمات المرور أو مفاتيح CCP داخل التطبيق حفاظاً على أمانك.'); }),
      _drawerItem(Icons.forum_outlined, 'منتدى الأسئلة', () { Navigator.pop(context); _message('سيتم إضافة قسم الأسئلة الشائعة في تحديث قادم.'); }),
      _drawerItem(Icons.notifications_none, 'التذكيرات والإشعارات', () { Navigator.pop(context); _message('التنبيهات المحلية قيد التطوير.'); }),
      _drawerItem(Icons.info_outline, 'حول التطبيق', () { Navigator.pop(context); _showAbout(); }),
      _drawerItem(Icons.shield_outlined, 'استشارة خاصة', () { Navigator.pop(context); _message('لا ترسل بياناتك البنكية أو رموز التحقق لأي شخص.'); }),
      _drawerItem(Icons.settings_outlined, 'الإعدادات والمظهر', () { Navigator.pop(context); widget.onTheme(); }),
      const Divider(height: 28),
      Padding(padding: const EdgeInsets.all(16), child: Text('أدوات وخدمات Dz Service', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))),
    ])),
    const Padding(padding: EdgeInsets.all(14), child: Text('Dz Service • سامر عبد النور', style: TextStyle(color: Colors.grey, fontSize: 11))),
  ])));
  Widget _drawerItem(IconData icon, String title, VoidCallback action) => ListTile(leading: Icon(icon, color: teal), title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)), trailing: const Icon(Icons.chevron_left), onTap: action);

  Widget _brandBanner() => Container(
    margin: const EdgeInsets.fromLTRB(14, 12, 14, 5), padding: const EdgeInsets.all(19),
    decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF006C70), Color(0xFF008E83), Color(0xFF064E63)], begin: Alignment.topRight, end: Alignment.bottomLeft), borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: teal.withValues(alpha: .2), blurRadius: 18, offset: const Offset(0, 7))]),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [const DzServiceLogo(size: 62), const SizedBox(width: 12), const Expanded(child: Text('DZ • ALGERIA', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, letterSpacing: 1.4)),), const Spacer(), Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: amber, borderRadius: BorderRadius.circular(20)), child: const Text('خدماتك في مكان واحد', style: TextStyle(color: navy, fontSize: 10, fontWeight: FontWeight.w900)))]),
      const SizedBox(height: 15),
      const Text('كل خدمات الجزائر،\nبسهولة وفي مكان واحد', style: TextStyle(color: Colors.white, fontSize: 25, height: 1.25, fontWeight: FontWeight.w900)),
      const SizedBox(height: 7),
      const Text('Dz Service  •  تطوير سامر عبد النور', style: TextStyle(color: Colors.white70, fontSize: 12)),
      const SizedBox(height: 15),
      Wrap(spacing: 8, runSpacing: 8, children: [
        _bannerAction('البريد و CCP', Icons.account_balance, () => setState(() { category = 'البريد وCCP'; tab = 0; })),
        _bannerAction('فليكسي', Icons.sim_card, () => setState(() { category = 'الاتصالات'; tab = 0; })),
        _bannerAction('DZDS', Icons.hub, () => _open('https://dzds.dz/')),
      ]),
    ]),
  );
  Widget _bannerAction(String s, IconData i, VoidCallback fn) => ActionChip(avatar: Icon(i, color: Colors.white, size: 16), label: Text(s, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), backgroundColor: Colors.white.withValues(alpha: .13), side: const BorderSide(color: Colors.white24), onPressed: fn);

  Widget _toolsAndServices() => ListView(padding: const EdgeInsets.fromLTRB(14, 8, 14, 18), children: [
    _heading('أدوات البريد والحسابات', 'أدوات عملية تعمل على هاتفك'),
    _toolTile('حساب مفتاح CCP و RIP', 'أداة مساعدة لإدخال بيانات الحساب وعرضها', Icons.tag, () => _ripDialog()),
    _toolTile('تحويل المبلغ إلى الحروف', 'كتابة المبلغ بالدينار الجزائري', Icons.translate, () => _amountDialog()),
    _toolTile('محاكاة ملء الشيك', 'معاينة تعليمية لبيانات الشيك دون إنشاء وثيقة رسمية', Icons.receipt_long, () => _chequeDialog()),
    _toolTile('حاسبة رسوم التحويل والسحب', 'أدخل المبلغ لعرض الحاسبة التوضيحية', Icons.calculate, () => _feesDialog()),
    _toolTile('مكاتب البريد والصرافات', 'البحث عن أقرب مكتب أو موزع عبر الخرائط', Icons.location_on, () => _open('https://www.google.com/maps/search/?api=1&query=Algerie+Poste+bureau+poste')),
    _heading('البوابات والخدمات الرقمية', 'روابط للوصول المباشر إلى الجهات'),
    ...serviceItems.map(_serviceTile),
    const SizedBox(height: 15),
    Center(child: Text('Dz Service • المطور سامر عبد النور', style: TextStyle(color: Colors.grey, fontSize: 11))),
  ]);

  Widget _heading(String title, String sub) => Padding(padding: const EdgeInsets.fromLTRB(4, 14, 4, 11), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: ink)),
    const SizedBox(height: 3), Text(sub, style: const TextStyle(fontSize: 11, color: Colors.grey)),
  ]));
  Widget _toolTile(String title, String sub, IconData icon, VoidCallback onTap) => Container(
    margin: const EdgeInsets.only(bottom: 10), decoration: BoxDecoration(color: tile, borderRadius: BorderRadius.circular(19), border: Border.all(color: ink.withValues(alpha: .06))),
    child: ListTile(contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7), leading: Container(width: 48, height: 48, decoration: BoxDecoration(color: const Color(0xFF31306B), borderRadius: BorderRadius.circular(15)), child: Icon(icon, color: const Color(0xFF9D8BFF))), title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)), subtitle: Text(sub, style: const TextStyle(fontSize: 11)), trailing: const Icon(Icons.chevron_left), onTap: onTap),
  );
  Widget _serviceTile(Service s) {
    final fav = favorites.contains(s.title);
    return Container(margin: const EdgeInsets.only(bottom: 9), decoration: BoxDecoration(color: tile, borderRadius: BorderRadius.circular(19), border: Border.all(color: ink.withValues(alpha: .06))),
      child: ListTile(contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5), leading: Container(width: 54, height: 54, decoration: BoxDecoration(color: teal.withValues(alpha: .13), borderRadius: BorderRadius.circular(15)), child: Icon(s.icon, color: teal, size: 27)), title: Text(s.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)), subtitle: Text(s.subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11)), trailing: SizedBox(width: 78, child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        IconButton(visualDensity: VisualDensity.compact, onPressed: () => _favorite(s), icon: Icon(fav ? Icons.bookmark : Icons.bookmark_border, color: fav ? amber : Colors.grey)),
        const Icon(Icons.chevron_left, color: Colors.blueGrey),
      ])), onTap: () => _open(s.url)),
    );
  }
  Widget _empty() => Center(child: Column(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.search_off, size: 48, color: Colors.grey), const SizedBox(height: 10), const Text('لا توجد نتائج مطابقة'), TextButton(onPressed: () => setState(() { search = ''; category = 'الكل'; }), child: const Text('إظهار جميع الخدمات'))]));

  void _ripDialog() {
    accountController.clear(); keyController.clear();
    showDialog(context: context, builder: (ctx) => AlertDialog(title: const Text('بيانات CCP / RIP'), content: Column(mainAxisSize: MainAxisSize.min, children: [
      const Text('أدخل البيانات يدوياً للتحقق من تنسيقها. لا تُرسل هذه البيانات إلى أي خادم.', style: TextStyle(fontSize: 12)),
      const SizedBox(height: 10), TextField(controller: accountController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'رقم CCP', border: OutlineInputBorder())),
      const SizedBox(height: 8), TextField(controller: keyController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'المفتاح (إن توفر)', border: OutlineInputBorder())),
    ]), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إغلاق')), FilledButton(onPressed: () { final a = accountController.text.trim(); Clipboard.setData(ClipboardData(text: 'CCP: $a  المفتاح: ${keyController.text.trim()}')); Navigator.pop(ctx); _message('تم نسخ البيانات إلى الحافظة.'); }, child: const Text('نسخ البيانات'))]));
  }
  void _amountDialog() {
    amountController.clear();
    showDialog(context: context, builder: (ctx) => AlertDialog(title: const Text('تحويل المبلغ إلى الحروف'), content: TextField(controller: amountController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'المبلغ بالدينار', border: OutlineInputBorder())), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')), FilledButton(onPressed: () { final n = int.tryParse(amountController.text.trim()); Navigator.pop(ctx); _message(n == null || n < 0 ? 'أدخل مبلغاً صحيحاً.' : '${n.toString()} دينار جزائري'); }, child: const Text('تحويل'))]));
  }
  void _chequeDialog() {
    accountController.clear(); amountController.clear();
    showDialog(context: context, builder: (ctx) => AlertDialog(title: const Text('معاينة تعليمية للشيك'), content: Column(mainAxisSize: MainAxisSize.min, children: [
      const Text('هذه معاينة توضيحية فقط وليست شيكاً بنكياً صالحاً للاستعمال.', style: TextStyle(fontSize: 12, color: Colors.orange)),
      const SizedBox(height: 10), TextField(controller: accountController, decoration: const InputDecoration(labelText: 'اسم المستفيد', border: OutlineInputBorder())),
      const SizedBox(height: 8), TextField(controller: amountController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'المبلغ بالدينار', border: OutlineInputBorder())),
    ]), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إغلاق')), FilledButton(onPressed: () { final text = 'المستفيد: ${accountController.text}\nالمبلغ: ${amountController.text} دج'; Clipboard.setData(ClipboardData(text: text)); Navigator.pop(ctx); _message('تم نسخ بيانات المعاينة.'); }, child: const Text('نسخ المعاينة'))]));
  }
  void _feesDialog() {
    transferController.clear();
    showDialog(context: context, builder: (ctx) => AlertDialog(title: const Text('حاسبة المبلغ'), content: Column(mainAxisSize: MainAxisSize.min, children: [
      const Text('أدخل المبلغ لحساب القيمة الأساسية. الرسوم الرسمية تتغير حسب نوع العملية وتعريفة بريد الجزائر؛ لا نعرض رسوماً غير مؤكدة.', style: TextStyle(fontSize: 12)),
      const SizedBox(height: 10), TextField(controller: transferController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'المبلغ بالدينار', border: OutlineInputBorder())),
    ]), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('إغلاق')), FilledButton(onPressed: () { final v = int.tryParse(transferController.text); Navigator.pop(ctx); _message(v == null ? 'أدخل مبلغاً صحيحاً.' : 'المبلغ المدخل: $v دج'); }, child: const Text('تحقق'))]));
  }
  void _showAbout() => showAboutDialog(context: context, applicationName: 'Dz Service', applicationVersion: '3.0.0', applicationLegalese: 'تطوير سامر عبد النور', children: const [Text('تطبيق مستقل يجمع روابط الخدمات العامة وأدوات مساعدة. ليس تابعاً لبريد الجزائر أو لأي جهة حكومية. لا تدخل كلمات المرور أو رموز OTP أو بيانات البطاقة داخل التطبيق.')]);
}


class _ServiceSearchDelegate extends SearchDelegate<Service?> {
  final ValueChanged<Service> onOpen;
  _ServiceSearchDelegate(this.onOpen);

  @override
  String get searchFieldLabel => 'ابحث عن خدمة...';

  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(icon: const Icon(Icons.close), onPressed: () => query = ''),
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, null),
  );

  @override
  Widget buildResults(BuildContext context) => _results(context);

  @override
  Widget buildSuggestions(BuildContext context) => _results(context);

  Widget _results(BuildContext context) {
    final q = query.trim().toLowerCase();
    final matches = serviceItems.where((s) =>
      q.isEmpty || ('${s.title} ${s.subtitle} ${s.category}'.toLowerCase().contains(q))
    ).toList();
    if (matches.isEmpty) {
      return const Center(child: Text('لا توجد نتائج'));
    }
    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final s = matches[index];
        return ListTile(
          leading: Icon(s.icon, color: teal),
          title: Text(s.title),
          subtitle: Text(s.subtitle),
          trailing: const Icon(Icons.chevron_left),
          onTap: () {
            close(context, s);
            onOpen(s);
          },
        );
      },
    );
  }
}


class DzServiceLogo extends StatelessWidget {
  final double size;
  const DzServiceLogo({super.key, this.size = 64});
  @override
  Widget build(BuildContext context) => SizedBox(width: size, height: size, child: CustomPaint(painter: _DzServiceLogoPainter()));
}
class _DzServiceLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final r = Offset.zero & size;
    final bg = Paint()..shader = const LinearGradient(colors: [Color(0xFF06253B), Color(0xFF087F78), Color(0xFF101827)], begin: Alignment.topLeft, end: Alignment.bottomRight).createShader(r);
    canvas.drawRRect(RRect.fromRectAndRadius(r, Radius.circular(size.width * .24)), bg);
    canvas.drawRRect(RRect.fromRectAndRadius(r.deflate(size.width*.025), Radius.circular(size.width*.22)), Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*.035..color=Color(0xFFFFB21A));
    final d = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*.12..strokeCap=StrokeCap.square..color=Colors.white;
    final p=Path()..moveTo(size.width*.34,size.height*.23)..lineTo(size.width*.34,size.height*.77)..lineTo(size.width*.53,size.height*.77)..cubicTo(size.width*.88,size.height*.77,size.width*.88,size.height*.23,size.width*.53,size.height*.23);
    canvas.drawPath(p,d);
    canvas.drawArc(Rect.fromCenter(center:r.center,width:size.width*.84,height:size.height*.48),.15,2.8,false,Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*.045..color=Color(0xFFFFB21A));
    final circuit=Paint()..color=Color(0xFF00D0B0)..strokeWidth=size.width*.025;
    for(final y in [.40,.55,.70]) {
      canvas.drawCircle(Offset(size.width*.18,size.height*y),size.width*.035,circuit);
      canvas.drawLine(Offset(size.width*.22,size.height*y),Offset(size.width*.36,size.height*y),circuit);
    }
    final star=Path()..moveTo(size.width*.72,size.height*.10)..lineTo(size.width*.75,size.height*.18)..lineTo(size.width*.84,size.height*.19)..lineTo(size.width*.77,size.height*.25)..lineTo(size.width*.79,size.height*.34)..lineTo(size.width*.71,size.height*.29)..lineTo(size.width*.64,size.height*.34)..lineTo(size.width*.66,size.height*.25)..lineTo(size.width*.59,size.height*.19)..lineTo(size.width*.69,size.height*.18)..close();
    canvas.drawPath(star,Paint()..color=Color(0xFFFFB21A));
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)=>false;
}
