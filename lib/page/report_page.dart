import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:report_app/bloc/issue_bloc.dart';
import 'package:report_app/common/const/const.dart';
import 'package:report_app/common/widgets/appbar.dart';
import 'package:report_app/common/widgets/mybutton.dart';
import 'package:report_app/common/widgets/mytextfield.dart';
import 'package:report_app/common/widgets/toast_overlay.dart';
import 'package:report_app/model/issue.dart';
import 'package:report_app/service/api_service.dart';
import 'package:report_app/service/issue_service.dart';
import 'package:report_app/service/photo_service.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();


  final picker = ImagePicker();
  late IssueBloc bloc;

  @override
  void initState() {
    bloc = IssueBloc(context);
    super.initState();
  }

  var url = '';
  List<String> photos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Báo cáo'),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return StreamBuilder<Issue>(
      stream: bloc.streamIssue,
      builder: (context, snapshot) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextField(
                controller: _titleController,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                labelText: 'Tiêu đề',
              ),
              const SizedBox(
                height: 16,
              ),
              MyTextField(
                controller: _contentController,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.text,
                labelText: 'Nội dung',
                minLines: 10,
              ),
              const SizedBox(
                height: 16,
              ),
              buildGridViewImage(),
              const SizedBox(
                height: 16,
              ),
              MyButton(
                textButton: 'Save',
                textColor: Colors.black,
                backgroundColor: Colors.greenAccent,
                onTap: () {
                  reportIssue();
                },
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildGridViewImage() {
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {

            final newImage = photos[index];

            return Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                    height: 64,
                    width: 64,
                    child: Image.network(newImage),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                    },
                    icon: const Icon(
                      Icons.remove_circle_outline_sharp,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            );

          },
          itemCount: photos.length ,
        ),
        MyButton(
            textButton: 'Thêm',
            textColor: Colors.black,
            backgroundColor: Colors.green,
            onTap: () {
              selectImage(source: ImageSource.gallery);
            }),
      ],
    );
  }

  void reportIssue() {
    apiService.reportIssue(
      title: _titleController.text ?? '',
      content: _contentController.text ?? '',
      photos: photos.join('|') ?? '',
    ).then((issue) {
      bloc.reportIssue(issue: issue);
      ToastOverlay(context).showToastOverlay(
          message: 'Đã thêm bài viết ${issue.title} thành công',
          type: ToastType.success);
    }).catchError((e) {
      ToastOverlay(context).showToastOverlay(
          message: 'Có lỗi xảy ra: ${e.toString()}: ', type: ToastType.error);
    });
  }

  Future selectImage({required ImageSource source}) async {
    try {
      final image = await picker.pickImage(
        source: source,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 10,
      );
      if (image != null) {
        uploadData(image);
        // photos.add(image);
      }
    } catch (e) {
      ToastOverlay(context)
          .showToastOverlay(message: e.toString(), type: ToastType.error);
    }
  }

  void uploadData(XFile f) {
    print('path: ${f.path}');
    apiService.uploadAvatar(file: f).then((value) {
      setState(() {
        url = '$baseUrl${value.path}';
        photos.add(url);
        print('So anh dang co ${photos.length}');
      });
    }).catchError((e) {
      ToastOverlay(context).showToastOverlay(
          message: 'Có lỗi xảy ra: ${e.toString()}', type: ToastType.error);
    });
  }
}
