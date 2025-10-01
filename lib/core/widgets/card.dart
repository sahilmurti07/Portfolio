import 'package:flutter/material.dart';
import 'package:portfolio_web/ViewModel/ProjectViewModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCard extends StatelessWidget {
  final Project project;
  const CustomCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.maybeOf(context);
    final isMobile = mediaQuery != null ? mediaQuery.size.width < 768 : false;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(isMobile ? 5 : 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: () => _launchURL(project.link),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Project Image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  project.image,
                  height: isMobile ? 80 : 120,
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),

              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(isMobile ? 5 : 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        project.title,
                        style: GoogleFonts.openSans(
                          fontSize: isMobile ? 12 : 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        project.description,
                        style: GoogleFonts.openSans(
                          fontSize: isMobile ? 10 : 12,
                          color: Colors.grey[400],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      // Tech Stack as Chips
                      Wrap(
                        spacing: 2,
                        runSpacing: 2,
                        children: project.techstack
                            .take(isMobile ? 4 : 3)
                            .map(
                              (tech) => Chip(
                                label: Text(
                                  tech,
                                  style: TextStyle(
                                    fontSize: isMobile ? 8 : 10,
                                    color: Colors.white,
                                  ),
                                ),
                                backgroundColor: Colors.grey[900],
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity.compact,
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 14),
                      // Links
                      SizedBox(
                        width: double.infinity,
                        height: isMobile ? 32 : 36,
                        child: ElevatedButton(
                          onPressed: () => _launchURL(project.link),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: isMobile ? 4 : 8,
                            ),
                          ),
                          child: Text(
                            "GitHub",
                            style: TextStyle(fontSize: isMobile ? 10 : 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) throw Exception("could not launch $url");
  }
}
