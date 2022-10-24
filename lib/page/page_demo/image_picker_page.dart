import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:report_app/common/const/const.dart';
import 'package:report_app/common/widgets/appbar.dart';
import 'package:report_app/common/widgets/mybutton.dart';
import 'package:report_app/common/widgets/toast_overlay.dart';
import 'package:report_app/service/api_service.dart';
import 'package:report_app/service/photo_service.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({Key? key}) : super(key: key);

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  final picker = ImagePicker();
  // XFile? file;

  var url = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Image Picker'),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          children: [
            // if (file != null) ...[Container(child: Image.file(File(file!.path)))],
            if(url.isNotEmpty)...{
              Image.network(url),
            },

            const SizedBox(height: 16,),
            Row(
              children: [

                Expanded(
                  child: MyButton(
                    textButton: 'Camera',
                    backgroundColor: Colors.cyan,
                    onTap: () {
                      selectImage(source: ImageSource.camera);
                    },
                  ),
                ),
                const SizedBox(
                  width: 32,
                ),
                Expanded(
                  child: MyButton(
                    textButton: 'Library',
                    backgroundColor: Colors.grey,
                    onTap: () {
                      selectImage(source: ImageSource.gallery);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future selectImage({required ImageSource source}) async {
    try {
      final image = await picker.pickImage(
        source: source,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 10,
      );
      if(image != null) {
        uploadData(image);
      }
    } catch (e) {
      ToastOverlay(context)
          .showToastOverlay(message: e.toString(), type: ToastType.error);
    }
  }
  void uploadData(XFile f) {
    print('path: ${f.path}');
    apiService.uploadAvatar(file: f).then((value) {
      print('url: $baseUrl${value.path}');
      setState(() {
        url = '$baseUrl${value.path}';
      });
    }).catchError((e) {
      ToastOverlay(context).showToastOverlay(message: 'Có lỗi xảy ra: ${e.toString()}', type: ToastType.error);
    });
  }
}
