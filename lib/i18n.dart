import 'package:flutter/foundation.dart';

/// Current UI language. Every Text widget listens to this, so changing the
/// language updates the whole app instantly without a restart.
final languageNotifier = ValueNotifier<String>('English');

const supportedLanguages = ['English', 'አማርኛ', 'Afaan Oromo'];

String trFor(String lang, String s) {
  if (lang == 'English') return s;
  final e = _t[s];
  if (e == null) return s;
  return lang == 'አማርኛ' ? e.$1 : e.$2;
}

String tr(String s) => trFor(languageNotifier.value, s);

// English : (Amharic, Afaan Oromo)
// NOTE: These translations must be reviewed by native speakers before launch.
const _t = <String, (String, String)>{
  // ----- navigation & common
  'Home': ('ቤት', 'Mana'),
  'Explore': ('ያስሱ', 'Qorannoo'),
  'Report': ('ሪፖርት', 'Gabaasa'),
  'Support': ('ድጋፍ', 'Deeggarsa'),
  'Profile': ('መገለጫ', 'Piroofayilii'),
  'Back': ('ተመለስ', 'Duubatti'),
  'Back to home': ('ወደ መነሻ ተመለስ', "Gara manaatti deebi'i"),
  'Back to SheRise Home': (
    'ወደ SheRise መነሻ ተመለስ',
    "Gara SheRise manaatti deebi'i",
  ),
  'Back to start': ('ወደ መጀመሪያው ተመለስ', "Gara jalqabaatti deebi'i"),
  'Back to incident category': (
    'ወደ ክስተት ምድብ ተመለስ',
    "Gara gosa taateetti deebi'i",
  ),
  'Back to Board': ('ወደ ቦርድ ተመለስ', "Gara Boordiitti deebi'i"),
  'Back to Institution Board': (
    'ወደ ተቋም ቦርድ ተመለስ',
    "Gara Boordii Dhaabbataatti deebi'i",
  ),
  'Back to all cases': ('ወደ ሁሉም ጉዳዮች ተመለስ', "Gara dhimmoota hundaatti deebi'i"),
  'Back to Safety Center': (
    'ወደ ደህንነት ማዕከል ተመለስ',
    "Gara Wiirtuu Nageenyaatti deebi'i",
  ),
  'Back to SafeVoice': ('ወደ ደህንነቱ የተጠበቀ ድምፅ ተመለስ', "Gara SafeVoice'tti deebi'i"),
  'Next': ('ቀጥል', 'Itti aanu'),
  'Cancel': ('ሰርዝ', 'Haqi'),
  'Save': ('አስቀምጥ', "Olkaa'i"),
  'Delete': ('ሰርዝ', 'Haqi'),
  'Remove': ('አስወግድ', 'Balleessi'),
  'Edit': ('አርም', 'Gulaali'),
  'Manage': ('አስተዳድር', 'Bulchi'),
  'Try again': ('እንደገና ሞክር', "Irra deebi'ii yaali"),
  'Quick exit': ('ፈጣን መውጫ', "Battalumatti ba'i"),
  'Language': ('ቋንቋ', 'Afaan'),
  'Name': ('ስም', 'Maqaa'),
  'All': ('ሁሉም', 'Hunda'),
  'Call': ('ደውይ', 'Bilbili'),
  'Email': ('ኢሜይል', 'Imeelii'),
  'Verified': ('የተረጋገጠ', "Mirkanaa'e"),
  'Sample listing': ('ናሙና ዝርዝር', 'Tarreeffama fakkeenyaa'),

  // ----- welcome & account
  'Skip introduction': ('መግቢያውን ዝለል', 'Seensa irra utaali'),
  'Your voice belongs here.': (
    'ድምፅሽ እዚህ ቦታ አለው።',
    'Sagaleen kee asitti kan keeti.',
  ),
  'Support, on your terms.': ('ድጋፍ፣ በራስሽ መንገድ።', 'Deeggarsa, akka feetetti.'),
  'Your next chapter starts with you.': (
    'ቀጣዩ ምዕራፍሽ ከአንቺ ይጀምራል።',
    'Boqonnaan kee itti aanu si irraa jalqaba.',
  ),
  'A space for you': ('ለአንቺ የሚሆን ቦታ', 'Iddoo siif ta\'e'),
  'You are not alone': ('ብቻሽን አይደለሽም', 'Kophaa kee miti'),
  'Make room for your future': ('ለመጻኢ ጊዜሽ ቦታ ስጪ', 'Egeree keetiif iddoo kenni'),
  'Create private access': ('የግል መግቢያ ፍጠሪ', 'Seensa dhuunfaa uumi'),
  'Sign in': ('ግቢ', 'Seeni'),
  'Welcome back.': ('እንኳን ደህና መጣሽ።', 'Baga nagaan deebitee dhuftee.'),
  'Email address': ('የኢሜይል አድራሻ', 'Teessoo imeelii'),
  'Password': ('የይለፍ ቃል', 'Jecha darbii'),
  'Forgot access?': ('መግቢያሽን ረሳሽው?', 'Seensa irraanfatte?'),
  'A little space for you.': ('ለአንቺ ትንሽ ቦታ።', 'Iddoo xiqqoo siif.'),
  'Create account': ('መለያ ፍጠሪ', 'Akkaawuntii uumi'),
  'Recover your access': ('መግቢያሽን መልሺ', 'Seensa kee deebisi'),
  'Send reset link': ('የዳግም ማስጀመሪያ ሊንክ ላክ', 'Liinkii deebisanii kaa\'uu ergi'),
  'Check your email': ('ኢሜይልሽን ተመልከቺ', 'Imeelii kee ilaali'),
  'Back to sign in': ('ወደ መግቢያ ተመለሺ', 'Gara seensaatti deebi\'i'),
  'Your safety. Your voice. Your future.': (
    'ደህንነትሽ። ድምፅሽ። መጻኢ ጊዜሽ።',
    'Nageenya kee. Sagalee kee. Egeree kee.',
  ),
  'Designed with care, for women and girls.': (
    'ለሴቶችና ለልጃገረዶች በጥንቃቄ የተሰራ።',
    'Dubartootaa fi durboota irratti of-eeggannoodhaan kan hojjetame.',
  ),
  'Demo mode': ('የሙከራ ሁነታ', 'Haala qorannoo'),
  'Name or nickname (optional)': (
    'ስም ወይም ቅጽል ስም (አማራጭ)',
    'Maqaa ykn moggaasa (filannoo)',
  ),

  // ----- home
  'Here, you come first': ('እዚህ አንቺ ትቀድሚያለሽ', 'Asitti, ati dursa argatta'),
  'A safer today.\nA stronger tomorrow.': (
    'ዛሬ ይበልጥ ደህንነት።\nነገ ይበልጥ ጥንካሬ።',
    'Har\'a nageenya caalu.\nBori cimina caalu.',
  ),
  'SOS / Safety Center': ('SOS / የደህንነት ማዕከል', 'SOS / Giddugala Nageenyaa'),
  'Emergency information & trusted contacts': (
    'የአደጋ ጊዜ መረጃ እና የታመኑ ሰዎች',
    'Odeeffannoo yeroo ariifachiisaa fi namoota amanamoo',
  ),
  'How can we help?': (
    'እንዴት ልንረዳሽ እንችላለን?',
    'Akkamittiin si gargaaruu dandeenya?',
  ),
  'SafeVoice': ('ደህንነቱ የተጠበቀ ድምፅ', 'Sagalee Nageenya Qabu'),
  'SupportConnect': ('የድጋፍ ግንኙነት', 'Quunnamtii Deeggarsaa'),
  'EqualOpportunity': ('እኩል እድል', 'Carraa Wal-qixa'),
  'Speak up, your way': ('በራስሽ መንገድ ተናገሪ', 'Akka feetetti dubbadhu'),
  'Find someone to help': ('የሚረዳሽ ሰው አግኚ', 'Nama si gargaaru barbaadi'),
  'Build your next chapter': (
    'ቀጣዩን ምዕራፍሽን ገንቢ',
    'Boqonnaa kee itti aanu ijaari',
  ),
  'View private updates': ('የግል ዝመናዎችን ተመልከቺ', 'Odeeffannoo dhuunfaa ilaali'),
  'A step toward your future': (
    'ወደ መጻኢ ጊዜሽ የሚወስድ እርምጃ',
    'Tarkaanfii gara egeree keetti',
  ),
  'Explore all': ('ሁሉንም ያስሱ', 'Hunda ilaali'),
  'A small safety habit': ('ትንሽ የደህንነት ልማድ', 'Amala nageenyaa xiqqaa'),

  // ----- SafeVoice
  'Your voice matters.': ('ድምፅሽ አስፈላጊ ነው።', 'Sagaleen kee ni barbaachisa.'),
  'Not an emergency service': (
    'የአደጋ ጊዜ አገልግሎት አይደለም',
    'Tajaajila yeroo ariifachiisaa miti',
  ),
  'Choose how to speak up': (
    'እንዴት መናገር እንደምትፈልጊ ምረጪ',
    'Akkamitti dubbachuu akka feetu filadhu',
  ),
  'Anonymous': ('ማንነት የማይታወቅ', 'Maqaa malee'),
  'Confidential': ('ሚስጥራዊ', 'Icciitii'),
  'How reporting works': ('ሪፖርት ማድረግ እንዴት ይሰራል', 'Gabaasni akkamitti hojjata'),
  'Choose an incident category': ('የክስተቱን ዓይነት ምረጪ', 'Gosa dhimmichaa filadhu'),
  'Share details at your own pace': (
    'ዝርዝሩን በራስሽ ፍጥነት አጋሪ',
    'Bal\'ina saffisa kee irratti qooddadhu',
  ),
  'Review privacy, then submit': (
    'ግላዊነትን ገምግሚ፣ ከዚያ አስገቢ',
    'Iccitii gamaaggami, booda ergi',
  ),
  'Start a report': ('ሪፖርት ጀምሪ', 'Gabaasa jalqabi'),
  'Resume private draft': ('የግል ረቂቅ ቀጥዪ', 'Dalagaa dhuunfaa itti fufi'),
  'What would you like to report?': (
    'ምን ሪፖርት ማድረግ ትፈልጊያለሽ?',
    'Maal gabaasuu barbaaddu?',
  ),
  'Incident category · Required': (
    'የክስተት ዓይነት · ያስፈልጋል',
    'Gosa dhimmaa · Barbaachisaa',
  ),
  'Harassment': ('ትንኮሳ', 'Rakkisuu'),
  'Discrimination': ('መድልዎ', 'Garaagarummaa'),
  'Bullying': ('ጉልበተኝነት', 'Cunqursuu'),
  'Other': ('ሌላ', 'Kan biraa'),
  'Abuse': ('ጥቃት', 'Miidhaa'),
  'Disrespect': ('ክብር ማጉደል', 'Kabaja dhabuu'),
  'Unequal opportunity': ('እኩል ያልሆነ እድል', 'Carraa wal-qixa hin taane'),
  'Approximate date (optional)': (
    'ግምታዊ ቀን (አማራጭ)',
    'Guyyaa tilmaamaa (filannoo)',
  ),
  'Choose a month': ('ወር ምረጪ', 'Ji\'a filadhu'),
  'Broad location (optional)': (
    'ሰፋ ያለ አካባቢ (አማራጭ)',
    'Iddoo bal\'aa (filannoo)',
  ),
  'Location stays your choice': (
    'አካባቢ የአንቺ ምርጫ ነው',
    'Iddoon filannoo kee ta\'ee hafa',
  ),
  'Continue to details': ('ወደ ዝርዝር ቀጥዪ', 'Gara bal\'inaatti itti fufi'),
  'Save private draft': ('የግል ረቂቅ አስቀምጪ', 'Dalagaa dhuunfaa olkaa\'i'),
  'Share at your own pace': ('በራስሽ ፍጥነት አጋሪ', 'Saffisa kee irratti qooddadhu'),
  'What happened? · Required': (
    'ምን ተፈጠረ? · ያስፈልጋል',
    'Maaltu ta\'e? · Barbaachisaa',
  ),
  'Evidence (optional)': ('ማስረጃ (አማራጭ)', 'Ragaa (filannoo)'),
  'Add a photo or PDF': ('ፎቶ ወይም PDF ጨምሪ', 'Suuraa ykn PDF dabali'),
  'Record a voice note': ('የድምፅ መልእክት ቅረጪ', 'Ergaa sagalee waraabi'),
  'Stop recording': ('ቀረጻውን አቁሚ', 'Waraabuu dhaabi'),
  'Voice note': ('የድምፅ መልእክት', 'Ergaa sagalee'),
  'You can speak instead of typing': (
    'ከመጻፍ ይልቅ መናገር ትችያለሽ',
    'Barreessuu dhiisitee dubbachuu dandeessa',
  ),
  'Continue to privacy & review': (
    'ወደ ግላዊነት እና ግምገማ ቀጥዪ',
    'Gara iccitii fi gamaaggamaatti itti fufi',
  ),
  'Your privacy, your choice': ('ግላዊነትሽ፣ ምርጫሽ', 'Iccitiin kee, filannoon kee'),
  'Anonymous report': ('ማንነት የማይታወቅ ሪፖርት', 'Gabaasa maqaa malee'),
  'Confidential report': ('ሚስጥራዊ ሪፖርት', 'Gabaasa icciitii'),
  'Understand the limits': ('ገደቦቹን ተረጂ', 'Daangaawwan hubadhu'),
  'Review your report': ('ሪፖርትሽን ገምግሚ', 'Gabaasa kee gamaaggami'),
  'Non-sensitive summary': ('ሚስጥራዊ ያልሆነ ማጠቃለያ', 'Cuunfaa dhoksaa hin taane'),
  'No location sharing': ('አካባቢ አይጋራም', 'Iddoon hin qooddatamu'),
  'Submit report': ('ሪፖርት አስገቢ', 'Gabaasa ergi'),
  'Back to details': ('ወደ ዝርዝር ተመለሺ', 'Gara bal\'inaatti deebi\'i'),
  'Your voice has a place.': ('ድምፅሽ ቦታ አለው።', 'Sagaleen kee iddoo ni qaba.'),
  'Your private access code': ('የግል መግቢያ ኮድሽ', 'Koodii seensaa dhuunfaa kee'),
  'Copy access code': ('ኮዱን ቅጂ', 'Koodii waraabi'),
  'A receipt is not a response guarantee': (
    'ደረሰኝ የምላሽ ዋስትና አይደለም',
    'Raasiidiin mirkaneessa deebii miti',
  ),
  'Track this case': ('ይህን ጉዳይ ተከታተይ', 'Dhimma kana hordofi'),
  'Return home': ('ወደ ቤት ተመለሺ', 'Gara mana deebi\'i'),

  // ----- safety
  'Safety Center': ('የደህንነት ማዕከል', 'Giddugala Nageenyaa'),
  'Take one safe step.': (
    'አንድ ደህንነቱ የተጠበቀ እርምጃ ውሰጂ።',
    'Tarkaanfii nageenya qabu tokko fudhadhu.',
  ),
  'No automatic alerts or dispatch.': (
    'ምንም ራስ-ሰር ማንቂያ ወይም ላኪ የለም።',
    'Akeekkachiisni ykn ergaan ofumaa hin jiru.',
  ),
  'If you are in immediate danger, move to a safer place if possible': (
    'አፋጣኝ አደጋ ላይ ከሆንሽ፣ ከተቻለ ወደ ደህንነቱ ወደተጠበቀ ቦታ ሂጂ',
    'Yoo balaa ariifachiisaa keessa jirte, yoo danda\'ame iddoo nageenya qabu deemi',
  ),
  'Confirm numbers before relying on them': (
    'ከመመካትሽ በፊት ቁጥሮቹን አረጋግጪ',
    'Osoo hin amanin dura lakkoofsota mirkaneessi',
  ),
  'Emergency resources': ('የአደጋ ጊዜ መገልገያዎች', 'Madda yeroo ariifachiisaa'),
  'Reach someone you trust': ('የምታምኚውን ሰው አግኚ', 'Nama amantu quunnamsiisi'),
  'Trusted contact': ('የታመነ ሰው', 'Nama amanamaa'),
  'Add a trusted contact': ('የታመነ ሰው ጨምሪ', 'Nama amanamaa dabali'),
  'Share my location': ('አካባቢዬን አጋራ', 'Iddoo koo qooddadhu'),
  'Not available in this version': (
    'በዚህ ስሪት አይገኝም',
    'Gosa kana keessatti hin argamu',
  ),
  'Planning ahead': ('አስቀድሞ ማቀድ', 'Dursanii karoorfachuu'),
  'My safety plan': ('የደህንነት እቅዴ', 'Karoora nageenya koo'),
  'While you find support': ('ድጋፍ እስክታገኚ ድረስ', 'Yeroo deeggarsa barbaaddutti'),
  'Review before sharing': (
    'ከማጋራትሽ በፊት ገምግሚ',
    'Osoo hin qooddatin dura gamaaggami',
  ),
  'Review, then share': ('ገምግሚ፣ ከዚያ አጋሪ', 'Gamaaggami, booda qooddadhu'),
  'Message preview': ('የመልእክት ቅድመ እይታ', 'Dursa ergaa'),
  'SheRise does not automatically contact emergency services.': (
    'SheRise የአደጋ ጊዜ አገልግሎቶችን በራሱ አያነጋግርም።',
    'SheRise tajaajila yeroo ariifachiisaa ofumaan hin quunnamu.',
  ),

  // ----- support & explore
  'Find trusted counseling, legal-aid and support services.': (
    'የታመኑ የምክር፣ የሕግ ድጋፍ እና ሌሎች የድጋፍ አገልግሎቶችን አግኚ።',
    'Tajaajila gorsaa, gargaarsa seeraa fi deeggarsa amanamaa barbaadi.',
  ),
  'Counseling': ('ምክር', 'Gorsa'),
  'Legal aid': ('የሕግ ድጋፍ', 'Gargaarsa seeraa'),
  'GBV support': ('ጾታ ተኮር ጥቃት ድጋፍ', 'Deeggarsa miidhaa saalaa'),
  'Health': ('ጤና', 'Fayyaa'),
  'Shelter': ('መጠለያ', 'Iddoo of-baraaruu'),
  'Opportunities': ('እድሎች', 'Carraawwan'),
  'Learn': ('ትምህርት', 'Barnoota'),
  'Scholarship': ('ስኮላርሺፕ', 'Isgoolarshippii'),
  'Internship': ('የልምምድ ስራ', 'Leenjii hojii'),
  'Job': ('ስራ', 'Hojii'),
  'Training': ('ስልጠና', 'Leenjii'),
  'Mentorship': ('መካሪነት', 'Qajeelfama'),
  'View details →': ('ዝርዝር ተመልከቺ →', 'Bal\'ina ilaali →'),
  'Who can apply': ('ማን ማመልከት ይችላል', 'Eenyutu iyyachuu danda\'a'),
  'Open application page': ('የማመልከቻ ገጹን ክፈቺ', 'Fuula iyyannoo bani'),

  // ----- cases
  'My Cases': ('የእኔ ጉዳዮች', 'Dhimmoota koo'),
  'No cases yet': ('እስካሁን ምንም ጉዳይ የለም', 'Ammaaf dhimmi hin jiru'),
  'Track a case by code': ('በኮድ ጉዳይ ተከታተይ', 'Koodiidhaan dhimma hordofi'),
  'Private access code': ('የግል መግቢያ ኮድ', 'Koodii seensaa dhuunfaa'),
  'Add case': ('ጉዳይ ጨምሪ', 'Dhimma dabali'),
  'Messages': ('መልእክቶች', 'Ergaawwan'),
  'Send message': ('መልእክት ላኪ', 'Ergaa ergi'),
  'Case update': ('የጉዳይ ዝመና', 'Haaromsa dhimmaa'),
  'Remove from this device': ('ከዚህ መሣሪያ አስወግጂ', 'Meeshaa kana irraa balleessi'),

  // ----- profile
  'Profile & help': ('መገለጫ እና እገዛ', 'Piroofayilii fi gargaarsa'),
  'Guest': ('እንግዳ', 'Keessummaa'),
  'Privacy & safety': ('ግላዊነት እና ደህንነት', 'Iccitii fi nageenya'),
  'Help & information': ('እገዛ እና መረጃ', 'Gargaarsa fi odeeffannoo'),
  'Your data': ('መረጃሽ', 'Daataa kee'),
  'Delete data on this device': (
    'በዚህ መሣሪያ ላይ ያለውን መረጃ ሰርዢ',
    'Daataa meeshaa kana irra jiru haqi',
  ),
  'Sign out': ('ውጪ', 'Ba\'i'),
  'Sign in or create access': ('ግቢ ወይም መለያ ፍጠሪ', 'Seeni ykn akkaawuntii uumi'),
  'App lock & discreet mode': (
    'የመተግበሪያ መቆለፊያ እና ስውር ሁነታ',
    'Cufaa appii fi haala dhoksaa',
  ),
  'How SheRise works': ('SheRise እንዴት ይሰራል', 'SheRise akkamitti hojjata'),
  'What anonymous means': (
    'ማንነት የማይታወቅ ማለት ምን ማለት ነው',
    'Maqaa malee jechuun maal jechuudha',
  ),
  'What we store': ('ምን እናስቀምጣለን', 'Maal kuufna'),
  'Emergencies': ('የአደጋ ጊዜዎች', 'Yeroo ariifachiisaa'),

  // ----- privacy, eye button & location
  'Privacy & Visibility': ('ግላዊነት እና ታይነት', 'Iccitii fi Mul\'annoo'),
  'Show details': ('ዝርዝሩን አሳይ', 'Bal\'ina agarsiisi'),
  'Hide details': ('ዝርዝሩን ደብቅ', 'Bal\'ina dhoksi'),
  'Details hidden for privacy': (
    'ዝርዝሮች ለግላዊነት ተደብቀዋል',
    'Bal\'inni icciitiif dhokfameera',
  ),
  'Tap the eye icon to view or hide your description': (
    'መግለጫሽን ለማየት ወይም ለመደበቅ የዓይን ምልክቱን ነኪ',
    'Ibsa kee arguuf ykn dhoksuuf mallattoo ijaa tuqi',
  ),
  'Location': ('አካባቢ', 'Iddoo'),
  'Broad location': ('ሰፊ አካባቢ', 'Iddoo bal’aa'),
  'Location included': ('አካባቢ ተካትቷል', 'Iddoon dabalameera'),
  'No location attached': ('ምንም አካባቢ አልተያያዘም', 'Iddoon hin qabsiifamne'),
  'Use GPS location': ('የGPS አካባቢ ተጠቀም', 'Bakka GPS fayyadami'),
  'Getting GPS location...': (
    'የGPS አካባቢን በማግኘት ላይ...',
    'Iddoo GPS argachaa jira...',
  ),
  'Clear location': ('አካባቢውን አስወግድ', 'Iddoo haqi'),
  'Location added': ('አካባቢ ታክሏል', 'Iddoon dabalameera'),
  'Location removed': ('አካባቢ ተወግዷል', 'Iddoon haqameera'),
  'Location permission denied': (
    'የአካባቢ ፈቃድ ተከልክሏል',
    'Hayyamni iddoo dhowwameera',
  ),
  'Choose language': ('ቋንቋ ምረጪ', 'Afaan filadhu'),
  'Select language': ('ቋንቋ ይምረጡ', 'Afaan filadhaa'),
  'Consent & Submit': ('ፈቃድ እና ማቅረብ', 'Hayyama fi Galchuu'),
  'Category': ('ዓይነት', 'Gosa'),
  'Approximate date': ('ግምታዊ ቀን', 'Guyyaa tilmaamaa'),
  'Not given': ('አልተገለጸም', 'Hin ibsamne'),
  'Evidence': ('ማስረጃ', 'Ragaa'),
  'None attached': ('ምንም አልተያያዘም', 'Homtuu hin qabsiifamne'),
  'Description': ('መግለጫ', 'Ibsa'),
  'Institution Board': ('የተቋም ቦርድ', 'Boordii Dhaabbataa'),

  // ----- account & institution access
  'Your choice is saved.': ('ምርጫሽ ተቀምጧል።', 'Filannoon kee olkaa’ameera.'),
  'Create a new account': ('አዲስ መለያ ፍጠሪ', 'Akkaawuntii haaraa uumi'),
  'Already have an account? Sign in': (
    'መለያ አለሽ? ግቢ',
    'Akkaawuntii qabdaa? Seeni',
  ),
  'Already registered? Institution sign in': (
    'አስቀድመው ተመዝግበዋል? ወደ ተቋም ይግቡ',
    'Dura galmooftaniittuu? Dhaabbataaf seenaa',
  ),
  'Account access is unavailable until Supabase is configured.': (
    'Supabase እስኪዋቀር ድረስ መለያውን መጠቀም አይቻልም።',
    'Hanga Supabase qindaa’utti akkaawuntii fayyadamuun hin danda’amu.',
  ),
  'Account registration is unavailable until Supabase is configured.': (
    'Supabase እስኪዋቀር ድረስ መለያ መፍጠር አይቻልም።',
    'Hanga Supabase qindaa’utti akkaawuntii galmeessuun hin danda’amu.',
  ),
  'Account recovery is unavailable until Supabase is configured.': (
    'Supabase እስኪዋቀር ድረስ መለያን ማስመለስ አይቻልም።',
    'Hanga Supabase qindaa’utti akkaawuntii deebisuun hin danda’amu.',
  ),
  'Institution portal': ('የተቋም መግቢያ', 'Karaa seensaa dhaabbataa'),
  'Register an institution': ('ተቋም ይመዝግቡ', 'Dhaabbata galmeessaa'),
  'Register your institution': ('ተቋምዎን ይመዝግቡ', 'Dhaabbata keessan galmeessaa'),
  'Institution sign in': ('የተቋም መግቢያ', 'Seensa dhaabbataa'),
  'Institution access': ('የተቋም መግቢያ', 'Seensa dhaabbataa'),
  'Register your organization or sign in to access its separate case dashboard.':
      (
        'የተቋምዎን የጉዳይ ዳሽቦርድ ለመጠቀም ተቋሙን ይመዝግቡ ወይም ይግቡ።',
        'Daashboordii dhimma dhaabbata keessanii argachuuf galmeessaa ykn seenaa.',
      ),
  'Register your institution to access its dashboard after sign-up.': (
    'ከተመዘገቡ በኋላ የተቋምዎን ዳሽቦርድ ለመጠቀም ተቋምዎን ይመዝግቡ።',
    'Galmaa’anii booda daashboordii dhaabbata keessanii argachuuf dhaabbata keessan galmeessaa.',
  ),
  'Provide your organization details to access its dashboard after sign-up.': (
    'ከተመዘገቡ በኋላ ዳሽቦርዱን ለመጠቀም የተቋምዎን ዝርዝር ያስገቡ።',
    'Galmaa’anii booda daashboordii argachuuf odeeffannoo dhaabbata keessanii galchaa.',
  ),
  'Supabase setup required': (
    'Supabase ማዋቀር ያስፈልጋል',
    'Supabase qindeessuun barbaachisaadha',
  ),
  'Configure the Supabase project and run supabase_schema.sql before registering an institution.':
      (
        'ተቋም ከመመዝገብዎ በፊት Supabase ያዋቅሩና supabase_schema.sql ያስኬዱ።',
        'Dhaabbata osoo hin galmeessin dura Supabase qindeessaa; supabase_schema.sql immoo hojjachiisaa.',
      ),
  'Registration submitted': ('ምዝገባው ተልኳል', 'Galmeen ergameera'),
  'Confirm your email if requested, then sign in to access your dashboard. No administrator approval is required.':
      (
        'ከተጠየቁ ኢሜይልዎን ያረጋግጡ፣ ከዚያ ዳሽቦርዱን ለመጠቀም ይግቡ። የአስተዳዳሪ ፈቃድ አያስፈልግም።',
        'Yoo gaafatamtan imeelii keessan mirkaneessaa; achii booda daashboordii argachuuf seenaa. Eeyyamni bulchaa hin barbaachisu.',
      ),
  'Institution name': ('የተቋም ስም', 'Maqaa dhaabbataa'),
  'Your full name': ('ሙሉ ስምዎ', 'Maqaa guutuu keessan'),
  'Your role or title': ('የስራ ሚናዎ ወይም ማዕረግዎ', 'Gahee ykn maqaa hojii keessan'),
  'Institutional email address': (
    'የተቋም ኢሜይል አድራሻ',
    'Teessoo imeelii dhaabbataa',
  ),
  'Enter your institution, name, and role.': (
    'የተቋምዎን ስም፣ የእርስዎን ስም እና ሚና ያስገቡ።',
    'Maqaa dhaabbataa, maqaa keessanii fi gahee keessan galchaa.',
  ),
  'Submit registration': ('ምዝገባውን ይላኩ', 'Galmee ergaa'),
  'Submitting…': ('በመላክ ላይ…', 'Ergaa jira…'),
  'Use the account registered for your organization.': (
    'ለተቋምዎ የተመዘገበውን መለያ ይጠቀሙ።',
    'Akkaawuntii dhaabbata keessaniif galmaa’e fayyadamaa.',
  ),
  'Institution sign in requires Supabase configuration.': (
    'ወደ ተቋም ለመግባት Supabase ማዋቀር ያስፈልጋል።',
    'Dhaabbata keessa seenuuf Supabase qindeessuun barbaachisaadha.',
  ),
  'No institution registration is linked to this account.': (
    'ከዚህ መለያ ጋር የተገናኘ የተቋም ምዝገባ የለም።',
    'Akkaawuntii kanaan galmeen dhaabbataa walqabate hin jiru.',
  ),
  'Institution access is disabled until Supabase is configured and the registration schema is installed.':
      (
        'Supabase እስኪዋቀርና የምዝገባ ስኪማው እስኪጫን ድረስ የተቋም መግቢያ ተዘግቷል።',
        'Hanga Supabase qindaa’ee fi iskiimaan galmee fe’amutti seensi dhaabbataa cufaadha.',
      ),
  'Institution sign in required': (
    'የተቋም መለያ ይግቡ',
    'Akkaawuntii dhaabbataa seenaa',
  ),
  'Sign in with an institution account to continue.': (
    'ለመቀጠል በተቋም መለያዎ ይግቡ።',
    'Itti fufuuf akkaawuntii dhaabbataatiin seenaa.',
  ),
  'Could not verify institution access': (
    'የተቋም መግቢያን ማረጋገጥ አልተቻለም',
    'Seensa dhaabbataa mirkaneessuun hin danda’amne',
  ),
  'Institution registration not found': (
    'የተቋም ምዝገባ አልተገኘም',
    'Galmeen dhaabbataa hin argamne',
  ),
  'This account has no institution registration and cannot open the institution dashboard.':
      (
        'ይህ መለያ የተቋም ምዝገባ የለውም፤ የተቋሙን ዳሽቦርድ መክፈት አይችልም።',
        'Akkaawuntiin kun galmee dhaabbataa hin qabu; daashboordii dhaabbataa banuu hin danda’u.',
      ),
  'Institution registration was not approved': (
    'የተቋም ምዝገባ አልጸደቀም',
    'Galmeen dhaabbataa hin mirkanoofne',
  ),
  'Contact the review team if you believe this decision was made in error.': (
    'ይህ ውሳኔ በስህተት እንደተሰጠ ካመኑ የግምገማ ቡድኑን ያነጋግሩ።',
    'Murtiin kun dogoggoraan kenname jedhee yoo amantan garee gamaaggamaa quunnamaa.',
  ),
  'Institution registration is pending': (
    'የተቋም ምዝገባ በመጠባበቅ ላይ ነው',
    'Galmeen dhaabbataa eeggachaa jira',
  ),
  'Case information stays private until an administrator approves the application.':
      (
        'አስተዳዳሪ ማመልከቻውን እስኪያጸድቅ ድረስ የጉዳይ መረጃው ሚስጥራዊ ይቆያል።',
        'Hanga bulchaan iyyata mirkaneessutti odeeffannoon dhimmaa iccitii ta’ee hafa.',
      ),
  'Check approval status': ('የማጽደቅ ሁኔታን ያረጋግጡ', 'Haala mirkaneessaa ilaalaa'),
  'Back to user dashboard': (
    'ወደ ተጠቃሚ ዳሽቦርድ ተመለስ',
    'Gara daashboordii fayyadamaatti deebi’aa',
  ),
  'Institution staff': ('የተቋም ሰራተኛ', 'Hojjetaa dhaabbataa'),

  // ----- remaining safety, reporting and dashboard text
  'A simple checklist, kept on this device': (
    'በዚህ መሣሪያ ላይ የሚቀመጥ ቀላል ዝርዝር',
    'Tarree salphaa meeshaa kana irratti kuufamu',
  ),
  'Add up to 5 items: photos, PDFs or a voice note. Each up to 10 MB.': (
    'እስከ 5 ነገሮች ያክሉ፦ ፎቶዎች፣ PDF ፋይሎች ወይም የድምፅ መልዕክት። እያንዳንዱ እስከ 10 MB።',
    'Hanga wantoota 5 dabalaa: suuraa, PDF ykn ergaa sagalee. Tokkoon tokkoon hanga 10 MB.',
  ),
  'An approximate month is enough. You can leave this blank.': (
    'ግምታዊ ወር በቂ ነው። ባዶውን መተው ይችላሉ።',
    'Ji’i tilmaamaa ni gaha. Duwwaa dhiisuu dandeessu.',
  ),
  'Calls only start when you tap. Nothing is dialed automatically.': (
    'ሲነኩ ብቻ ጥሪ ይጀምራል። በራስ-ሰር የሚደወል ነገር የለም።',
    'Yeroo tuqan qofa bilbilli jalqaba. Ofumaan lakkoofsi hin bilbilamu.',
  ),
  'Check this is the right person before continuing.': (
    'ከመቀጠልዎ በፊት ትክክለኛው ሰው መሆኑን ያረጋግጡ።',
    'Itti fufuu keessan dura nama sirrii ta’uu isaa mirkaneessaa.',
  ),
  'Choose the closest category. You do not need to have every detail or be sure how to describe it.':
      (
        'በጣም የሚቀርበውን ምድብ ይምረጡ። ሁሉንም ዝርዝር ማወቅ ወይም እንዴት እንደሚገልጹት እርግጠኛ መሆን አያስፈልግም።',
        'Gosa dhihoo ta’e filadhaa. Bal’ina hunda beekuun ykn akkamitti ibsuu akka qabdan mirkaneeffachuun hin barbaachisu.',
      ),
  'Confidential reports are linked to your account so support staff can follow up. Sign in, or choose Anonymous instead.':
      (
        'Gabaasni iccitii akka hojjettoonni deeggarsaa hordofanitti akkaawuntii keessanitti ni hidhama. Seenaa ykn Maqaa Malee filadhaa.',
        'Gabaasni iccitii hordoffii hojjettoota deeggarsaatiif akkaawuntii keessanitti hidhama. Seenaa ykn Maqaa Malee filadhaa.',
      ),
  'Contact details are added after verification.': (
    'የመገናኛ ዝርዝሮች ከተረጋገጡ በኋላ ይጨመራሉ።',
    'Odeeffannoon quunnamtii erga mirkanaa’ee booda dabalama.',
  ),
  'Delivery stays unconfirmed. SheRise cannot tell whether the message arrived.':
      (
        'Ergaan geessise jechuun hin mirkanoofne። SheRise ergaan ga’uu isaa beekuu hin danda’u።',
        'Ergaan ga’uu isaa hin mirkanoofne. SheRise ergaan ga’uu isaa beekuu hin danda’u.',
      ),
  'Drafts are kept only while the app stays open, because they can contain sensitive details.':
      (
        'ረቂቆች ሚስጥራዊ ዝርዝሮችን ሊይዙ ስለሚችሉ መተግበሪያው ክፍት እስካለ ብቻ ይቀመጣሉ።',
        'Qabiyyeen iccitii waan qabaachuu danda’uuf, wixineewwan appiin banaa hamma jirutti qofa kuufamu.',
      ),
  'I have reviewed the recipient and message and choose to share only these details.':
      (
        'ተቀባዩንና መልዕክቱን ገምግሜአለሁ፤ እነዚህን ዝርዝሮች ብቻ ለማጋራት መርጫለሁ።',
        'Nama ergaa fudhatuu fi ergaa gamaaggameera; bal’ina kana qofa qoodachuuf filadheera.',
      ),
  'I understand how my information is used and who can see it.': (
    'መረጃዬ እንዴት እንደሚጠቀምበትና ማን ሊያየው እንደሚችል ተረድቻለሁ።',
    'Odeeffannoon koo akkamitti akka fayyaduu fi eenyu arguu akka danda’u hubadheera.',
  ),
  'I understand who may review this report and the limits above. I consent to submit the information I chose to share.':
      (
        'ይህን ሪፖርት ማን ሊመለከተው እንደሚችልና ከላይ ያሉትን ገደቦች ተረድቻለሁ። ለማጋራት የመረጥኩትን መረጃ ለማስገባት እስማማለሁ።',
        'Eenyutu gabaasa kana ilaalu akka danda’u fi daangaawwan armaan gadii hubadheera. Odeeffannoo qoodachuuf filadhe galchuuf walii galeera.',
      ),
  'No messages yet. Send a message below to reach the support team.': (
    'እስካሁን መልዕክት የለም። የድጋፍ ቡድኑን ለማግኘት ከታች መልዕክት ይላኩ።',
    'Ammaaf ergaan hin jiru. Garee deeggarsaa quunnamuuf armaan gadiin ergaa ergaa.',
  ),
  'No name, email, phone or account is needed. Evidence and technical information may still reveal identity; anonymity cannot be guaranteed.':
      (
        'ስም፣ ኢሜይል፣ ስልክ ወይም መለያ አያስፈልግም። ማስረጃና የቴክኒክ መረጃ ማንነትን ሊያሳዩ ይችላሉ፤ ሙሉ ማንነት መደበቅ ዋስትና አይቻልም።',
        'Maqaan, imeeliin, bilbilli ykn akkaawuntiin hin barbaachisu. Ragaa fi odeeffannoon teeknikaa eenyummaa mul’isuu danda’u; maqaa dhoksuun hin mirkaneeffamu.',
      ),
  'No trusted contact yet.': (
    'እስካሁን የታመነ ሰው የለም።',
    'Ammaaf nama amanamaan hin jiru.',
  ),
  'No verified emergency number is configured yet.': (
    'እስካሁን የተረጋገጠ የአደጋ ጊዜ ቁጥር አልተዋቀረም።',
    'Ammaaf lakkoofsi yeroo balaa mirkanaa’e hin qindaa’in.',
  ),
  'Not now': ('አሁን አይደለም', 'Amma miti'),
  'Only include what feels safe to share. Names, precise addresses and identifying details are not required.':
      (
        'ለማጋራት ደህንነቱ የተጠበቀ የሚመስልዎትን ብቻ ያካትቱ። ስሞች፣ ትክክለኛ አድራሻዎችና ማንነትን የሚለዩ ዝርዝሮች አያስፈልጉም።',
        'Kan qooduun nageenya qabu qofa dabalaa. Maqaan, teessoon sirrii fi odeeffannoon eenyummaa ibsu hin barbaachisu.',
      ),
  'Removing a case only deletes the saved code on this device. It does not delete the report.':
      (
        'ጉዳይን ማስወገድ በዚህ መሣሪያ ላይ የተቀመጠውን ኮድ ብቻ ይሰርዛል። ሪፖርቱን አይሰርዝም።',
        'Dhimma balleessuun koodii meeshaa kana irratti kuufame qofa haqa; gabaasa hin haqu.',
      ),
  'Save this code somewhere only you can reach. It cannot be recovered. It is the only way to follow this report if you chose Anonymous.':
      (
        'ይህን ኮድ እርስዎ ብቻ በሚያገኙት ቦታ ያስቀምጡ። መልሶ ማግኘት አይቻልም። ማንነት ሳይገለጽ ከመረጡ ይህን ሪፖርት ለመከታተል ብቸኛው መንገድ ነው።',
        'Koodii kana bakka ati qofa argachuu dandeessu kaa’i. Deebisanii argachuun hin danda’amu. Maqaa Malee yoo filatte gabaasa kana hordofuuf karaa tokkicha.',
      ),
  'Sign in for a confidential report': (
    'ሚስጥራዊ ሪፖርት ለማቅረብ ይግቡ',
    'Gabaasa iccitii dhiyeessuuf seenaa',
  ),
  'Sign in for private case access, saved opportunities and your trusted contact.':
      (
        'Gara galmee dhimmaa dhuunfaa, carraawwan kuufaman fi nama amanamaatti seenuuf galmaa’aa.',
        'Seensa dhuunfaa dhimmaa, carraa kuufame fi nama amanamaa argachuuf seenaa.',
      ),
  'This is a sample listing for demonstration.': (
    'ይህ ለማሳያ የተዘጋጀ የምሳሌ ዝርዝር ነው።',
    'Kun tarree fakkeenyaa agarsiisaaf qophaa’edha.',
  ),
  'This removes saved case codes, your trusted contact, your safety plan and language choice from this device. It does not delete reports already submitted.':
      (
        'ይህ በዚህ መሣሪያ ላይ የተቀመጡ የጉዳይ ኮዶችን፣ የታመነ ሰውን፣ የደህንነት እቅድንና የቋንቋ ምርጫን ያስወግዳል። የተላኩ ሪፖርቶችን አይሰርዝም።',
        'Kun koodii dhimmaa, nama amanamaa, karoora nageenyaa fi filannoo afaanii meeshaa kana irraa haqa. Gabaasa ergame hin haqu.',
      ),
  'Your report is linked to your account so authorized support staff can follow up, within the stated limits.':
      (
        'የተጠቀሱትን ገደቦች በመጠበቅ የድጋፍ ሰራተኞች እንዲከታተሉት ሪፖርትዎ ከመለያዎ ጋር ይገናኛል።',
        'Hojjettoonni deeggarsaa daangaa ibsame keessatti akka hordofaniif gabaasni keessan akkaawuntii keessanitti hidhama.',
      ),
  'Intake & Case Analytics': (
    'የቅበላ እና የጉዳይ ትንታኔ',
    'Xiinxala fudhannaa fi dhimmaa',
  ),
  'Reports by Category': ('ሪፖርቶች በምድብ', 'Gabaasota gosa isaaniitiin'),
  'Total Reports': ('ጠቅላላ ሪፖርቶች', 'Gabaasota waliigalaa'),
  'Urgent Flags': ('አስቸኳይ ምልክቶች', 'Mallattoolee ariifachiisoo'),
  'With Evidence': ('ማስረጃ ያላቸው', 'Ragaa kan qaban'),
  'Copied': ('ተቀድቷል', 'Garagalfameera'),
  'minutes ago': ('ደቂቃዎች በፊት', 'daqiiqaa dura'),
  'hours ago': ('ሰዓታት በፊት', 'sa’aatii dura'),
  'days ago': ('ቀናት በፊት', 'guyyaa dura'),
  'Intake, Case Review & Workflows': (
    'ቅበላ፣ የጉዳይ ግምገማ እና የስራ ሂደቶች',
    'Fudhannaa, gamaaggama dhimmaa fi adeemsa hojii',
  ),
  'No reports match your filters': (
    'ከማጣሪያዎቹ ጋር የሚዛመድ ሪፖርት የለም',
    'Gabaasni filannoo keessan waliin walsimu hin jiru',
  ),
  'Try clearing your search query or selecting a different status filter.': (
    'የፍለጋ ጽሑፉን ማጥፋት ወይም ሌላ የሁኔታ ማጣሪያ መምረጥ ይሞክሩ።',
    'Barreeffama barbaacha haquu ykn filannoo haala biraa filachuu yaalaa.',
  ),
  'Update Case Status': ('የጉዳይ ሁኔታን አዘምን', 'Haala dhimmaa haaromsi'),
  'Select New Workflow Status:': (
    'አዲስ የስራ ሂደት ሁኔታ ይምረጡ፦',
    'Haala adeemsa hojii haaraa filadhaa:',
  ),
  'Received / Intake': ('ተቀብሏል / ቅበላ', 'Fudhatame / Fudhannaa'),
  'Under Active Review': ('በግምገማ ላይ', 'Gamaaggama keessa jira'),
  'Referred to Partner': ('ወደ አጋር ተላክ', 'Gara michuutti ergame'),
  'Resolved / Action Taken': (
    'ተፈትቷል / እርምጃ ተወስዷል',
    'Furame / Tarkaanfiin fudhatame',
  ),
  'Closed': ('ተዘግቷል', 'Cufame'),
  'Received': ('ተቀብሏል', 'Fudhatame'),
  'Under review': ('በግምገማ ላይ', 'Gamaaggama keessa jira'),
  'Urgent': ('አስቸኳይ', 'Ariifachiisaa'),
  'High': ('ከፍተኛ', 'Ol’aanaa'),
  'Medium': ('መካከለኛ', 'Giddu-galeessa'),
  'Low': ('ዝቅተኛ', 'Gad-aanaa'),
  'Internal Staff Audit Note:': (
    'የሰራተኛ ውስጣዊ የኦዲት ማስታወሻ፦',
    'Yaadannoo odiitii keessaa hojjettootaa:',
  ),
  'Send Update Message to Reporter (Optional):': (
    'ለሪፖርት አቅራቢው የዝማኔ መልዕክት ይላኩ (አማራጭ)፦',
    'Ergaa haaromsaa gabaasaa dhiyeesseef ergaa (filannoo):',
  ),
  'Save Status': ('ሁኔታን አስቀምጥ', 'Haala olkaa’i'),
  'Assign Case Officer': ('የጉዳይ ባለሙያ መድብ', 'Ogeessa dhimmaa ramadi'),
  'Select Designated Reviewer:': (
    'የተመደበውን ገምጋሚ ይምረጡ፦',
    'Gamaaggamaa ramadame filadhaa:',
  ),
  'Assign Officer': ('ባለሙያ መድብ', 'Ogeessa ramadi'),
  'Set Case Urgency / Priority': (
    'የጉዳይ አስቸኳይነት / ቅድሚያ አዘጋጅ',
    'Ariifachiisummaa / dursa dhimmaa qindeessi',
  ),
  'URGENT (Immediate Danger / Safety Risk)': (
    'አስቸኳይ (አፋጣኝ አደጋ / የደህንነት ስጋት)',
    'ARIIFACHIISAA (Balaa battalaa / sodaa nageenyaa)',
  ),
  'HIGH (Retaliation Threat / Severe Harassment)': (
    'ከፍተኛ (የበቀል ዛቻ / ከባድ ትንኮሳ)',
    'OL’AANAA (Soda haaloo / rakkisuu cimaa)',
  ),
  'MEDIUM (General Concern / Policy Breach)': (
    'መካከለኛ (አጠቃላይ ስጋት / የፖሊሲ ጥሰት)',
    'GIDDU-GALEESSA (Yaaddoo waliigalaa / seera cabse)',
  ),
  'LOW (Informational / Inquiry)': (
    'ዝቅተኛ (መረጃ / ጥያቄ)',
    'GAD-AANAA (Odeeffannoo / gaaffii)',
  ),
  'Save Priority': ('ቅድሚያን አስቀምጥ', 'Dursa olkaa’i'),
  'Refer Case to Partner': ('ጉዳዩን ወደ አጋር ላክ', 'Dhimma michuutti dabarsi'),
  'Select Partner Organization:': (
    'የአጋር ድርጅት ይምረጡ፦',
    'Dhaabbata michuu filadhaa:',
  ),
  'Referral Notes & Specific Instructions:': (
    'የሪፈራል ማስታወሻዎች እና ልዩ መመሪያዎች፦',
    'Yaadannoo dabarsuu fi qajeelfama addaa:',
  ),
  'Submit Referral': ('ሪፈራሉን ላክ', 'Dabarsa ergi'),
  'Resolve & Conclude Case': ('ጉዳዩን ፍታ እና ዝጋ', 'Dhimma furiitii xumuri'),
  'Outcome Classification:': ('የውጤት ምደባ፦', 'Ramaddii bu’aa:'),
  'Resolution Summary:': ('የመፍትሄ ማጠቃለያ፦', 'Cuunfaa furmaataa:'),
  'Specific Actions Enacted:': (
    'የተወሰዱ ልዩ እርምጃዎች፦',
    'Tarkaanfiiwwan addaa fudhataman:',
  ),
  'Confirm Resolution': ('መፍትሄውን አረጋግጥ', 'Furmaata mirkaneessi'),
  'Case Not Found': ('ጉዳዩ አልተገኘም', 'Dhimmi hin argamne'),
  'Case Officer Controls:': (
    'የጉዳይ ባለሙያ መቆጣጠሪያዎች፦',
    'To’annaawwan ogeessa dhimmaa:',
  ),
  'Update Status': ('ሁኔታን አዘምን', 'Haala haaromsi'),
  'Set Urgency': ('አስቸኳይነትን አዘጋጅ', 'Ariifachiisummaa qindeessi'),
  'Refer to Partner': ('ወደ አጋር ላክ', 'Michuutti dabarsi'),
  'Resolve Case': ('ጉዳዩን ፍታ', 'Dhimma furi'),
  'Confidentiality:': ('ሚስጥራዊነት፦', 'Iccitii:'),
  'Incident Statement:': ('የክስተቱ መግለጫ፦', 'Ibsa taatee:'),
  'No physical files or voice recordings attached.': (
    'ምንም አካላዊ ፋይል ወይም የድምፅ ቅጂ አልተያያዘም።',
    'Faayilli ykn waraabbiin sagalee hin qabsiifamne.',
  ),
  'No messages sent yet.': (
    'እስካሁን መልዕክት አልተላከም።',
    'Ammaaf ergaan hin ergamne.',
  ),
  'Internal Reviewer Notes - Never visible to reporter': (
    'የውስጥ ገምጋሚ ማስታወሻዎች - ለሪፖርት አቅራቢው ፈጽሞ አይታዩም',
    'Yaadannoo gamaaggamaa keessaa - gabaasaa dhiyeesseef hin mul’atu',
  ),
  'No internal assessment notes recorded.': (
    'ምንም የውስጥ ግምገማ ማስታወሻ አልተመዘገበም።',
    'Yaadannoon madaallii keessaa hin galmoofne.',
  ),
  'Add Note': ('ማስታወሻ ጨምር', 'Yaadannoo dabali'),
  'Delete Report Record?': ('የሪፖርት መዝገቡን ይሰርዙ?', 'Galmee gabaasaa haquu?'),
  'Scrub record from intake board': (
    'መዝገቡን ከቅበላ ቦርድ አስወግድ',
    'Galmee boordii fudhannaa irraa haqi',
  ),
  'Category:': ('ምድብ፦', 'Gosa:'),
  'Contact': ('መገናኛ', 'Quunnamtii'),
  'Phone': ('ስልክ', 'Bilbila'),
  'Summary': ('ማጠቃለያ', 'Cuunfaa'),
  'Action Taken': ('የተወሰደ እርምጃ', 'Tarkaanfii fudhatame'),
  'Closed by': ('የዘጋው', 'Kan cufe'),
  'Referred on': ('የተላከበት ቀን', 'Guyyaa itti dabarfame'),
  'Incident Date': ('የክስተቱ ቀን', 'Guyyaa taatee'),
  'Last update': ('የመጨረሻ ዝማኔ', 'Haaromsa dhumaa'),
  'Last checked': ('የመጨረሻ ማረጋገጫ', 'Mirkaneessa dhumaa'),
  'from public sources.': ('ከህዝብ ምንጮች።', 'Madda uummataa irraa.'),
  'Masked contact': ('የተደበቀ የመገናኛ መረጃ', 'Quunnamtii dhokfame'),
  'Delivered Reports': ('የደረሱ ሪፖርቶች', 'Gabaasota ga’an'),
  'files': ('ፋይሎች', 'Faayilota'),
  'Permanently remove report': (
    'ሪፖርቱን በቋሚነት አስወግድ',
    'Gabaasa dhaabbataadhaan haqi',
  ),
  'from the institution board? This is for testing only.': (
    'ከተቋሙ ቦርድ? ይህ ለሙከራ ብቻ ነው።',
    'boordii dhaabbata irraa? Kun qormaataaf qofa.',
  ),
  'No report found with code': (
    'በዚህ ኮድ ሪፖርት አልተገኘም',
    'Koodii kanaan gabaasni hin argamne',
  ),
  'Priority:': ('ቅድሚያ፦', 'Dursa:'),
  'Unassigned': ('አልተመደበም', 'Hin ramadamne'),
  'Voice Note': ('የድምፅ መልዕክት', 'Ergaa sagalee'),
  'Notes': ('ማስታወሻዎች', 'Yaadannoowwan'),
  'Shopping list': ('የግዢ ዝርዝር', 'Tarree bittaa'),
  'Bread, rice, onions, tea': (
    'ዳቦ፣ ሩዝ፣ ሽንኩርት፣ ሻይ',
    'Daabboo, ruuzii, qullubbii, shaayii',
  ),
  'Study plan': ('የጥናት እቅድ', 'Karoora barnootaa'),
  'Read chapter 4 on Thursday': (
    'ሐሙስ ምዕራፍ 4 አንብብ',
    'Kamisa boqonnaa 4 dubbisi',
  ),
  'Ideas': ('ሀሳቦች', 'Yaadawwan'),
  'Plant herbs on the balcony': (
    'በረንዳ ላይ ቅጠላ ቅጠል ተክል',
    'Balakoonii irratti biqiltuu dhaabi',
  ),
  'SheRise': ('SheRise', 'SheRise'),
  'SheRise 0.1 · Safe. Respected. Equal.': (
    'SheRise 0.1 · ደህንነት። ክብር። እኩልነት።',
    'SheRise 0.1 · Nageenya. Kabaja. Walqixxummaa.',
  ),
  'Anonymous reports are still supported': (
    'ማንነት ሳይገለጽ ሪፖርት ማድረግ አሁንም ይቻላል',
    'Gabaasa maqaa malee dhiyeessuun ni danda’ama',
  ),
  'A city, campus or GPS location. You can also leave this blank.': (
    'ከተማ፣ ግቢ ወይም GPS አካባቢ ያስገቡ። ይህን ባዶ መተውም ይችላሉ።',
    'Magaalaa, kaampasii ykn bakka GPS galchaa. Duwwaa dhiisuu dandeessu.',
  ),
  'A general checklist to think through. Tick what is already in place.': (
    'ለማሰብ የሚረዳ አጠቃላይ ዝርዝር። አስቀድሞ ያዘጋጁትን ምልክት ያድርጉ።',
    'Tarree waliigalaa irratti yaaduuf. Waan qophaa’e mallatteessaa.',
  ),
  'Action needed': ('እርምጃ ያስፈልጋል', 'Tarkaanfiin barbaachisa'),
  'Add a trusted contact first': (
    'መጀመሪያ የምታምኑትን ሰው ያክሉ',
    'Jalqaba nama amanamtan dabalaa',
  ),
  'Administrative protective sanctions enacted; monitoring active.': (
    'የአስተዳደር መከላከያ እርምጃዎች ተወስደዋል፤ ክትትል ቀጥሏል።',
    'Tarkaanfiin eegumsaa bulchiinsaa fudhatameera; hordoffiin itti fufeera.',
  ),
  'All reports': ('ሁሉም ሪፖርቶች', 'Gabaasota hunda'),
  'Anyone with a code can view that case. Codes saved here stay on this device. Remove a case if the device is shared.':
      (
        'ኮዱ ያለው ሰው ጉዳዩን ማየት ይችላል። እዚህ የተቀመጡ ኮዶች በዚህ መሣሪያ ላይ ይቆያሉ። መሣሪያውን ከሌሎች ጋር ከተጋሩ ጉዳዩን ያስወግዱ።',
        'Namni koodii qabu dhimma sana ilaaluu danda’a. Koodiin as kuufame meeshaa kana irratti hafa. Meeshaa yoo waliin fayyadamtan dhimma sana balleessaa.',
      ),
  'At least 8 characters.': ('ቢያንስ 8 ፊደላት።', 'Yoo xiqqaate qubee 8.'),
  'Enter your email and we will send a link to reset your password.': (
    'ኢሜይልዎን ያስገቡ፤ የይለፍ ቃል ማስጀመሪያ ማገናኛ እንልክልዎታለን።',
    'Imeelii keessan galchaa; jecha darbii deebisanii qindeessuuf liinkii isiniif ergina.',
  ),
  'Case referred for specialized external intervention.': (
    'ጉዳዩ ለልዩ ውጫዊ ድጋፍ ተላልፏል።',
    'Dhimmi gargaarsa addaa alaa argachuuf dabarfameera.',
  ),
  'Choose what to share with your trusted contact. Nothing is sent until you press send in your messaging app.':
      (
        'ከምታምኑት ሰው ጋር ምን ማጋራት እንደሚፈልጉ ይምረጡ። በመልዕክት መተግበሪያዎ ውስጥ ላክ እስኪሉ ድረስ ምንም አይላክም።',
        'Nama amanamaa keessan waliin maal qoodachuu akka barbaaddan filadhaa. Appii ergaa keessan keessatti ergi jechuu keessan dura homtuu hin ergamu.',
      ),
  'Configure Supabase before institution accounts can sign in.': (
    'የተቋም መለያዎች ከመግባታቸው በፊት Supabase ያዋቅሩ።',
    'Akkaawuntiin dhaabbataa osoo hin seenin dura Supabase qindeessaa.',
  ),
  'Configure Supabase to create or access an account.': (
    'መለያ ለመፍጠር ወይም ለመጠቀም Supabase ያዋቅሩ።',
    'Akkaawuntii uumuuf ykn fayyadamuuf Supabase qindeessaa.',
  ),
  'Could not load opportunities': (
    'እድሎችን መጫን አልተቻለም',
    'Carraawwan fe’uun hin danda’amne',
  ),
  'Could not load services': (
    'አገልግሎቶችን መጫን አልተቻለም',
    'Tajaajiloota fe’uun hin danda’amne',
  ),
  'Could not load this case': (
    'ይህን ጉዳይ መጫን አልተቻለም',
    'Dhimma kana fe’uun hin danda’amne',
  ),
  'Create private access. We only ask for what is needed to manage your account.':
      (
        'የግል መግቢያ ይፍጠሩ። መለያዎን ለማስተዳደር የሚያስፈልገውን ብቻ እንጠይቃለን።',
        'Seensa dhuunfaa uumaa. Akkaawuntii keessan bulchuuf waan barbaachisu qofa gaafanna.',
      ),
  'Delete data on this device?': (
    'በዚህ መሣሪያ ላይ ያለውን መረጃ ይሰርዙ?',
    'Daataa meeshaa kana irra jiru haquu?',
  ),
  'Delivered': ('ደርሷል', 'Ga’eera'),
  'Describe the concern in your own words…': (
    'ያሳሰበዎትን በራስዎ ቃላት ይግለጹ…',
    'Yaaddoo keessan jecha mataa keessaniitiin ibsaa…',
  ),
  'Details, metadata or your account may identify you. Confidentiality can be limited by legal duties or immediate safety concerns.':
      (
        'ዝርዝሮች፣ ሜታዳታ ወይም መለያዎ ማንነትዎን ሊያሳዩ ይችላሉ። በህጋዊ ግዴታዎች ወይም አፋጣኝ የደህንነት ስጋቶች ምክንያት ሚስጥራዊነት ሊገደብ ይችላል።',
        'Bal’inni, metadata ykn akkaawuntiin keessan eenyummaa keessan mul’isuu danda’u. Sababa dirqama seeraa ykn yaaddoo nageenyaa battalaatiin iccitiin daangeffamuu danda’a.',
      ),
  'Do not rely on SheRise in an emergency. Use a known local emergency resource or reach someone you trust another way.':
      (
        'በአደጋ ጊዜ በSheRise ላይ ብቻ አይመኑ። የሚያውቁትን የአካባቢ የአደጋ ጊዜ አገልግሎት ይጠቀሙ ወይም የሚያምኑትን ሰው በሌላ መንገድ ያግኙ።',
        'Yeroo balaa SheRise irratti hin hirkatiinaa. Tajaajila balaa naannoo beektan fayyadamaa ykn nama amanamtan karaa biraatiin quunnamaa.',
      ),
  'Evidence can reveal your identity': (
    'ማስረጃ ማንነትዎን ሊያሳይ ይችላል',
    'Ragaan eenyummaa keessan mul’isuu danda’a',
  ),
  'Export Intake Summary (CSV/Audit)': (
    'የቅበላ ማጠቃለያ ወደ CSV/ኦዲት ላክ',
    'Cuunfaa fudhannaa gara CSV/Odiitii ergi',
  ),
  'Fair and transparent': ('ፍትሃዊ እና ግልጽ', 'Haq-qabeessa fi iftoomina qabu'),
  'If you may be in danger now, open the Safety Center. Reporting here does not call emergency services.':
      (
        'አሁን አደጋ ላይ ሊሆኑ ከቻሉ የደህንነት ማዕከሉን ይክፈቱ። እዚህ ሪፖርት ማድረግ የአደጋ ጊዜ አገልግሎትን አይጠራም።',
        'Amma balaa keessa ta’uu yoo dandeessan Giddugala Nageenyaa bani. Asitti gabaasuun tajaajila balaa hin waamu.',
      ),
  'Investigating': ('በምርመራ ላይ', 'Qorannoo keessa jira'),
  'Investigation concluded with substantiated evidence.': (
    'ምርመራው በተረጋገጠ ማስረጃ ተጠናቋል።',
    'Qorannoon ragaa mirkanaa’een xumurameera.',
  ),
  'Keep your codes private': (
    'ኮዶችዎን ሚስጥር ያድርጉ',
    'Koodii keessan iccitii godhaa',
  ),
  'Linked to your account so authorized support staff can follow up. It is not published or shown in notification previews.':
      (
        'የተፈቀደላቸው የድጋፍ ሰራተኞች እንዲከታተሉት ከመለያዎ ጋር ይገናኛል። አይታተምም ወይም በማሳወቂያ ቅድመ እይታ አይታይም።',
        'Hojjettoonni deeggarsa hayyama qaban akka hordofaniif akkaawuntii keessanitti hidhama. Hin maxxanfamu ykn dursanii beeksisa irratti hin mul’atu.',
      ),
  'Listings are checked before they appear, but please confirm details directly before relying on them.':
      (
        'ዝርዝሮች ከመታየታቸው በፊት ይገመገማሉ፤ ነገር ግን ከመተማመንዎ በፊት ዝርዝሮቹን በቀጥታ ያረጋግጡ።',
        'Tarreewwan osoo hin mul’atin ni ilaalamu; garuu osoo hin amanin dura bal’ina isaanii kallattiin mirkaneessaa.',
      ),
  'Listings should state who can apply and how. A real opportunity should never ask you to pay to apply.':
      (
        'ዝርዝሮች ማን ማመልከት እንደሚችልና እንዴት እንደሚያመለክት መግለጽ አለባቸው። እውነተኛ እድል ለማመልከት ክፍያ አይጠይቅም።',
        'Tarreen eenyutu fi akkamitti akka iyyatu ibsuu qaba. Carraan dhugaan iyyachuuf kaffaltii hin gaafatu.',
      ),
  'Location is not included': ('አካባቢ አልተካተተም', 'Iddoon hin dabalamin'),
  'Lost a report access code?': (
    'የሪፖርት መግቢያ ኮድ ጠፋ?',
    'Koodii seensaa gabaasaa dhabdan?',
  ),
  'New Inbox': ('አዲስ የገቢ መልዕክቶች', 'Sanduuqa ergaa haaraa'),
  'No name, email, phone or account is required. Keep the reference code shown after you submit. Do not include contact details if you want to avoid identifying yourself. Anonymity is not absolute.':
      (
        'ስም፣ ኢሜይል፣ ስልክ ወይም መለያ አያስፈልግም። ካስገቡ በኋላ የሚታየውን የማጣቀሻ ኮድ ያስቀምጡ። ማንነትዎ እንዳይታወቅ ከፈለጉ የመገናኛ ዝርዝሮችን አያካትቱ። ማንነት ሙሉ በሙሉ የተደበቀ አይደለም።',
        'Maqaan, imeeliin, bilbilli ykn akkaawuntiin hin barbaachisu. Erga galchitanii booda koodii wabii mul’atu kaa’aa. Eenyummaan keessan akka hin beekamne yoo barbaaddan odeeffannoo quunnamtii hin dabaliinaa. Maqaa dhoksuun guutuu miti.',
      ),
  'No new notifications': ('አዲስ ማሳወቂያ የለም', 'Beeksisni haaraan hin jiru'),
  'No receipt to show': ('የሚታይ ደረሰኝ የለም', 'Rasiidni agarsiifamu hin jiru'),
  'No listings yet': ('እስካሁን ዝርዝር የለም', 'Ammaaf tarreen hin jiru'),
  'Nothing here yet': ('እስካሁን እዚህ ምንም የለም', 'Ammaaf asitti homtuu hin jiru'),
  'On a shared device, lock SheRise before you step away. Keep private access codes somewhere only you can reach.':
      (
        'በጋራ የሚጠቀሙበት መሣሪያ ላይ ከመራቅዎ በፊት SheRiseን ይቆልፉ። የግል መግቢያ ኮዶችን እርስዎ ብቻ በሚያገኙበት ቦታ ያስቀምጡ።',
        'Meeshaa waliin fayyadamtan irratti osoo hin fagaatin SheRise cufaa. Koodii dhuunfaa bakka isin qofti argitan kaa’aa.',
      ),
  'Only this message is shared. No location is read, attached or sent.': (
    'ይህ መልዕክት ብቻ ይጋራል። አካባቢ አይነበብም፣ አይያያዝም ወይም አይላክም።',
    'Ergaa kana qofa qoodama. Iddoon hin dubbifamu, hin qabsiifamu ykn hin ergamu.',
  ),
  'Opportunities to grow, and knowledge to stay safe and strong.': (
    'ለማደግ እድሎች፣ ደህንነትና ጥንካሬን ለመጠበቅ እውቀት።',
    'Carraa guddinaa fi nageenyaafi cimaa ta’uuf beekumsa.',
  ),
  'Photos can include hidden details like location and device. A voice can be recognized. Only attach what feels safe. Files are renamed before upload.':
      (
        'ፎቶዎች እንደ አካባቢና መሣሪያ ያሉ የተደበቁ ዝርዝሮችን ሊይዙ ይችላሉ። ድምፅ ሊታወቅ ይችላል። ደህንነቱ የተጠበቀ የሚመስልዎትን ብቻ ያያይዙ። ፋይሎች ከመጫናቸው በፊት ስማቸው ይቀየራል።',
        'Suuraan bal’ina dhokataa kan akka iddoo fi meeshaa qabaachuu danda’a. Sagaleen beekamuu danda’a. Kan nageenya qabu qofa qabsiisaa. Faayilli osoo hin fe’amin dura maqaan isaa jijjiirama.',
      ),
  'Please contact me when you can. I would like support.': (
    'ከቻሉ ያነጋግሩኝ። ድጋፍ እፈልጋለሁ።',
    'Yeroo dandeessan na quunnamaa. Deeggarsa nan barbaada.',
  ),
  'Messages sent here appear immediately on the reporter\'s private case tracker.':
      (
        'እዚህ የሚላኩ መልዕክቶች በሪፖርት አቅራቢው የግል ጉዳይ መከታተያ ላይ ወዲያውኑ ይታያሉ።',
        'Ergaan asitti ergamu battalumatti hordoffii dhimma dhuunfaa gabaasaa irratti mul’ata.',
      ),
  'Private updates for reports you saved on this device. Reports are never shown publicly.':
      (
        'በዚህ መሣሪያ ላይ ላስቀመጧቸው ሪፖርቶች የግል ዝማኔዎች። ሪፖርቶች በይፋ አይታዩም።',
        'Haaromsi dhuunfaa gabaasa meeshaa kana irratti kuufaniif. Gabaasni ummataaf hin mul’atu.',
      ),
  'Protected': ('የተጠበቀ', 'Eegame'),
  'Receiving a report does not guarantee review time, a response or emergency dispatch. SheRise does not automatically contact emergency services.':
      (
        'ሪፖርት መቀበል የግምገማ ጊዜ፣ ምላሽ ወይም የአደጋ ጊዜ እርዳታ ዋስትና አይሰጥም። SheRise የአደጋ ጊዜ አገልግሎቶችን በራስ-ሰር አያነጋግርም።',
        'Gabaasa fudhachuun yeroo gamaaggamaa, deebii ykn gargaarsa balaa mirkaneessu miti. SheRise tajaajila balaa ofumaan hin quunnamu.',
      ),
  'Recording…': ('በመቅዳት ላይ…', 'Waraabaa jira…'),
  'Referred': ('ተላልፏል', 'Dabarfameera'),
  'Report codes cannot be recovered. They are never stored in readable form. If you lost one, you can submit a new report.':
      (
        'የሪፖርት ኮዶች መመለስ አይቻልም። በሚነበብ መልኩ አይቀመጡም። ኮድ ከጠፋብዎ አዲስ ሪፖርት ማስገባት ይችላሉ።',
        'Koodiin gabaasaa deebifamuu hin danda’u. Bifa dubbifamuun hin kuufamu. Yoo dhabdan gabaasa haaraa galchuu dandeessu.',
      ),
  'Reset filters': ('ማጣሪያዎችን ዳግም አስጀምር', 'Calaltuu deebisanii qindeessi'),
  'Resolved': ('ተፈትቷል', 'Furameera'),
  'Review message & sharing': (
    'መልዕክቱንና ማጋራቱን ይገምግሙ',
    'Ergaa fi qoodinsa gamaaggamaa',
  ),
  'Reviewed content is coming': (
    'የተገመገመ ይዘት በቅርቡ ይመጣል',
    'Qabiyyeen gamaaggamame ni dhufa',
  ),
  'Send a private message to case review officer': (
    'ለጉዳዩ ገምጋሚ የግል መልዕክት ላክ',
    'Gamaaggamaa dhimmaatiif ergaa dhuunfaa ergaa',
  ),
  'SheRise does not run these services': (
    'SheRise እነዚህን አገልግሎቶች አያስተዳድርም',
    'SheRise tajaajiloota kana hin bulchu',
  ),
  'Some attachments were not uploaded': (
    'አንዳንድ አባሪዎች አልተጫኑም',
    'Qabsiisawwan tokko tokko hin fe’amne',
  ),
  'Speak when you are ready. Recording stops after 3 minutes.': (
    'ዝግጁ ሲሆኑ ይናገሩ። ቅጂው ከ3 ደቂቃ በኋላ ይቆማል።',
    'Yeroo qophooftan dubbadhaa. Waraabbiin daqiiqaa 3 booda dhaabata.',
  ),
  'Stored only on this device.': (
    'በዚህ መሣሪያ ላይ ብቻ ተቀምጧል።',
    'Meeshaa kana irratti qofa kuufameera.',
  ),
  'Tell us what happened, in your own words. You are in control of how much you share.':
      (
        'የተፈጠረውን በራስዎ ቃላት ይንገሩን። ምን ያህል እንደሚያጋሩ እርስዎ ይወስናሉ።',
        'Waan ta’e jecha keessaniin nutti himaa. Hammam qoodachuu akka barbaaddan isin murteessitu.',
      ),
  'This guidance is general. It will be reviewed by subject-matter experts and localized before launch.':
      (
        'ይህ አጠቃላይ መመሪያ ነው። ከመጀመሩ በፊት በዘርፉ ባለሙያዎች ይገመገማል እና ወደ አካባቢያዊ ቋንቋዎች ይተረጎማል።',
        'Qajeelfamni kun waliigala. Osoo hin jalqabin ogeessota dameetiin ni gamaaggama, afaan naannoo keessaniittis ni hiikama.',
      ),
  'This is general guidance': (
    'ይህ አጠቃላይ መመሪያ ነው',
    'Kun qajeelfama waliigalaati',
  ),
  'Under Review': ('በግምገማ ላይ', 'Gamaaggama keessa jira'),
  'Use an email only you can access.': (
    'እርስዎ ብቻ ሊያገኙት የሚችሉትን ኢሜይል ይጠቀሙ።',
    'Imeelii isin qofti argachuu dandeessan fayyadamaa.',
  ),
  'What should we call you?': ('ምን ብለን እንጥራዎ?', 'Maal jennee isin waamnu?'),
  'With partners': ('ከአጋሮች ጋር', 'Michoota waliin'),
  'You decide whether to attach GPS or leave the location blank.': (
    'GPS ማያያዝ ወይም አካባቢውን ባዶ መተው እርስዎ ይወስናሉ።',
    'GPS qabsiisuu ykn iddoo duwwaa dhiisuu isin murteessitu.',
  ),
  'Your report can remain anonymous. Your account is only used for private access and saved features.':
      (
        'ሪፖርትዎ ማንነት ሳይገለጽ ሊቆይ ይችላል። መለያዎ ለግል መግቢያና የተቀመጡ ባህሪያት ብቻ ይጠቀማል።',
        'Gabaasni keessan maqaa malee hafuu danda’a. Akkaawuntiin keessan seensa dhuunfaa fi amaloota kuufamaniif qofa fayyada.',
      ),
  'Your situation is unique. A trained gender-based-violence or counseling service can help you build a plan that fits your safety.':
      (
        'ሁኔታዎ ልዩ ነው። የስርዓተ-ጾታ ጥቃት ወይም የምክር አገልግሎት ባለሙያ ከደህንነትዎ ጋር የሚስማማ እቅድ እንዲያዘጋጁ ሊረዳዎ ይችላል።',
        'Haalli keessan addaa dha. Ogeessi miidhaa saalaa ykn gorsaa karoora nageenya keessaniif ta’u ijaaruuf isin gargaaruu danda’a.',
      ),
  'e.g. Addis Ababa or tap Use GPS Location': (
    'ለምሳሌ አዲስ አበባ፣ ወይም GPS አካባቢ ይጠቀሙ የሚለውን ይንኩ',
    'Fakkeenyaaf Finfinnee, ykn Bakka GPS Fayyadami jedhu tuqaa',
  ),
  '• Contact a trusted person using a safe device.': (
    '• ደህንነቱ የተጠበቀ መሣሪያ በመጠቀም የምታምኑትን ሰው ያነጋግሩ።',
    '• Meeshaa nageenya qabu fayyadamuun nama amanamtan quunnamaa.',
  ),
  '• If a message fails, use another way to reach help.': (
    '• መልዕክት ካልደረሰ፣ እርዳታ ለማግኘት ሌላ መንገድ ይጠቀሙ።',
    '• Ergaan yoo hin geenye, gargaarsa argachuuf karaa biraa fayyadamaa.',
  ),
  '• Move to a public or safer place if possible.': (
    '• ከተቻለ ወደ ህዝብ የሚበዛበት ወይም ደህንነቱ የተጠበቀ ቦታ ይሂዱ።',
    '• Yoo danda’ame gara iddoo uummanni jiru ykn nageenya qabu deebi’aa.',
  ),
  'Account created': ('መለያ ተፈጥሯል', 'Akkaawuntiin uumameera'),
  'Check your email to confirm your account, then sign in to continue.': (
    'መለያዎን ለማረጋገጥ ኢሜይልዎን ይመልከቱ፤ ከዚያ ለመቀጠል ይግቡ።',
    'Akkaawuntii keessan mirkaneessuuf imeelii ilaalaa; itti fufuuf seenaa.',
  ),
  'Continue to sign in': ('ወደ መግቢያ ይቀጥሉ', 'Gara seensaatti itti fufaa'),
  'Use a password of at least 12 characters.': (
    'የይለፍ ቃልዎ ቢያንስ 12 ቁምፊ ይሁን።',
    'Jecha darbii yoo xiqqaate arfii 12 fayyadamaa.',
  ),
  'Mix upper and lower case letters in your password.': (
    'በይለፍ ቃልዎ ትላልቅና ትናንሽ ፊደላትን ያዋህዱ።',
    'Jecha darbii keessatti qubee guddaa fi xiqqaa makaa.',
  ),
  'Add at least one number to your password.': (
    'ቢያንስ አንድ ቁጥር ይጨምሩ።',
    'Lakkoofsa tokko yoo xiqqaate dabaluu.',
  ),
  'Add at least one symbol, like ! or #.': (
    'ቢያንስ አንድ ምልክት ይጨምሩ፣ ለምሳሌ ! ወይም #።',
    'Mallattoo tokko yoo xiqqaate dabaluu, fkn ! ykn #.',
  ),
  'That password is too easy to guess. Choose another.': (
    'ይህ የይለፍ ቃል ለመገመት ቀላል ነው። ሌላ ይምረጡ።',
    'Jechi darbii kun ni salphaadha. Isa biraa filadhu.',
  ),
  'Do not use your name, email or institution in the password.': (
    'ስምዎን፣ ኢሜይልዎን ወይም ተቋምዎን በይለፍ ቃል አይጠቀሙ።',
    'Maqaa, imeelii ykn dhaabbata keessan jecha darbii keessatti hin fayyadamin.',
  ),
  'Show password': ('የይለፍ ቃል አሳይ', 'Jecha darbii agarsiisi'),
  'Hide password': ('የይለፍ ቃል ደብቅ', 'Jecha darbii dhoksi'),
  'Too weak': ('በጣም ደካማ', 'Baay\'ee dadhabaa'),
  'Weak': ('ደካማ', 'Dadhabaa'),
  'Fair': ('መካከለኛ', 'Giddu galeessa'),
  'Good': ('ጥሩ', 'Gaarii'),
  'Strong': ('ጠንካራ', 'Cimaa'),
  'At least 12 characters': ('ቢያንስ 12 ቁምፊ', 'Arfii yoo xiqqaate 12'),
  'Upper and lower case letters': ('ትላልቅና ትናንሽ ፊደላት', 'Qubee guddaa fi xiqqaa'),
  'A number': ('አንድ ቁጥር', 'Lakkoofsa tokko'),
  'A symbol, like ! or #': (
    'አንድ ምልክት፣ ለምሳሌ ! ወይም #',
    'Mallattoo tokko, fkn ! ykn #',
  ),
  'Not a common word or your own details': (
    'የተለመደ ቃል ወይም የራስዎ መረጃ አይደለም',
    'Jecha beekamaa ykn odeeffannoo keessan miti',
  ),
  'Start typing to see suggestions': (
    'ጥቆማዎችን ለማየት መተየብ ይጀምሩ',
    'Yaada agarsiisuuf barreessuu jalqabaa',
  ),
  'Quick information websites': (
    'ፈጣን መረጃ የሚሰጡ ድረ-ገጾች',
    'Marsariitiiwwan odeeffannoo saffisaa',
  ),
  'Looking for more listings? These sites update every day.': (
    'ተጨማሪ ዝርዝር ይፈልጋሉ? እነዚህ ድረ-ገጾች በየቀኑ ይዘምናሉ።',
    'Tarreeffama dabalataa barbaaddu? Marsariitiiwwan kunneen guyyaa guyyaan haaromu.',
  ),
  'Trusted websites to learn more': (
    'ለመማር የታመኑ ድረ-ገጾች',
    'Marsariitiiwwan amanamoo baruuf',
  ),
  'Reliable sources for rights, safety and learning.': (
    'ስለ መብት፣ ደህንነትና ትምህርት ታማኝ ምንጮች።',
    'Madda amanamaa mirgaa, nageenyaa fi barnootaa.',
  ),
  'Leave SheRise?': ('ከSheRise ይውጡ?', 'SheRise irraa ba’uu?'),
  'This opens an outside website in your browser. It may keep a record in your browser history. SheRise is not responsible for its content.':
      (
        'ይህ ውጫዊ ድረ-ገጽ በአሳሽዎ ይከፍታል። በአሳሽዎ ታሪክ ውስጥ ሊመዘገብ ይችላል። SheRise ለይዘቱ ተጠያቂ አይደለም።',
        'Kun marsariitii alaa biraauzara keessan irratti banuu. Seenaa biraauzara keessanii irratti galmaa’uu ni danda’a. SheRise qabiyyee isaaf itti gaafatamaa miti.',
      ),
  'Open website': ('ድረ-ገጹን ክፈት', 'Marsariitii bani'),
  'Could not open the website.': (
    'ድረ-ገጹን መክፈት አልተቻለም።',
    'Marsariitii banuu hin dandeenye.',
  ),
  'Too many emails were sent. Please wait a while and try again.': (
    'ብዙ ኢሜይሎች ተልከዋል። እባክዎ ትንሽ ቆይተው እንደገና ይሞክሩ።',
    'Imeeliin baay’een ergameera. Mee xiqqoo eegaatii irra deebi’ii yaalaa.',
  ),
  'Please confirm your email first. Check your inbox and spam folder.': (
    'እባክዎ መጀመሪያ ኢሜይልዎን ያረጋግጡ። የገቢ እና የspam አቃፊዎን ይመልከቱ።',
    'Maaloo duraan imeelii keessan mirkaneessaa. Inbox fi spam keessan ilaalaa.',
  ),
  'Email or password is incorrect. If you have not registered yet, create an account first.':
      (
        'ኢሜይሉ ወይም የይለፍ ቃሉ ትክክል አይደለም። ገና ካልተመዘገቡ መጀመሪያ መለያ ይፍጠሩ።',
        'Imeeliin ykn jechi darbii dogoggora. Yoo hin galmoofne, duraan akkaawuntii uumaa.',
      ),
  'This email already has an account. Please sign in.': (
    'ይህ ኢሜይል መለያ አለው። እባክዎ ይግቡ።',
    'Imeelii kanaaf akkaawuntiin ni jira. Maaloo seenaa.',
  ),
  'Already have private access? Sign in': (
    'የግል መዳረሻ አለዎት? ይግቡ',
    'Seensa dhuunfaa qabduu? Seenaa',
  ),
  'Institution board access': ('የተቋም ቦርድ መግቢያ', 'Seensa Boordii Dhaabbataa'),
  'Represent an institution? Register here': (
    'ተቋም ይወክላሉ? እዚህ ይመዝገቡ',
    'Dhaabbata bakka bu’uu? Asitti galmeessaa',
  ),
  'Could not sign in. Check your connection.': (
    'መግባት አልተቻለም። የኢንተርኔት ግንኙነትዎን ያረጋግጡ።',
    'Seenuun hin danda’amne. Walqunnamtii keessan ilaalaa.',
  ),
  'Could not create the account. Check your connection.': (
    'መለያውን መፍጠር አልተቻለም። የኢንተርኔት ግንኙነትዎን ያረጋግጡ።',
    'Akkaawuntii uumuu hin dandeenye. Walqunnamtii keessan ilaalaa.',
  ),
  'Could not send the email. Try again.': (
    'ኢሜይሉን መላክ አልተቻለም። እንደገና ይሞክሩ።',
    'Imeelii erguun hin danda’amne. Irra deebi’aa yaalaa.',
  ),
  'Could not open your messaging app. Try another way.': (
    'የመልዕክት መተግበሪያዎን መክፈት አልተቻለም። ሌላ መንገድ ይሞክሩ።',
    'Appii ergaa keessan banuun hin danda’amne. Karaa biraa yaalaa.',
  ),
  'Data removed from this device.': (
    'መረጃው ከዚህ መሣሪያ ተወግዷል።',
    'Daataan meeshaa kana irraa haqameera.',
  ),
  'Relationship (e.g. sister)': (
    'ግንኙነት (ለምሳሌ እህት)',
    'Hariiroo (fakkeenyaaf obboleettii)',
  ),
  'Phone number': ('ስልክ ቁጥር', 'Lakkoofsa bilbilaa'),
  'No case found with that code. Check it and try again.': (
    'በዚያ ኮድ ምንም ጉዳይ አልተገኘም። ያረጋግጡና እንደገና ይሞክሩ።',
    'Koodii sanaan dhimma hin argamne. Ilaalaatii irra deebi’aa yaalaa.',
  ),
  'Could not check that code. Try again.': (
    'ያንን ኮድ ማረጋገጥ አልተቻለም። እንደገና ይሞክሩ።',
    'Koodii sana mirkaneessuun hin danda’amne. Irra deebi’aa yaalaa.',
  ),
  'Could not send. Try again.': (
    'መላክ አልተቻለም። እንደገና ይሞክሩ።',
    'Erguun hin danda’amne. Irra deebi’aa yaalaa.',
  ),
  'You can attach up to 5 items.': (
    'እስከ 5 ንጥሎች ማያያዝ ይችላሉ።',
    'Hanga wantoota 5 qabsiisuu dandeessu.',
  ),
  'Could not read that file.': (
    'ያንን ፋይል ማንበብ አልተቻለም።',
    'Faayila sana dubbisuun hin danda’amne.',
  ),
  'That file is larger than 10 MB.': (
    'ያ ፋይል ከ10 MB በላይ ነው።',
    'Faayilli sun 10 MB caala.',
  ),
  'Only JPG, PNG and PDF files are allowed.': (
    'JPG፣ PNG እና PDF ፋይሎች ብቻ ይፈቀዳሉ።',
    'Faayiloonni JPG, PNG fi PDF qofa ni hayyamamu.',
  ),
  'Could not open the file picker.': (
    'የፋይል መምረጫውን መክፈት አልተቻለም።',
    'Filataa faayilaa banuun hin danda’amne.',
  ),
  'Microphone permission is needed to record a voice note.': (
    'የድምፅ መልዕክት ለመቅዳት የማይክሮፎን ፈቃድ ያስፈልጋል።',
    'Ergaa sagalee waraabuuf hayyamni maayikirofoonii barbaachisa.',
  ),
  'Could not start recording.': (
    'ቀረጻውን መጀመር አልተቻለም።',
    'Waraabbiin jalqabsiisuun hin danda’amne.',
  ),
  'Nothing was recorded.': ('ምንም ነገር አልተቀዳም።', 'Homtuu hin waraabamne.'),
  'Analytics & Insights': ('ትንታኔ እና ግንዛቤዎች', 'Xiinxalaa fi hubannoo'),
  'Search by Case Code, Category, Location, Officer...': (
    'በጉዳይ ኮድ፣ ምድብ፣ አካባቢ ወይም ባለሙያ ይፈልጉ...',
    'Koodii dhimmaa, gosa, iddoo ykn ogeessaan barbaadaa...',
  ),
  'Audit export ready. All records verified.': (
    'የኦዲት ማውጫው ዝግጁ ነው። ሁሉም መዝገቦች ተረጋግጠዋል።',
    'Baasii odiitii qophaa’eera. Galmeewwan hundi mirkanaa’aniiru.',
  ),
  'URGENT': ('አስቸኳይ', 'ARIIFACHIISAA'),
  'HIGH': ('ከፍተኛ', 'OL’AANAA'),
  'MEDIUM': ('መካከለኛ', 'GIDDU-GALEESSA'),
  'LOW': ('ዝቅተኛ', 'GAD-AANAA'),
  'Workflow Actions': ('የስራ ሂደት እርምጃዎች', 'Tarkaanfiiwwan adeemsa hojii'),
  'External Partner Referral': (
    'ወደ ውጫዊ አጋር ማስተላለፍ',
    'Gara michuu alaa dabarsuu',
  ),
  'In Progress': ('በሂደት ላይ', 'Adeemsa irra jira'),
  'Formal Case Resolution': ('ይፋዊ የጉዳይ መፍትሄ', 'Furmaata dhimmaa sirnaawaa'),
  'Incident Dossier': ('የክስተት ሰነድ', 'Galmee taatee'),
  'Anonymous (Identity Protected)': (
    'ማንነት የማይታወቅ (ማንነት ተጠብቋል)',
    'Maqaa malee (eenyummaan eegameera)',
  ),
  'Submitted Evidence': ('የቀረበ ማስረጃ', 'Ragaa dhiyaate'),
  'Secure Communication with Reporter': (
    'ከሪፖርት አቅራቢው ጋር ደህንነቱ የተጠበቀ ግንኙነት',
    'Gabaasaa waliin qunnamtii nageenya qabu',
  ),
  'Confidential Case Assessment Notes (Staff Only)': (
    'ሚስጥራዊ የጉዳይ ግምገማ ማስታወሻዎች (ለሰራተኞች ብቻ)',
    'Yaadannoo madaallii dhimmaa iccitii (hojjettoota qofaaf)',
  ),
  'Audit Trail & Event History': (
    'የኦዲት እና የክስተት ታሪክ',
    'Seenaa odiitii fi taatee',
  ),
  'URGENT PRIORITY': ('አስቸኳይ ቅድሚያ', 'DURSA ARIIFACHIISAA'),
  'HIGH PRIORITY': ('ከፍተኛ ቅድሚያ', 'DURSA OL’AANAA'),
  'MEDIUM PRIORITY': ('መካከለኛ ቅድሚያ', 'DURSA GIDDU-GALEESSA'),
  'LOW PRIORITY': ('ዝቅተኛ ቅድሚያ', 'DURSA GAD-AANAA'),
  'e.g. Assigned to disciplinary panel...': (
    'ለምሳሌ ለዲሲፕሊን ኮሚቴ ተመድቧል...',
    'Fakkeenyaaf koree naamusaa ramadameera...',
  ),
  'e.g. Your case has been escalated to senior review...': (
    'ለምሳሌ ጉዳይዎ ለከፍተኛ ግምገማ ተላልፏል...',
    'Fakkeenyaaf dhimma keessan gamaaggama olaanaatti dabarfameera...',
  ),
  'e.g. Reporter requests confidential legal representation...': (
    'ለምሳሌ ሪፖርት አቅራቢው ሚስጥራዊ የህግ ውክልና ጠይቋል...',
    'Fakkeenyaaf gabaasaan bakka bu’iinsa seeraa iccitii gaafateera...',
  ),
  'Summary of findings and hearings...': (
    'የግኝቶችና የችሎቶች ማጠቃለያ...',
    'Cuunfaa argannoowwanii fi dhaddacha...',
  ),
  'Action taken to protect reporter...': (
    'ሪፖርት አቅራቢውን ለመጠበቅ የተወሰደ እርምጃ...',
    'Tarkaanfii gabaasaa eeguuf fudhatame...',
  ),
  'Share / Export Case File': (
    'የጉዳይ ፋይል አጋራ / አውጣ',
    'Faayila dhimmaa qoodi / baasi',
  ),
  'Type official response / inquiry...': (
    'ይፋዊ ምላሽ / ጥያቄ ይጻፉ...',
    'Deebii / gaaffii sirnaawaa barreessaa...',
  ),
  'Add confidential case note...': (
    'ሚስጥራዊ የጉዳይ ማስታወሻ ያክሉ...',
    'Yaadannoo dhimmaa iccitii dabalaa...',
  ),
  'Message delivered to reporter.': (
    'መልዕክቱ ለሪፖርት አቅራቢው ደርሷል።',
    'Ergaan gara gabaasa dhiyeessaatti ga’eera.',
  ),
  'Confidential note logged.': (
    'ሚስጥራዊ ማስታወሻው ተመዝግቧል።',
    'Yaadannoon iccitii galmaa’eera.',
  ),
  'Case export ready for confidential hearing.': (
    'ለሚስጥራዊ ችሎት የጉዳይ ማውጫ ዝግጁ ነው።',
    'Baasii dhimmaa dhaddacha iccitiif qophaa’eera.',
  ),
  'Report deleted.': ('ሪፖርቱ ተሰርዟል።', 'Gabaasni haqameera.'),
  'Decrypted attachment for officer review.': (
    'ለባለሙያ ግምገማ የተፈታ አባሪ።',
    'Waraqaa dabalataa gamaaggama ogeessaaf hiikame.',
  ),
  'Demo confirmation': ('የሙከራ ማረጋገጫ', 'Mirkaneessa qorannoo'),
  'This illustrates a submission receipt. No live report was delivered.': (
    'ይህ የማሳያ ደረሰኝ ነው። በቀጥታ ሪፖርት አልተላከም።',
    'Kun rasiida agarsiisaati. Gabaasni dhugaa hin ergamne.',
  ),
  '\$failedUploads item(s) could not be uploaded. Your report was still received. You can describe the details in a message from My Cases.':
      (
        '\$failedUploads ንጥል(ሎች) መጫን አልተቻለም። ሪፖርትዎ ግን ተቀብሏል። ዝርዝሩን በጉዳዮቼ ውስጥ ባለ መልዕክት መግለጽ ይችላሉ።',
        '\$failedUploads wanti/wantoonni fe’uun hin danda’amne. Gabaasni keessan garuu fudhatameera. Bal’ina isaa ergaa Dhimmoota Koo keessatti ibsuu dandeessu.',
      ),
  'Draft kept while the app stays open.': (
    'መተግበሪያው ክፍት እስካለ ረቂቁ ይቀመጣል።',
    'Appiin banaa hamma jirutti wixineen ni kuufama.',
  ),
  'Could not submit. Check your connection and try again.': (
    'ማስገባት አልተቻለም። ግንኙነትዎን ያረጋግጡና እንደገና ይሞክሩ።',
    'Erguun hin danda’amne. Walqunnamtii keessan ilaalaatii irra deebi’aa yaalaa.',
  ),
  'Code copied.': ('ኮዱ ተቀድቷል።', 'Koodiin garagalfameera.'),
};
