import '../../home/models/contact_model.dart';

class AddInvitationModel {
  List<ContactModel> selectedContactModelList = [];
  String title='';
  String date='';
 int  has_qrcode=0;
 int  as_draft=0;
 int send_date=0;
String  address='';
 double longitude=0;
 double latitude=0;
  int step=1;
String image='';

bool isDataVaild1(){
  if(date.isNotEmpty&&title.isNotEmpty&&image.isNotEmpty&&address.isNotEmpty){
    return true;
  }
  return false;
}


}
