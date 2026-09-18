import 'package:flutter/material.dart';
import '../models/portfolio_models.dart';

class PortfolioData {
  PortfolioData._();

  static List<Project> projects(bool fr) => fr ? _projectsFr : _projectsEn;
  static List<Skill> skills(bool fr) => fr ? _skillsFr : _skillsEn;
  static List<Service> services(bool fr) => fr ? _servicesFr : _servicesEn;
  static List<TimelineExperience> experience(bool fr) => fr ? _expFr : _expEn;
  static List<Statistic> stats(bool fr) => fr ? _statsFr : _statsEn;

  static const List<Project> _projectsEn = [
    Project(
      title: 'evalkit',
      description:
          'Reproducible LLM evaluation harness: dataset versioning, judge calibration against human labels, cost/latency tracking per run, and CI-friendly regression gates.',
      imageUrl: 'evalkit',
      techStack: ['Python', 'LLM-as-judge', 'CI gates', 'Datasets'],
      features: [
        'Versioned golden suites with content fingerprints',
        'Deterministic and model-graded metrics',
        'Baseline comparison that fails the build on quality drop',
        'Cost and latency accounted per run',
      ],
      liveUrl: 'https://github.com/javabipe/evalkit',
      githubUrl: 'https://github.com/javabipe/evalkit',
    ),
    Project(
      title: 'atendo',
      description:
          'Multi-tenant WhatsApp Business API agent platform with function calling into CRMs, booking systems and payment links, Redis-backed conversation state, and per-tenant RAG.',
      imageUrl: 'atendo',
      techStack: ['TypeScript', 'WhatsApp API', 'RAG', 'Redis'],
      features: [
        'Typed tool contracts with dry-run previews',
        'Reversible action log for model-initiated writes',
        'Human handoff as a first-class tool',
        'Tenant-scoped retrieval over client knowledge bases',
      ],
      liveUrl: 'https://github.com/javabipe/atendo',
      githubUrl: 'https://github.com/javabipe/atendo',
    ),
    Project(
      title: 'kernel-notes',
      description:
          'Annotated Triton and CUDA-shaped kernels: fused attention, layer-norm and quantized matmul, with roofline notes for engineers moving from application code into GPU work.',
      imageUrl: 'kernel',
      techStack: ['Triton', 'CUDA', 'PyTorch', 'Roofline'],
      features: [
        'Online-softmax attention without materialising T×T',
        'Fused layer-norm to cut HBM round trips',
        'INT8 matmul with scales kept in registers',
        'Profiler order: Nsight Systems, then Compute',
      ],
      liveUrl: 'https://github.com/javabipe/kernel-notes',
      githubUrl: 'https://github.com/javabipe/kernel-notes',
    ),
  ];

  static const List<Project> _projectsFr = [
    Project(
      title: 'evalkit',
      description:
          'Harnais d’évaluation LLM reproductible : versionnage de jeux, calibration du juge contre des labels humains, suivi coût/latence, portes de régression pour la CI.',
      imageUrl: 'evalkit',
      techStack: ['Python', 'LLM-juge', 'Portes CI', 'Datasets'],
      features: [
        'Suites golden versionnées avec empreinte',
        'Métriques déterministes et notées par modèle',
        'Comparaison à une baseline qui fait échouer le build',
        'Coût et latence comptés par run',
      ],
      liveUrl: 'https://github.com/javabipe/evalkit',
      githubUrl: 'https://github.com/javabipe/evalkit',
    ),
    Project(
      title: 'atendo',
      description:
          'Plateforme d’agents multi-tenant sur l’API WhatsApp Business, appels de fonctions vers CRM, réservations et paiements, état Redis, RAG par tenant.',
      imageUrl: 'atendo',
      techStack: ['TypeScript', 'API WhatsApp', 'RAG', 'Redis'],
      features: [
        'Contrats d’outils typés avec aperçu à blanc',
        'Journal réversible des écritures initiées par le modèle',
        'Handoff humain comme outil de premier plan',
        'Retrieval borné au tenant sur la base client',
      ],
      liveUrl: 'https://github.com/javabipe/atendo',
      githubUrl: 'https://github.com/javabipe/atendo',
    ),
    Project(
      title: 'kernel-notes',
      description:
          'Kernels Triton et CUDA annotés : attention fusionnée, layer-norm, matmul quantifié, notes roofline pour passer du code applicatif au GPU.',
      imageUrl: 'kernel',
      techStack: ['Triton', 'CUDA', 'PyTorch', 'Roofline'],
      features: [
        'Attention softmax en ligne sans matérialiser T×T',
        'Layer-norm fusionné pour éviter l’HBM',
        'Matmul INT8 avec échelles en registres',
        'Ordre de profilage : Nsight Systems, puis Compute',
      ],
      liveUrl: 'https://github.com/javabipe/kernel-notes',
      githubUrl: 'https://github.com/javabipe/kernel-notes',
    ),
  ];

