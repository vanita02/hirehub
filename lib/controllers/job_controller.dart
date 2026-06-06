import 'package:get/get.dart';
import '../models/job_model.dart';
import '../services/api_service.dart';

class JobController extends GetxController {
  var isLoading = true.obs;
  var jobList = <JobModel>[].obs;
  var filteredJobs = <JobModel>[].obs;
  var hasError = false.obs;

  @override
  void onInit() {
    fetchJobs();
    super.onInit();
  }

  void fetchJobs() async {
    try {
      isLoading(true);
      hasError(false);
      final jobs = await ApiService.fetchJobs();
      jobList.assignAll(jobs);
      filteredJobs.assignAll(jobs);
    } catch (e) {
      hasError(true);
    } finally {
      isLoading(false);
    }
  }

  void searchJobs(String query) {
    filteredJobs.assignAll(
      jobList.where((job) =>
      job.title.toLowerCase().contains(query.toLowerCase()) ||
          job.companyName.toLowerCase().contains(query.toLowerCase())),
    );
  }

  void toggleBookmark(JobModel job) {
    job.isBookmarked = !job.isBookmarked;
    filteredJobs.refresh();
  }
}