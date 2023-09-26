import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:first_app/model/user_details.dart'; // Import your UserDataModel here

class UserProvider extends ChangeNotifier {
  static const apiEndpoint = "https://jsonplaceholder.typicode.com/posts";

  bool isLoading = false;
  String error = '';
  List<UserDataModel> userData = [];

  Future<void> getDataFromAPI() async {
    isLoading = true;
    try {
      final response = await http.get(Uri.parse(apiEndpoint));
      if (response.statusCode == 200) {
        debugPrint("Request successful");
        final List<dynamic> jsonData = json.decode(response.body);
        userData =
            jsonData.map((json) => UserDataModel.fromJson(json)).toList();
        error = '';
      } else {
        error = response.reasonPhrase!;
      }
    } catch (e) {
      debugPrint("Exception: $e");
      error = 'An error occurred while fetching data.';
    } finally {
      isLoading = false;
      notifyListeners(); // Notify listeners once, after the operation is complete
    }
  }
}
