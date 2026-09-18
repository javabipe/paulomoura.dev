import 'package:flutter/material.dart';

class Project {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> techStack;
  final List<String> features;
  final String liveUrl;
  final String githubUrl;

  const Project({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.techStack,
    required this.features,
    required this.liveUrl,
    required this.githubUrl,
  });
}

class Skill {
  final String name;
  final IconData icon;
  final String category;
  final double proficiency; // 0.0 to 1.0

  const Skill({
    required this.name,
    required this.icon,
    required this.category,
    required this.proficiency,
  });
}

class Service {
  final String title;
  final String description;
  final IconData icon;

  const Service({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class TimelineExperience {
  final String role;
  final String company;
  final String period;
  final String location;
  final List<String> highlights;

  const TimelineExperience({
    required this.role,
    required this.company,
    required this.period,
    required this.location,
    required this.highlights,
  });
}

class Statistic {
  final int number;
  final String suffix;
  final String label;
  final IconData icon;

  const Statistic({
    required this.number,
    required this.suffix,
    required this.label,
    required this.icon,
  });
}
