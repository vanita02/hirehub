import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/job_model.dart';

class JobDetailScreen extends StatelessWidget {
  final JobModel job;

  JobDetailScreen({required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4ECFD),
      appBar: AppBar(
        backgroundColor: Color(0xFFB680F2),
        elevation: 0,
        centerTitle: true,
        title: Text(
          job.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// 🔲 BRAND COLOR BOXES (Company + Location)
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _InfoBox(
                        icon: Icons.business,
                        text: job.companyName,
                      ),
                      _InfoBox(
                        icon: Icons.location_on,
                        text: job.location,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// 📄 DESCRIPTION CONTAINER
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Html(
                      data: job.description,
                      style: {
                        "body": Style(
                          fontSize: FontSize(15),
                          lineHeight: LineHeight(1.7),
                          color: Colors.black87,
                        ),
                        "h2": Style(
                          fontSize: FontSize(18),
                          fontWeight: FontWeight.bold,
                        ),
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 🚀 STICKY APPLY BUTTON
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFB680F2).withOpacity(0.2),
                  blurRadius: 10,
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFB680F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  final uri = Uri.parse(job.url);
                  if (await canLaunchUrl(uri)) {
                    launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
                child: const Text(
                  'Apply Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class _InfoBox extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoBox({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFFB680F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
