import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/job_model.dart';
import '../controllers/job_controller.dart';
import '../screens/job_detail_screen.dart';

class JobCard extends StatelessWidget {
  final JobModel job;
  final JobController controller = Get.find();

  JobCard({required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFB680F2),
      // lighter purple card
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Get.to(() => JobDetailScreen(job: job)),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      job.companyName,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      job.location,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              /// Save / Bookmark button
              IconButton(
                icon: Icon(
                  job.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: const Color(0xFF424242), // light black
                ),
                onPressed: () => controller.toggleBookmark(job),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
