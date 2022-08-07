import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase/supabase.dart';

import '../models/user.role.dart';

class AuthService extends GetxController {
  final supabaseClient = Get.find<SupabaseClient>();

  Future<GotrueSessionResponse> register(
      String name, String email, String password, Role role) async {
    try {
      final user = await supabaseClient.auth.signUp(email, password);
      final response = await supabaseClient.from('users').insert([
        {"id": user.user?.id, "name": name, "email": email, 'role': 'admin'}
      ]).execute();

      print("register response: ${response.error}");
      if (response.error == null) {
        return user;
      }
    } catch (e) {
      print(e);
    }
    throw ErrorDescription('register error');
  }

  Future<GotrueSessionResponse> login(String email, password) async {
    final storage = Get.find<GetStorage>();

    try {
      final response =
          await supabaseClient.auth.signIn(email: email, password: password);
      await storage.write('user', response.data?.persistSessionString);
      return response;
    } catch (e) {
      print(e);
      throw Error();
    }
  }

  void signOut() async {
    final response = await supabaseClient.auth.signOut();

    if (response.error != null) {
      // Error
      log('Error: ${response.error?.message}');
    } else {
      // Success
      log('Success');
    }
  }

  User? getCurrentUser() {
    return supabaseClient.auth.user();
  }

  Future<GotrueSessionResponse> recoverSession(String session) async {
    return await supabaseClient.auth.recoverSession(session);
  }
}
