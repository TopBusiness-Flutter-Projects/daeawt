import 'package:dio/dio.dart';

import '../../home/models/contact_model.dart';

class AddInvitationModel {
  int id=0;
  List<ContactModel> selectedContactModelList = [];
  String title = '';
  String date = '';
  int has_qrcode = 0;
  int as_draft = 0;
  int send_date = 0;
  String address = '';
  double longitude = 0;
  double latitude = 0;
  String lang = 'ar';
  int step = 1;
  String image = '';

  bool isDataVaild1() {
    if (date.isNotEmpty &&
        title.isNotEmpty &&
        image.isNotEmpty &&
        address.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<Map<String, dynamic>> updateToJson() async => {
        "title": title,
        "address": address,
        "date": date,
        "has_qrcode": has_qrcode,
        "as_draft": as_draft,
        "send_date": send_date,
        "longitude": longitude,
        "latitude": latitude,
        "step": step,
        "lang": lang,
        if (image.isNotEmpty&&!image.contains("http")) ...{"image": await MultipartFile.fromFile(image)},
        if (selectedContactModelList.isNotEmpty) ...{
          for (int i = 0; i < selectedContactModelList.length; i++) ...{
            "invitees[$i][invitees_number]":
                selectedContactModelList.elementAt(i).numberOfInvitedPeople,
            "invitees[$i][name]": selectedContactModelList.elementAt(i).name,
            "invitees[$i][phone]":
                selectedContactModelList.elementAt(i).phones!.elementAt(0).value
          }
        }
      };
}