  static const List<Skill> _skillsEn = [
    Skill(name: 'Python', icon: Icons.code, category: 'Languages', proficiency: 0.96),
    Skill(name: 'TypeScript', icon: Icons.javascript, category: 'Languages', proficiency: 0.92),
    Skill(name: 'Go', icon: Icons.terminal, category: 'Languages', proficiency: 0.82),
    Skill(name: 'Ruby', icon: Icons.code, category: 'Languages', proficiency: 0.85),
    Skill(name: 'Agent orchestration', icon: Icons.hub, category: 'LLM & Agents', proficiency: 0.94),
    Skill(name: 'RAG / pgvector', icon: Icons.manage_search, category: 'LLM & Agents', proficiency: 0.93),
    Skill(name: 'MCP & tool calling', icon: Icons.extension, category: 'LLM & Agents', proficiency: 0.90),
    Skill(name: 'Eval harnesses', icon: Icons.fact_check, category: 'LLM & Agents', proficiency: 0.95),
    Skill(name: 'PyTorch', icon: Icons.psychology, category: 'ML Systems', proficiency: 0.88),
    Skill(name: 'vLLM', icon: Icons.bolt, category: 'ML Systems', proficiency: 0.90),
    Skill(name: 'Triton / CUDA', icon: Icons.memory, category: 'ML Systems', proficiency: 0.84),
    Skill(name: 'Hugging Face', icon: Icons.auto_awesome, category: 'ML Systems', proficiency: 0.86),
    Skill(name: 'PostgreSQL', icon: Icons.storage, category: 'Data', proficiency: 0.90),
    Skill(name: 'Kafka / Spark', icon: Icons.stream, category: 'Data', proficiency: 0.88),
    Skill(name: 'dbt / Airflow', icon: Icons.account_tree, category: 'Data', proficiency: 0.86),
    Skill(name: 'Kubernetes', icon: Icons.cloud, category: 'Platform', proficiency: 0.90),
    Skill(name: 'GCP / AWS / Azure', icon: Icons.cloud_queue, category: 'Platform', proficiency: 0.88),
    Skill(name: 'Terraform', icon: Icons.settings, category: 'Platform', proficiency: 0.84),
    Skill(name: 'Observability', icon: Icons.monitor_heart, category: 'Platform', proficiency: 0.87),
    Skill(name: 'AppSec / OSCP', icon: Icons.security, category: 'Security', proficiency: 0.82),
  ];

  static const List<Skill> _skillsFr = [
    Skill(name: 'Python', icon: Icons.code, category: 'Langages', proficiency: 0.96),
    Skill(name: 'TypeScript', icon: Icons.javascript, category: 'Langages', proficiency: 0.92),
    Skill(name: 'Go', icon: Icons.terminal, category: 'Langages', proficiency: 0.82),
    Skill(name: 'Ruby', icon: Icons.code, category: 'Langages', proficiency: 0.85),
    Skill(name: 'Orchestration d’agents', icon: Icons.hub, category: 'LLM et agents', proficiency: 0.94),
    Skill(name: 'RAG / pgvector', icon: Icons.manage_search, category: 'LLM et agents', proficiency: 0.93),
    Skill(name: 'MCP et tool calling', icon: Icons.extension, category: 'LLM et agents', proficiency: 0.90),
    Skill(name: 'Harnais d’éval.', icon: Icons.fact_check, category: 'LLM et agents', proficiency: 0.95),
    Skill(name: 'PyTorch', icon: Icons.psychology, category: 'Systèmes ML', proficiency: 0.88),
    Skill(name: 'vLLM', icon: Icons.bolt, category: 'Systèmes ML', proficiency: 0.90),
    Skill(name: 'Triton / CUDA', icon: Icons.memory, category: 'Systèmes ML', proficiency: 0.84),
    Skill(name: 'Hugging Face', icon: Icons.auto_awesome, category: 'Systèmes ML', proficiency: 0.86),
    Skill(name: 'PostgreSQL', icon: Icons.storage, category: 'Données', proficiency: 0.90),
    Skill(name: 'Kafka / Spark', icon: Icons.stream, category: 'Données', proficiency: 0.88),
    Skill(name: 'dbt / Airflow', icon: Icons.account_tree, category: 'Données', proficiency: 0.86),
    Skill(name: 'Kubernetes', icon: Icons.cloud, category: 'Plateforme', proficiency: 0.90),
    Skill(name: 'GCP / AWS / Azure', icon: Icons.cloud_queue, category: 'Plateforme', proficiency: 0.88),
    Skill(name: 'Terraform', icon: Icons.settings, category: 'Plateforme', proficiency: 0.84),
    Skill(name: 'Observabilité', icon: Icons.monitor_heart, category: 'Plateforme', proficiency: 0.87),
    Skill(name: 'AppSec / OSCP', icon: Icons.security, category: 'Sécurité', proficiency: 0.82),
  ];

