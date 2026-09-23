import 'package:flutter/material.dart';

class SkillCategory {
  final String title;
  final IconData icon;
  final List<String> skills;

  const SkillCategory({
    required this.title,
    required this.icon,
    required this.skills,
  });
}
