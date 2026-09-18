import 'package:flutter/material.dart';

class LocaleScope extends InheritedNotifier<ValueNotifier<String>> {
  const LocaleScope({
    super.key,
    required ValueNotifier<String> notifier,
    required super.child,
  }) : super(notifier: notifier);

  static String of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LocaleScope>()?.notifier?.value ?? 'en';
  }

  static ValueNotifier<String> controller(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LocaleScope>()!.notifier!;
  }

  static bool isFr(BuildContext context) => of(context) == 'fr';
}

class S {
  static String t(BuildContext context, String key) {
    final table = LocaleScope.isFr(context) ? _fr : _en;
    return table[key] ?? _en[key] ?? key;
  }

  static const Map<String, String> _en = {
    'navHome': 'Home',
    'navAbout': 'About',
    'navSkills': 'Skills',
    'navProjects': 'Projects',
    'navServices': 'Services',
    'navExperience': 'Experience',
    'navContact': 'Contact',
    'contactMe': 'Contact Me',
    'navigation': 'NAVIGATION',
    'openForWork': 'Open for Work',
    'helloIm': "Hello, I'm",
    'iBuild': 'I build ',
    'type1': 'LLM agent systems',
    'type2': 'Hybrid RAG pipelines',
    'type3': 'Eval infrastructure',
    'type4': 'GPU inference stacks',
    'heroLede':
        'Senior engineer with 15+ years in production software, now focused on agent orchestration, retrieval-augmented generation, evaluation, and the GPU-side work that makes model serving economical.',
    'hireMe': 'Hire Me',
    'viewProjects': 'View Projects',
    'resume': 'Resume',
    'aboutEyebrow': 'About Me',
    'aboutTitle': 'Systems, then the model stack',
    'aboutHeadline': 'Owning LLM systems end-to-end — from the rubric to the kernel.',
    'about1':
        'A decade on high-throughput ERP platforms in Brazil (Sankhya, TOTVS), then Canada in 2021 to join Shopify. Merchant product, platform reliability, and the internal ML/LLM tooling that shipped generative commerce to millions of stores.',
    'about2':
        'Since 2025, independent contractor for frontier AI labs and research partners: evaluation rubrics, RL environments, and adversarial datasets for code, ML-systems, and security. Frame it, instrument it, ship it, prove the number moved.',
    'comp1t': 'Agent orchestration',
    'comp1d': 'Multi-agent planning, tool calling, MCP, typed schemas, dry-run previews, reversible action logs.',
    'comp2t': 'Hybrid RAG',
    'comp2d': 'BM25 + dense retrieval, re-ranking, chunking strategy, groundedness evals, tenant-scoped indexes.',
    'comp3t': 'Eval & research ops',
    'comp3d': 'Harness design, LLM-as-judge calibration, SxS ranking, SWE-bench-style tasks, CI quality gates.',
    'comp4t': 'GPU inference',
    'comp4d': 'vLLM, paged attention, Triton/CUDA kernels, quantization, cost/latency trade-offs on H100/A100.',
    'skillsEyebrow': 'My Skills',
    'skillsTitle': 'Technical Arsenal',
    'skillsAll': 'All',
    'projectsEyebrow': 'My Projects',
    'projectsTitle': 'Featured Works',
    'servicesEyebrow': 'Services',
    'servicesTitle': 'Professional Offerings',
    'expEyebrow': 'Experience',
    'expTitle': 'Professional Journey',
    'contactEyebrow': 'Contact Me',
    'contactTitle': "Let's Collaborate",
    'contactHeadline': 'Reach Out Directly',
    'contactLede':
        'Full-time, 40h/week, PST–EST overlap. Authorized to work in Canada without sponsorship. If the problem is messy and the metric is real, write.',
    'emailMe': 'Email Me',
    'location': 'Location',
    'sendMessage': 'Send a Message',
    'name': 'Name',
    'yourName': 'Your Name',
    'email': 'Email',
    'subject': 'Subject',
    'subjectHint': 'Project collaboration',
    'message': 'Message',
    'messageHint': 'Write your message here...',
    'send': 'Send Message',
    'required': 'Required',
    'invalidEmail': 'Enter a valid email',
    'mailOpened': 'Opening your mail client',
    'mailOpenedBody': 'A draft to contact@paulomoura.dev is ready to send.',
    'footerNote': 'LLM systems · agents · evaluation · Montreal',
    'heroDev': 'AGENTS',
    'heroAi': 'RAG',
    'heroCloud': 'EVAL',
    'heroPerf': 'GPU',
  };

