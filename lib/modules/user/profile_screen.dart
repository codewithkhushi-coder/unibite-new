import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/theme/app_colors.dart';
import '../../core/providers/profile_provider.dart';
import '../../core/routes/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _departmentController;
  late TextEditingController _hostelController;
  String _currentAddress = "Detecting location...";
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _departmentController = TextEditingController();
    _hostelController = TextEditingController();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).fetchProfile();
    });
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _departmentController.dispose();
    _hostelController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    
    if (pickedFile != null) {
      try {
        final provider = Provider.of<ProfileProvider>(context, listen: false);
        final imageUrl = await provider.uploadProfileImage(File(pickedFile.path));
        if (imageUrl != null) {
          await provider.updateProfile(
            name: _nameController.text,
            phone: _phoneController.text,
            department: _departmentController.text,
            hostel: _hostelController.text,
            imageUrl: imageUrl,
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error uploading image: $e')));
        }
      }
    }
  }

  Future<void> _saveProfile() async {
    try {
      await Provider.of<ProfileProvider>(context, listen: false).updateProfile(
        name: _nameController.text,
        phone: _phoneController.text,
        department: _departmentController.text,
        hostel: _hostelController.text,
      );
      setState(() => _isEditing = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!'), backgroundColor: AppColors.primaryPink),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error saving profile: $e')));
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      
      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        if (mounted) {
          setState(() {
            _currentAddress = "Campus Sector 12 (Lat: ${position.latitude.toStringAsFixed(2)})";
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _currentAddress = "University Campus Center");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24, color: AppColors.textPrimary)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (profileProvider.isLoading)
            const Center(child: Padding(padding: EdgeInsets.all(16), child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primaryPink))))
          else
            IconButton(
              icon: Icon(_isEditing ? LucideIcons.check : LucideIcons.edit3, color: AppColors.primaryPink),
              onPressed: () {
                if (_isEditing) {
                  _saveProfile();
                } else {
                  setState(() => _isEditing = true);
                }
              },
            ),
        ],
      ),
      body: profileProvider.isLoading && profileProvider.userProfile == null
          ? const Center(child: CircularProgressIndicator(color: AppColors.primaryPink))
          : _buildBody(profileProvider.userProfile),
    );
  }

  Widget _buildBody(Map<String, dynamic>? profile) {
    if (profile == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Please login to view your profile'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
              child: const Text('Go to Login'),
            ),
          ],
        ),
      );
    }

    if (!_isEditing) {
      _nameController.text = profile['name'] ?? '';
      _emailController.text = profile['email'] ?? '';
      _phoneController.text = profile['phone'] ?? '';
      _departmentController.text = profile['department'] ?? '';
      _hostelController.text = profile['hostel'] ?? '';
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        children: [
          _buildProfileHeader(profile['profile_image']),
          const SizedBox(height: 32),
          _buildInfoSection(),
          const SizedBox(height: 32),
          _buildAddressSection(),
          const SizedBox(height: 32),
          _buildSettingsSection(),
          const SizedBox(height: 40),
          _buildLogoutButton(),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(String? imageUrl) {
    return Column(
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: AppColors.primaryPink, shape: BoxShape.circle),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: imageUrl != null && imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
                  child: imageUrl == null || imageUrl.isEmpty ? const Icon(LucideIcons.user, size: 40, color: Colors.grey) : null,
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              right: 4,
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(color: AppColors.primaryPink, shape: BoxShape.circle),
                  child: const Icon(LucideIcons.camera, color: Colors.white, size: 18),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (!_isEditing) ...[
          Text(_nameController.text, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
          Text('${_departmentController.text} • ${_hostelController.text}', style: const TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
        ],
      ],
    );
  }

  Widget _buildInfoSection() {
    return _buildCard(
      title: 'Profile Information',
      child: Column(
        children: [
          _buildTextField(LucideIcons.user, 'Full Name', _nameController, _isEditing),
          const Divider(height: 1),
          _buildTextField(LucideIcons.mail, 'Email Address (Read Only)', _emailController, false),
          const Divider(height: 1),
          _buildTextField(LucideIcons.phone, 'Phone Number', _phoneController, _isEditing),
          const Divider(height: 1),
          _buildTextField(LucideIcons.building, 'Department', _departmentController, _isEditing),
          const Divider(height: 1),
          _buildTextField(LucideIcons.home, 'Hostel', _hostelController, _isEditing),
        ],
      ),
    );
  }

  Widget _buildTextField(IconData icon, String label, TextEditingController controller, bool enabled) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextField(
        controller: controller,
        enabled: enabled,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, size: 20, color: AppColors.primaryPink),
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildAddressSection() {
    return _buildCard(
      title: 'Location Context',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(LucideIcons.mapPin, color: AppColors.primaryPink),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(_currentAddress, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _getCurrentLocation,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryPink,
                  side: const BorderSide(color: AppColors.primaryPink),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Refresh Location'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection() {
    return _buildCard(
      title: 'Preferences',
      child: Column(
        children: [
          SwitchListTile(
            value: _notificationsEnabled,
            onChanged: (v) => setState(() => _notificationsEnabled = v),
            title: const Text('Push Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
            activeColor: AppColors.primaryPink,
          ),
          _buildSettingsItem(LucideIcons.shieldCheck, 'Privacy & Safety', ''),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryPink, size: 20),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: Text(value, style: const TextStyle(color: AppColors.textSecondary)),
      onTap: () {},
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: () async {
          await Provider.of<ProfileProvider>(context, listen: false).logout();
          if (mounted) Navigator.pushReplacementNamed(context, AppRoutes.login);
        },
        icon: const Icon(LucideIcons.logOut),
        label: const Text('Logout Session', style: TextStyle(fontWeight: FontWeight.w900)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.error,
          elevation: 0,
          side: const BorderSide(color: AppColors.error, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title.toUpperCase(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.textSecondary, letterSpacing: 1.5)),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 4))],
          ),
          child: ClipRRect(borderRadius: BorderRadius.circular(24), child: child),
        ),
      ],
    );
  }
}