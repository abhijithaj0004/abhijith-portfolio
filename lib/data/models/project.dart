class Project {
  final String title;
  final String category;
  final String company;
  final String description;
  final List<String> technologies;
  final List<String> highlights;
  final String? role;
  final String? architecture;
  final List<String> contributions;
  final String? impact;
  final String? playStoreUrl;
  final String? githubUrl;
  final bool featured;

  const Project({
    required this.title,
    required this.category,
    required this.company,
    required this.description,
    required this.technologies,
    this.highlights = const [],
    this.role,
    this.architecture,
    this.contributions = const [],
    this.impact,
    this.playStoreUrl,
    this.githubUrl,
    this.featured = false,
  });
}
