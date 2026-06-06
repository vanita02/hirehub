import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/job_model.dart';

class ApiService {
  static const String baseUrl =
      'https://www.arbeitnow.com/api/job-board-api';

  static Future<List<JobModel>> fetchJobs() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List jobs = data['data'];
      return jobs.map((e) => JobModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load jobs');
    }
  }
}