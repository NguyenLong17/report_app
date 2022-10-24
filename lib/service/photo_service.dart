
import 'package:image_picker/image_picker.dart';
import 'package:report_app/model/photo.dart';
import 'package:report_app/service/api_service.dart';

extension PhotoService on APIService {
  Future<Photo> uploadAvatar({
    required XFile file
  }) async {
    final result  = await request(path: '/api/upload',file: file);
    final photo = Photo.fromJson(result);

    return photo;
  }

}
