import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../viewmodel/profile_viewmodel.dart';
import '../../components/circle_photo.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  String _photoUrl = '';
  bool _isImageFromFile = false;

  ///
  @override
  void initState() {
    super.initState();

    final profileViewModel = context.read<ProfileViewModel>();

    _photoUrl = (profileViewModel.profileUser.photoUrl == '')
        ? 'assets/images/no_image.png'
        : profileViewModel.profileUser.photoUrl;

    // ignore: avoid_bool_literals_in_conditional_expressions
    _isImageFromFile = (profileViewModel.profileUser.photoUrl == '') ? true : false;
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        title: Text(S.of(context).editProfile),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Center(child: CirclePhoto(radius: 60, photoUrl: _photoUrl, isImageFromFile: _isImageFromFile)),
              const SizedBox(height: 16),
              Center(
                child: InkWell(
                  onTap: _changeProfilePhoto,
                  child: Text(
                    S.of(context).changeProfilePhoto,
                    style: const TextStyle(fontSize: 20, color: Colors.blueAccent),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Name'),
              TextField(
                controller: nameController,
              ),
              const SizedBox(height: 16),
              const Text('Bio'),
              TextField(
                controller: bioController,
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  Future<void> _changeProfilePhoto() async {
    _isImageFromFile = false;

    final profileViewModel = context.read<ProfileViewModel>();

    _photoUrl = await profileViewModel.changeProfilePhoto();

    setState(() {
      _isImageFromFile = true;
    });
  }
}
