import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const DZSmartServicesApp());

class DZSmartServicesApp extends StatelessWidget {
  const DZSmartServicesApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DZ Smart Services',
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF087F5B)), useMaterial3: true),
    home: const HomePage(),
  );
}

class Service {
  final String title, subtitle, category, url;
  final IconData icon;
  const Service(this.title, this.subtitle, this.category, this.url, this.icon);
}

const services = <Service>[
  Service('بريد الجزائر', 'BaridiMob و ECCP والخدمات البريدية', 'المالية', 'https://www.poste.dz/', Icons.account_balance),
  Service('Mobilis', 'الموقع والخدمات الرسمية', 'الاتصالات', 'https://www.mobilis.dz/', Icons.signal_cellular_alt),
  Service('Djezzy', 'العروض وخدمات المشتركين', 'الاتصالات', 'https://www.djezzy.dz/', Icons.sim_card),
  Service('Ooredoo', 'العروض وخدمات المشتركين', 'الاتصالات', 'https://www.ooredoo.dz/', Icons.network_cell),
  Service('اتصالات الجزائر', 'الإنترنت والخدمات', 'الاتصالات', 'https://www.algerietelecom.dz/', Icons.wifi),
  Service('CNAS', 'فضاء المؤمن له', 'إداري', 'https://elhanaa.cnas.dz/', Icons.health_and_safety),
  Service('SNTF', 'مواعيد القطارات والحجز', 'النقل', 'https://www.sntf.dz/', Icons.train),
  Service('ANEM', 'الوكالة الوطنية للتشغيل', 'عمل', 'https://www.anem.dz/', Icons.work),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  String query = '';
  String category = 'الكل';
  bool dark = false;
  final favorites = <String>{};
  Future<void> open(String value) async {
    final uri = Uri.parse(value);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication) && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تعذر فتح الرابط')));
    }
  }
  @override
  Widget build(BuildContext context) {
    final filtered = services.where((s) =>
      (category == 'الكل' || s.category == category) &&
      (s.title.toLowerCase().contains(query.toLowerCase()) || s.subtitle.toLowerCase().contains(query.toLowerCase()))).toList();
    return Theme(
      data: dark ? ThemeData.dark(useMaterial3: true) : ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF087F5B)), useMaterial3: true),
      child: Scaffold(
        appBar: AppBar(title: const Text('DZ Smart Services', style: TextStyle(fontWeight: FontWeight.bold)), centerTitle: true,
          actions: [IconButton(onPressed: () => setState(() => dark = !dark), icon: Icon(dark ? Icons.light_mode : Icons.dark_mode))]),
        body: Directionality(textDirection: TextDirection.rtl, child: Column(children: [
          Container(width: double.infinity, padding: const EdgeInsets.all(20), color: const Color(0xFF087F5B),
            child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('خدماتك الجزائرية في مكان واحد', style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.bold)),
              SizedBox(height: 6), Text('روابط رسمية، وصول سريع ومعلومات موثوقة', style: TextStyle(color: Colors.white70)),
            ])),
          Padding(padding: const EdgeInsets.all(12), child: TextField(
            textDirection: TextDirection.rtl, decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: 'ابحث عن خدمة...', border: OutlineInputBorder(borderRadius: BorderRadius.circular(14))),
            onChanged: (v) => setState(() => query = v))),
          SizedBox(height: 48, child: ListView(scrollDirection: Axis.horizontal, children: ['الكل','الاتصالات','المالية','النقل','إداري','عمل'].map((c) =>
            Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: ChoiceChip(label: Text(c), selected: category == c, onSelected: (_) => setState(() => category = c)))).toList())),
          Expanded(child: GridView.builder(padding: const EdgeInsets.all(12), itemCount: filtered.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.12, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemBuilder: (context, i) { final s = filtered[i]; final fav = favorites.contains(s.title);
              return Card(child: InkWell(borderRadius: BorderRadius.circular(12), onTap: () => open(s.url), child: Padding(padding: const EdgeInsets.all(12),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [Icon(s.icon, color: const Color(0xFF087F5B), size: 28), const Spacer(), IconButton(visualDensity: VisualDensity.compact, onPressed: () => setState(() => fav ? favorites.remove(s.title) : favorites.add(s.title)), icon: Icon(fav ? Icons.favorite : Icons.favorite_border, color: fav ? Colors.red : null))]),
                  const Spacer(), Text(s.title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4), Text(s.subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall),
                  const SizedBox(height: 8), const Row(children: [Text('فتح الخدمة'), SizedBox(width: 4), Icon(Icons.open_in_new, size: 14)])
                ]))));
            })),
          const Padding(padding: EdgeInsets.all(10), child: Text('تطبيق مستقل يفتح المواقع الرسمية. لا يطلب كلمات المرور أو رموز OTP أو بيانات البطاقات.', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Colors.grey))),
        ])),
      ),
    );
  }
}
