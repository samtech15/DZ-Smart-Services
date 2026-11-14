import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main()=>runApp(const DZApp());
const forest=Color(0xFF0B6B50),mint=Color(0xFFDDF4E9),gold=Color(0xFFE9B96E);
class S{final String name,desc,cat,url,tag;final IconData icon;const S(this.name,this.desc,this.cat,this.url,this.icon,{this.tag='رابط رسمي'});}
const data=<S>[
S('تعبئة موبيليس','الدفع الإلكتروني وإعادة شحن الرصيد','فليكسي','https://e-paiement.mobilis.dz/',Icons.sim_card,tag:'Mobilis'),
S('فضاء جازي E-Flexy','التعبئة وخدمات المشتركين','فليكسي','https://moncompte.djezzy.dz/',Icons.bolt,tag:'Djezzy'),
S('تعبئة أوريدو','التعبئة والاشتراكات','فليكسي','https://estorm.ooredoo.dz/',Icons.wifi,tag:'Ooredoo'),
S('دفع وتعبئة Idoom','تسديد الفواتير وتعبئة الإنترنت','إنترنت','https://paiement.algerietelecom.dz/',Icons.router,tag:'Algérie Télécom'),
S('اتصالات الجزائر','العروض والاشتراكات وفضاء الزبون','إنترنت','https://www.algerietelecom.dz/',Icons.language),
S('بريد الجزائر','الخدمات البريدية والبطاقة الذهبية','مالية','https://www.poste.dz/',Icons.account_balance),
S('وزارة الداخلية','البطاقة البيومترية وجواز السفر ورخصة السياقة','إداري','https://services.interieur.gov.dz/ar/',Icons.badge),
S('الحالة المدنية','شهادات الميلاد والزواج والوفاة','إداري','https://services.interieur.gov.dz/ar/',Icons.description),
S('الشباك عن بعد','إيداع الملفات والإجراءات الإدارية','إداري','https://services.interieur.gov.dz/ar/',Icons.assignment),
S('وزارة العدل','الخدمات القضائية والمعلومات','عدالة','https://www.mjustice.dz/',Icons.gavel),
S('الجريدة الرسمية','القوانين والمراسيم','عدالة','https://www.joradp.dz/',Icons.menu_book),
S('ANEM','عروض العمل وخدمات طالبي العمل','عمل','https://www.anem.dz/',Icons.work),
S('وسيط ANEM','فضاء طالبي العمل','عمل','https://wassitonline.anem.dz/',Icons.person_search),
S('CNAS الهناء','خدمات المؤمن لهم اجتماعياً','ضمان','https://elhanaa.cnas.dz/',Icons.health_and_safety),
S('CASNOS','الضمان الاجتماعي لغير الأجراء','ضمان','https://www.casnos.dz/',Icons.medical_services),
S('الصندوق الوطني للتقاعد','خدمات المتقاعدين','ضمان','https://www.cnr.dz/',Icons.elderly),
S('فضاء أولياء التلاميذ','متابعة النتائج والحياة المدرسية','تعليم','https://awlyaa.education.dz/',Icons.school),
S('وزارة التربية','الامتحانات والخدمات','تعليم','https://www.education.gov.dz/',Icons.cast_for_education),
S('التعليم العالي','الوزارة والخدمات الجامعية','تعليم','https://www.mesrs.dz/',Icons.account_balance),
S('AADL','السكن والبرامج والخدمات','سكن','https://www.aadl.com.dz/',Icons.home_work),
S('وزارة السكن','برامج السكن والتعمير','سكن','https://www.mhuv.gov.dz/',Icons.apartment),
S('الضرائب','التصريحات والخدمات الجبائية','مالية','https://www.mfdgi.gov.dz/',Icons.receipt_long),
S('سونلغاز','الكهرباء والغاز وخدمات الزبائن','فواتير','https://www.sonelgaz.dz/',Icons.bolt),
S('الجزائرية للمياه','المياه والفواتير','فواتير','https://www.ade.dz/',Icons.water_drop),
S('SNTF','القطارات والتنقل','نقل','https://www.sntf.dz/',Icons.train),
S('الخطوط الجوية الجزائرية','الرحلات والحجز','نقل','https://airalgerie.dz/',Icons.flight),
S('DZDS — البوابة الوطنية','الدخول المباشر إلى البوابة الوطنية للخدمات الرقمية','إداري','https://dzds.dz/',Icons.hub,tag:'بوابة وطنية رسمية'),
S('جواز السفر البيومتري','بوابة خدمات جواز السفر','إداري','https://passeport.interieur.gov.dz/',Icons.travel_explore),
S('وزارة الشؤون الخارجية','الخدمات القنصلية والشؤون الخارجية','إداري','https://www.mfa.gov.dz/',Icons.public),
S('وزارة التجارة','حماية المستهلك والسجل التجاري والتجارة','تجارة','https://www.commerce.gov.dz/',Icons.store),
S('السجل التجاري Sidjilcom','خدمات المركز الوطني للسجل التجاري','تجارة','https://sidjilcom.cnrc.dz/',Icons.business),
S('جبايتك Jibayatic','الخدمات والتصريح الجبائي عن بعد','مالية','https://jibayatic.mf.gov.dz/',Icons.receipt_long),
S('الرقم التعريفي الجبائي','خدمات التعريف الجبائي','مالية','https://nifenligne.mf.gov.dz/',Icons.numbers),
S('الجمارك الجزائرية','الخدمات والمعلومات الجمركية','تجارة','https://www.douane.gov.dz/',Icons.local_shipping),
S('وزارة الصحة','الأخبار والخدمات الصحية الرسمية','صحة','https://www.sante.gov.dz/',Icons.local_hospital),
S('وزارة التكوين المهني','التكوين والتسجيلات المهنية','تعليم','https://www.mfep.gov.dz/',Icons.school),
S('وكالة الأنباء الجزائرية APS','الأخبار الوطنية','مواقع عامة','https://www.aps.dz/',Icons.newspaper),
];
class DZApp extends StatefulWidget{const DZApp({super.key});@override State<DZApp> createState()=>_DZAppState();}
class _DZAppState extends State<DZApp>{ThemeMode mode=ThemeMode.light;@override Widget build(BuildContext c)=>MaterialApp(debugShowCheckedModeBanner:false,title:'DZ Smart Services',themeMode:mode,theme:ThemeData(useMaterial3:true,colorScheme:ColorScheme.fromSeed(seedColor:forest),scaffoldBackgroundColor:const Color(0xFFF5F7F4)),darkTheme:ThemeData(useMaterial3:true,brightness:Brightness.dark,colorScheme:ColorScheme.fromSeed(seedColor:forest,brightness:Brightness.dark)),home:Hub(toggle:()=>setState(()=>mode=mode==ThemeMode.dark?ThemeMode.light:ThemeMode.dark),dark:mode==ThemeMode.dark));}
class Hub extends StatefulWidget{final VoidCallback toggle;final bool dark;const Hub({super.key,required this.toggle,required this.dark});@override State<Hub> createState()=>_HubState();}
class _HubState extends State<Hub>{int tab=0;String q='',cat='الكل';final saved=<String>{};Future<void> go(String u)async{final ok=await launchUrl(Uri.parse(u),mode:LaunchMode.externalApplication);if(!ok&&mounted)ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('تعذر فتح الموقع')));}
@override Widget build(BuildContext c){final cats=['الكل','فليكسي','إنترنت','إداري','عدالة','عمل','ضمان','تعليم','سكن','مالية','تجارة','صحة','فواتير','نقل','مواقع عامة'];final list=data.where((s)=>(cat=='الكل'||s.cat==cat)&&(s.name+' '+s.desc+' '+s.cat).toLowerCase().contains(q.toLowerCase())&&(tab!=2||saved.contains(s.name))).toList();return Directionality(textDirection:TextDirection.rtl,child:Scaffold(appBar:AppBar(title:const Text('DZ SMART',style:TextStyle(fontWeight:FontWeight.w900,letterSpacing:1)),actions:[IconButton(onPressed:widget.toggle,icon:Icon(widget.dark?Icons.light_mode:Icons.dark_mode)),IconButton(onPressed:()=>showAboutDialog(context:c,applicationName:'DZ Smart Services',applicationVersion:'2.0',children:[const Text('دليل مستقل للوصول إلى المواقع الرسمية. تتم المعاملات لدى الجهات المعنية.')]),icon:const Icon(Icons.info_outline))]),body:SafeArea(child:Column(children:[if(tab==0)_hero(),Padding(padding:const EdgeInsets.fromLTRB(15,12,15,8),child:TextField(onChanged:(v)=>setState(()=>q=v),decoration:InputDecoration(hintText:'ابحث عن خدمة أو إدارة...',prefixIcon:const Icon(Icons.search),filled:true,border:OutlineInputBorder(borderRadius:BorderRadius.circular(18),borderSide:BorderSide.none)))),if(tab!=2)SizedBox(height:45,child:ListView(scrollDirection:Axis.horizontal,padding:const EdgeInsets.symmetric(horizontal:10),children:cats.map((x)=>Padding(padding:const EdgeInsets.symmetric(horizontal:3),child:ChoiceChip(label:Text(x),selected:cat==x,onSelected:(_)=>setState(()=>cat=x)))).toList())),Expanded(child:list.isEmpty?const Center(child:Text('لا توجد نتائج')):ListView.builder(padding:const EdgeInsets.all(13),itemCount:list.length,itemBuilder:(c,i)=>_tile(list[i])))])),bottomNavigationBar:NavigationBar(selectedIndex:tab,onDestinationSelected:(v)=>setState(()=>tab=v),destinations:const[NavigationDestination(icon:Icon(Icons.home_outlined),selectedIcon:Icon(Icons.home),label:'الرئيسية'),NavigationDestination(icon:Icon(Icons.grid_view),label:'كل الخدمات'),NavigationDestination(icon:Icon(Icons.bookmark_border),label:'المفضلة')])));}
Widget _hero()=>Container(margin:const EdgeInsets.fromLTRB(13,5,13,2),padding:const EdgeInsets.all(20),decoration:BoxDecoration(gradient:const LinearGradient(colors:[Color(0xFF092F28),Color(0xFF0B7657),Color(0xFF15966C)],begin:Alignment.topRight,end:Alignment.bottomLeft),borderRadius:BorderRadius.circular(26),boxShadow:[BoxShadow(color:forest.withOpacity(.2),blurRadius:18,offset:const Offset(0,8))]),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Row(children:[Icon(Icons.public,color:gold),SizedBox(width:7),Text('دليلك الرقمي الجزائري',style:TextStyle(color:Colors.white70))]),const SizedBox(height:12),const Text('كل خدماتك...\nفي مكان واحد.',style:TextStyle(color:Colors.white,fontSize:27,height:1.2,fontWeight:FontWeight.w900)),const SizedBox(height:8),const Text('تعبئة الرصيد، الفواتير، الوثائق والإدارات والخدمات اليومية.',style:TextStyle(color:Colors.white70,fontSize:13)),const SizedBox(height:17),Wrap(spacing:7,children:[_quick('فليكسي',Icons.flash_on,()=>setState(()=>cat='فليكسي')),_quick('الإدارات',Icons.account_balance,()=>setState(()=>cat='إداري')),_quick('Idoom',Icons.router,()=>go('https://paiement.algerietelecom.dz/')),_quick('DZDS',Icons.hub,()=>go('https://dzds.dz/'))])]));
Widget _quick(String t,IconData i,VoidCallback f)=>ActionChip(avatar:Icon(i,size:16,color:Colors.white),label:Text(t,style:const TextStyle(color:Colors.white,fontWeight:FontWeight.bold)),backgroundColor:Colors.white.withOpacity(.15),side:const BorderSide(color:Colors.white24),onPressed:f);
Widget _tile(S s){final fav=saved.contains(s.name);return Card(elevation:0,margin:const EdgeInsets.only(bottom:9),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(18),side:BorderSide(color:Theme.of(context).dividerColor.withOpacity(.3))),child:InkWell(borderRadius:BorderRadius.circular(18),onTap:()=>go(s.url),child:Padding(padding:const EdgeInsets.all(13),child:Row(children:[Container(width:47,height:47,decoration:BoxDecoration(color:mint,borderRadius:BorderRadius.circular(15)),child:Icon(s.icon,color:forest)),const SizedBox(width:11),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(s.name,style:const TextStyle(fontWeight:FontWeight.w800,fontSize:15)),const SizedBox(height:3),Text(s.desc,maxLines:2,overflow:TextOverflow.ellipsis,style:const TextStyle(fontSize:12,color:Colors.grey)),const SizedBox(height:6),Text(s.cat+' • '+s.tag,style:const TextStyle(fontSize:10,color:forest,fontWeight:FontWeight.bold))])),IconButton(onPressed:()=>setState(()=>fav?saved.remove(s.name):saved.add(s.name)),icon:Icon(fav?Icons.bookmark:Icons.bookmark_border,color:fav?forest:null)),const Icon(Icons.open_in_new,size:16,color:Colors.grey)]))));}
}
