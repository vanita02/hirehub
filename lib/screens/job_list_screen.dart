import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/job_controller.dart';
import '../widgets/job_card.dart';

class JobListScreen extends StatelessWidget {
  final JobController controller = Get.put(JobController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4ECFD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB680F2), // light purple app bar
        elevation: 0,
        title: const Text(
          'HireHub',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextField(
                  onChanged: controller.searchJobs,
                  decoration: const InputDecoration(
                    hintText: 'Search jobs or companies',
                    prefixIcon: Icon(Icons.search, color: Color(0xFFB680F2)),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (controller.hasError.value) {
                return Center(
                  child: ElevatedButton(
                    onPressed: controller.fetchJobs,
                    child: Text('Try Again'),
                  ),
                );
              }

              return ListView.builder(
                itemCount: controller.filteredJobs.length,
                itemBuilder: (_, index) {
                  return JobCard(job: controller.filteredJobs[index]);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
