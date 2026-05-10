import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileProvider with ChangeNotifier {
  final _supabase = Supabase.instance.client;
  Map<String, dynamic>? _userProfile;
  bool _isLoading = false;

  Map<String, dynamic>? get userProfile => _userProfile;
  bool get isLoading => _isLoading;

  Future<void> fetchProfile() async {
    try {
      _isLoading = true;
      notifyListeners();

      final user = _supabase.auth.currentUser;
      if (user == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      final data = await _supabase
          .from('users')
          .select()
          .eq('id', user.id)
          .single();
      
      _userProfile = data;
    } catch (e) {
      debugPrint('Error fetching profile: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String department,
    required String hostel,
    String? imageUrl,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final user = _supabase.auth.currentUser;
      if (user == null) return;

      final updates = {
        'name': name,
        'phone': phone,
        'department': department,
        'hostel': hostel,
        if (imageUrl != null) 'profile_image': imageUrl,
      };

      await _supabase
          .from('users')
          .update(updates)
          .eq('id', user.id);
      
      await fetchProfile();
    } catch (e) {
      debugPrint('Error updating profile: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> uploadProfileImage(File file) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return null;

      final fileName = '${user.id}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final path = 'profiles/$fileName';

      await _supabase.storage
          .from('avatars')
          .upload(path, file);

      final imageUrl = _supabase.storage
          .from('avatars')
          .getPublicUrl(path);
      
      return imageUrl;
    } catch (e) {
      debugPrint('Error uploading image: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
  }
}
