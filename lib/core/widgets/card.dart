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
        margin: EdgeInsets.all(isMobile ? 10 : 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: () => _launchURL(project.link),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Project Image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  project.image,
                  height: isMobile ? 150 : 150,

                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),

              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(isMobile ? 12 : 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        project.title,
                        style: GoogleFonts.openSans(
                          fontSize: isMobile ? 16 : 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        project.description,
                        style: GoogleFonts.openSans(
                          fontSize: isMobile ? 12 : 14,
                          color: Colors.grey[400],
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      // Tech Stack as Chips
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: project.techstack
                            .take(isMobile ? 3 : 5)
                            .map(
                              (tech) => Chip(
                                label: Text(
                                  tech,
                                  style: TextStyle(
                                    fontSize: isMobile ? 10 : 12,
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
                      const SizedBox(height: 12),
                      // Links
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _launchURL(project.link),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: isMobile ? 8 : 12,
                            ),
                          ),
                          child: Text(
                            "GitHub",
                            style: TextStyle(fontSize: isMobile ? 12 : 14),
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
