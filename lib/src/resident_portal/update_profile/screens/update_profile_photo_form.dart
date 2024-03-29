import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/resident_portal/update_profile/update_profile.dart';

class UpdateProfilePhotoForm extends StatefulWidget {
  const UpdateProfilePhotoForm({super.key});

  @override
  State<UpdateProfilePhotoForm> createState() => _UpdateProfilePhotoFormState();
}

class _UpdateProfilePhotoFormState extends State<UpdateProfilePhotoForm> {
  File? fileController;
  String? webController;
  final defaultProfilePic = 'lib/src/assets/images/podium_logo_round.png';

  Future<void> takePhoto(ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: source,
      maxWidth: 150,
      maxHeight: 150,
      imageQuality: 75,
    );
    if (kIsWeb) {
      // ignore: cast_nullable_to_non_nullable
      final imagePath = image?.path as String;
      setState(() {
        webController = imagePath;
      });
    } else {
      final xfileToFile = File(image!.path);
      setState(() {
        fileController = xfileToFile;
      });
    }
  }

  CircleAvatar getNewProfilePic() {
    if (fileController != null && !kIsWeb) {
      return CircleAvatar(
        radius: 50,
        backgroundImage: Image.file(fileController!).image,
      );
    } else if (webController != null && kIsWeb) {
      // ignore: cast_nullable_to_non_nullable
      final fakeWebControl = webController as String;
      return CircleAvatar(
        radius: 50,
        backgroundImage: Image.network(fakeWebControl).image,
      );
    } else {
      return CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage(defaultProfilePic),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final changeUserPhoto =
        context.select((UpdateProfilePhotoCubit cubit) => cubit);
    CircleAvatar getProfilePic() {
      if (user.photo != null) {
        return CircleAvatar(
          radius: 50,
          backgroundImage: Image.network(user.photo!).image,
        );
      } else {
        return CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(defaultProfilePic),
        );
      }
    }

    getProfilePic();
    getNewProfilePic();
    return SizedBox(
      height: 300,
      width: 300,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text('Current Photo:'),
                  getProfilePic(),
                ],
              ),
              Column(
                children: [
                  const Text('New Photo:'),
                  getNewProfilePic(),
                ],
              ),
            ],
          ),
          PlatformElevatedButton(
            onPressed: () {
              takePhoto(ImageSource.camera);
            },
            child: const Row(
              children: [Icon(Icons.camera), Text('Camera')],
            ),
          ),
          PlatformElevatedButton(
            onPressed: () {
              takePhoto(ImageSource.gallery);
            },
            child: const Row(
              children: [Icon(Icons.camera_roll), Text('Gallery')],
            ),
          ),
          PlatformElevatedButton(
            onPressed: () {
              if (!kIsWeb) {
                changeUserPhoto.updateWithNewPicture(fileController);
                Navigator.pop(context);
              } else {
                // ignore: cast_nullable_to_non_nullable
                final newWebController = webController as String;
                changeUserPhoto.updateWithNewPictureWeb(newWebController);
                Navigator.pop(context);
              }
            },
            child: const Row(
              children: [Icon(Icons.save), Text('Save Picture')],
            ),
          ),
        ],
      ),
    );
  }
}