  static const List<Service> _servicesEn = [
    Service(
      title: 'LLM & agent platforms',
      description: 'Multi-agent planning, MCP, function calling, and safe mutation of product state.',
      icon: Icons.hub,
    ),
    Service(
      title: 'RAG systems',
      description: 'Hybrid BM25 + dense retrieval, re-ranking, chunking, and groundedness evaluation.',
      icon: Icons.manage_search,
    ),
    Service(
      title: 'Evaluation infrastructure',
      description: 'Golden sets, LLM-as-judge calibration, CI regression gates, and rubric design.',
      icon: Icons.fact_check,
    ),
    Service(
      title: 'Inference & GPU',
      description: 'vLLM serving, quantization, Triton kernels, and cost/latency optimisation.',
      icon: Icons.bolt,
    ),
    Service(
      title: 'Data platforms',
      description: 'Streaming ETL, dbt, warehouse modelling, Kafka, Spark, and vector indexes.',
      icon: Icons.storage,
    ),
    Service(
      title: 'Platform & security',
      description: 'Kubernetes, Terraform, observability, threat modelling, and CVE-quality review.',
      icon: Icons.security,
    ),
  ];

  static const List<Service> _servicesFr = [
    Service(
      title: 'Plateformes LLM et agents',
      description: 'Planification multi-agents, MCP, appels d’outils, mutation sûre de l’état produit.',
      icon: Icons.hub,
    ),
    Service(
      title: 'Systèmes RAG',
      description: 'Retrieval hybride BM25 + dense, re-ranking, chunking, évaluation de groundedness.',
      icon: Icons.manage_search,
    ),
    Service(
      title: 'Infrastructure d’évaluation',
      description: 'Jeux golden, calibration LLM-juge, portes de régression CI, grilles d’annotation.',
      icon: Icons.fact_check,
    ),
    Service(
      title: 'Inférence et GPU',
      description: 'Serving vLLM, quantification, kernels Triton, optimisation coût/latence.',
      icon: Icons.bolt,
    ),
    Service(
      title: 'Plateformes data',
      description: 'ETL streaming, dbt, modélisation, Kafka, Spark, index vectoriels.',
      icon: Icons.storage,
    ),
    Service(
      title: 'Plateforme et sécurité',
      description: 'Kubernetes, Terraform, observabilité, threat modelling, revue de CVE.',
      icon: Icons.security,
    ),
  ];

  static const List<TimelineExperience> _expEn = [
    TimelineExperience(
      role: 'Independent Contractor',
      company: 'Frontier AI labs & research partners',
      period: 'Feb 2025 – Present',
      location: 'Remote · Montreal, QC',
      highlights: [
        'Authored and reviewed 1,400+ software-engineering eval tasks; 96.2% reviewer-acceptance vs 78% program average.',
        'Two-part verification for agentic coding tasks cut false-positive “solved” signals 41% on a 900-task benchmark.',
        'ML-systems eval content covering GPU kernels, profiler traces, distributed training, and inference trade-offs.',
        'QA on 300+ CVE reproductions; rejected or repaired 22% of submissions that passed tests without closing the class.',
      ],
    ),
    TimelineExperience(
      role: 'Senior → Staff Software Engineer, Commerce AI',
      company: 'Shopify Inc.',
      period: 'Mar 2021 – Jan 2025',
      location: 'Montreal, QC, Canada',
      highlights: [
        'Tech lead for retrieval and tool-calling behind a merchant AI assistant: 89% groundedness, −31% support escalations.',
        'Function-calling contract layer for merchant writes; zero P1s across ~4M executed actions.',
        'Cut assistant inference cost 63% (\$2.1M annualized) with vLLM, paged attention, and confidence-gated routing.',
        'Fused Triton kernel on a 400M+ product embedding backfill: 30-hour nightly job to 4.5 hours on the same H100s.',
      ],
    ),
    TimelineExperience(
      role: 'Software Engineer → Technical Lead, Platform',
      company: 'TOTVS S.A.',
      period: 'Jun 2015 – Feb 2021',
      location: 'São Paulo / Remote, Brazil',
      highlights: [
        'API gateway and Kafka event bus replaced 200+ point-to-point integrations; onboarding 11 weeks to 3.',
        'NF-e/NFS-e fiscal processing at 6M+ documents/month; integration tickets −47% year over year.',
        'First customer analytics pipeline on Spark, Airflow, Redshift and dbt for 3,000+ client organisations.',
        'Security-hardening program: critical production findings from 23 to 2 across four quarters.',
      ],
    ),
    TimelineExperience(
      role: 'Junior Developer → Senior Engineer / DevOps',
      company: 'Sankhya Gestão de Negócios',
      period: 'Jan 2010 – May 2015',
      location: 'Uberlândia, MG, Brazil',
      highlights: [
        'Full-stack ERP: Java, Oracle PL/SQL, JavaScript — 15,000+ daily users in finance, inventory, procurement.',
        'Rewrote inventory-costing after a quadratic query path; month-end close 9 hours to 22 minutes.',
        'First CI pipeline and 1,800-test suite: two-day release ritual to a 40-minute deploy.',
      ],
    ),
  ];