  static const Map<String, String> _fr = {
    'navHome': 'Accueil',
    'navAbout': 'Profil',
    'navSkills': 'Stack',
    'navProjects': 'Projets',
    'navServices': 'Offre',
    'navExperience': 'Parcours',
    'navContact': 'Contact',
    'contactMe': 'Écrire',
    'navigation': 'NAVIGATION',
    'openForWork': 'Disponible',
    'helloIm': 'Bonjour, je suis',
    'iBuild': 'Je construis ',
    'type1': 'des systèmes d’agents LLM',
    'type2': 'des pipelines RAG hybrides',
    'type3': 'de l’infra d’évaluation',
    'type4': 'des stacks d’inférence GPU',
    'heroLede':
        'Ingénieur senior, 15+ ans de logiciel en production, désormais sur l’orchestration d’agents, le RAG, l’évaluation, et l’ingénierie GPU qui rend le serving de modèles économique.',
    'hireMe': 'Me joindre',
    'viewProjects': 'Voir les projets',
    'resume': 'CV',
    'aboutEyebrow': 'Profil',
    'aboutTitle': 'Les systèmes, puis la pile modèle',
    'aboutHeadline': 'Des systèmes LLM de bout en bout — de la grille jusqu’au kernel.',
    'about1':
        'Une décennie sur des ERP à haut débit au Brésil (Sankhya, TOTVS), puis le Canada en 2021 pour Shopify. Produit marchand, fiabilité de plateforme, et outillage ML/LLM interne qui a livré le commerce génératif à des millions de boutiques.',
    'about2':
        'Depuis 2025, contractant pour des labos d’IA de frontière : grilles d’évaluation, environnements de RL, jeux adverses pour le code, les systèmes ML et la sécurité. Cadrer, instrumenter, livrer, prouver qu’un chiffre a bougé.',
    'comp1t': 'Orchestration d’agents',
    'comp1d': 'Planification multi-agents, appels d’outils, MCP, schémas typés, aperçus à blanc, journaux réversibles.',
    'comp2t': 'RAG hybride',
    'comp2d': 'BM25 + retrieval dense, re-ranking, chunking, évals de groundedness, index par tenant.',
    'comp3t': 'Éval & research ops',
    'comp3d': 'Harnais, calibration LLM-juge, ranking SxS, tâches style SWE-bench, portes qualité en CI.',
    'comp4t': 'Inférence GPU',
    'comp4d': 'vLLM, paged attention, kernels Triton/CUDA, quantification, compromis coût/latence sur H100/A100.',
    'skillsEyebrow': 'Compétences',
    'skillsTitle': 'Arsenal technique',
    'skillsAll': 'Tous',
    'projectsEyebrow': 'Projets',
    'projectsTitle': 'Travaux choisis',
    'servicesEyebrow': 'Services',
    'servicesTitle': 'Offre professionnelle',
    'expEyebrow': 'Parcours',
    'expTitle': 'Trajectoire',
    'contactEyebrow': 'Contact',
    'contactTitle': 'Collaborons',
    'contactHeadline': 'Écrire directement',
    'contactLede':
        'Temps plein, 40 h/semaine, chevauchement PST–EST. Autorisé à travailler au Canada sans parrainage. Si le problème est sale et la métrique réelle, écrivez.',
    'emailMe': 'Courriel',
    'location': 'Lieu',
    'sendMessage': 'Envoyer un message',
    'name': 'Nom',
    'yourName': 'Votre nom',
    'email': 'Courriel',
    'subject': 'Objet',
    'subjectHint': 'Collaboration',
    'message': 'Message',
    'messageHint': 'Votre message…',
    'send': 'Envoyer',
    'required': 'Requis',
    'invalidEmail': 'Courriel invalide',
    'mailOpened': 'Ouverture du client mail',
    'mailOpenedBody': 'Un brouillon vers contact@paulomoura.dev est prêt.',
    'footerNote': 'Systèmes LLM · agents · évaluation · Montréal',
    'heroDev': 'AGENTS',
    'heroAi': 'RAG',
    'heroCloud': 'ÉVAL',
    'heroPerf': 'GPU',
  };
}
