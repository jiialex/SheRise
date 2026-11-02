/// Trusted outside websites shown on the Explore screen. Each one opens in the
/// phone's own browser. Check every link before launch: sites move pages.
class QuickLink {
  const QuickLink(this.name, this.url, this.blurb);
  final String name;
  final String url;
  final String blurb;

  String get host => Uri.parse(url).host.replaceFirst('www.', '');
}

class QuickLinks {
  /// Opportunities tab: jobs, internships, scholarships, training.
  static const opportunities = <QuickLink>[
    QuickLink('ReliefWeb Jobs', 'https://reliefweb.int/jobs?search=Ethiopia',
        'Jobs and internships with NGOs and UN agencies, searched for Ethiopia.'),
    QuickLink('EthioJobs', 'https://www.ethiojobs.net',
        'Job listings across Ethiopia, from entry level up.'),
    QuickLink('UN Careers', 'https://careers.un.org',
        'Official jobs, internships and fellowships at the United Nations.'),
    QuickLink('Mastercard Foundation Scholars', 'https://mastercardfdn.org/all/scholars/',
        'Scholarships and leadership programmes for young Africans.'),
    QuickLink('Scholars4Dev', 'https://www.scholars4dev.com',
        'A large list of scholarships, sorted by country and level.'),
    QuickLink('Opportunities for Africans', 'https://www.opportunitiesforafricans.com',
        'Scholarships, fellowships, grants and training for Africans.'),
    QuickLink('YouthOp', 'https://www.youthop.com',
        'Youth programmes, competitions, volunteering and internships.'),
  ];

  /// Learn tab: safety, rights, health and digital privacy.
  static const learn = <QuickLink>[
    QuickLink('UN Women', 'https://www.unwomen.org',
        'Facts and guides on women\'s rights, safety and ending violence.'),
    QuickLink('WHO: Violence against women', 'https://www.who.int/health-topics/violence-against-women',
        'Clear health information on violence against women and where to turn.'),
    QuickLink('UNFPA Ethiopia', 'https://ethiopia.unfpa.org',
        'Reproductive health and gender-based violence work in Ethiopia.'),
    QuickLink('Ethiopian Women Lawyers Association', 'https://ewla.org',
        'Free legal aid and rights information for women in Ethiopia.'),
    QuickLink('Surveillance Self-Defense (EFF)', 'https://ssd.eff.org',
        'Step-by-step guides to protect your phone, messages and privacy.'),
    QuickLink('Access Now Digital Security Helpline', 'https://www.accessnow.org/help/',
        'Free help if your account is hacked or you are harassed online.'),
    QuickLink('Khan Academy', 'https://www.khanacademy.org',
        'Free lessons in school subjects, in many languages.'),
  ];
}