  static const List<TimelineExperience> _expFr = [
    TimelineExperience(
      role: 'Contractant indépendant',
      company: 'Labos d’IA de frontière et partenaires de recherche',
      period: 'Fév. 2025 – Aujourd’hui',
      location: 'Télétravail · Montréal, QC',
      highlights: [
        '1 400+ tâches d’éval. génie logiciel ; taux d’acceptation réviseur 96,2 % contre 78 % en moyenne programme.',
        'Vérification en deux volets des tâches agentiques : faux positifs « résolu » −41 % sur 900 tâches.',
        'Contenu d’éval. systèmes ML : kernels GPU, traces de profileur, entraînement distribué, serving.',
        'QA de 300+ reproductions CVE ; 22 % des soumissions rejetées ou corrigées.',
      ],
    ),
    TimelineExperience(
      role: 'Ingénieur senior → Staff, Commerce AI',
      company: 'Shopify Inc.',
      period: 'Mars 2021 – Janv. 2025',
      location: 'Montréal, QC, Canada',
      highlights: [
        'Tech lead retrieval et tool-calling d’un assistant marchand : 89 % de groundedness, escalades −31 %.',
        'Couche de contrats function-calling ; zéro P1 sur ~4 M d’actions.',
        'Coût d’inférence −63 % (2,1 M\$ annualisés) via vLLM, paged attention et routage selon la confiance.',
        'Kernel Triton fusionné : backfill 400 M+ produits, job de 30 h à 4,5 h sur les mêmes H100.',
      ],
    ),
    TimelineExperience(
      role: 'Ingénieur → Lead technique, plateforme',
      company: 'TOTVS S.A.',
      period: 'Juin 2015 – Fév. 2021',
      location: 'São Paulo / Télétravail, Brésil',
      highlights: [
        'Passerelle API et bus Kafka : 200+ intégrations remplacées, onboarding de 11 semaines à 3.',
        'Documents fiscaux NF-e/NFS-e à 6 M+/mois ; tickets −47 % sur un an.',
        'Pipeline analytique Spark, Airflow, Redshift et dbt pour 3 000+ organisations.',
        'Durcissement sécu : findings critiques en prod de 23 à 2.',
      ],
    ),
    TimelineExperience(
      role: 'Développeur junior → Ingénieur senior / DevOps',
      company: 'Sankhya Gestão de Negócios',
      period: 'Janv. 2010 – Mai 2015',
      location: 'Uberlândia, MG, Brésil',
      highlights: [
        'ERP full-stack : Java, PL/SQL Oracle, JavaScript — 15 000+ utilisateurs quotidiens.',
        'Moteur de costing réécrit ; clôture mensuelle de 9 h à 22 min.',
        'Premier CI et 1 800 tests : release de deux jours à 40 minutes.',
      ],
    ),
  ];

  static const List<Statistic> _statsEn = [
    Statistic(number: 15, suffix: '+', label: 'Years in production', icon: Icons.workspace_premium),
    Statistic(number: 1400, suffix: '+', label: 'Eval tasks authored', icon: Icons.fact_check),
    Statistic(number: 63, suffix: '%', label: 'Inference cost reduced', icon: Icons.bolt),
    Statistic(number: 4, suffix: 'M', label: 'Model writes, zero P1s', icon: Icons.shield),
  ];

  static const List<Statistic> _statsFr = [
    Statistic(number: 15, suffix: '+', label: 'Années en production', icon: Icons.workspace_premium),
    Statistic(number: 1400, suffix: '+', label: 'Tâches d’éval. rédigées', icon: Icons.fact_check),
    Statistic(number: 63, suffix: '%', label: 'Coût d’inférence en moins', icon: Icons.bolt),
    Statistic(number: 4, suffix: 'M', label: 'Écritures modèle, zéro P1', icon: Icons.shield),
  ];
}
