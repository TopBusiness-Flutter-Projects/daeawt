import 'package:daeawt/core/preferences/preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_share/flutter_share.dart';

import '../model/InvitationDataModel.dart';
import '../model/user_model.dart';

void shareInvitee(Invitee invitee, InvitationModel invitationModel,
    BuildContext context) async {
  Preferences.instance.getUserModel().then((value) async => {
        await FlutterShare.share(
            title: "المكرمة${invitee.name}\n${EasyLocalization.of(context)!
                            .currentLocale!
                            .languageCode ==
                    "ar"
                ? "نتشرف بدعوتكم لحضور "
                : "We are honored to invite you to attend "}\n${invitationModel.title}\n${"we_hope_open_link".tr()}\n",
            linkUrl: "${invitationModel.share_link}/${invitee.id}/${value.data!.user!.id!}")
      });
}
