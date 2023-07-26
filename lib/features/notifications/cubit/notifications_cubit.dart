import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/model/notification.dart';
import '../../../core/remote/service.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final ServiceApi api;
  List<NotificationModel> invitationsList = [];

  NotificationsCubit(this.api) : super(NotificationsInitial()){
    getNotifications();
  }
  getNotifications() async {
    //  print("ddldlldld0");
    // print(selectedIndividualType);
    invitationsList.clear();
    emit(NotificationLoading());
    final response = await api.getnotifications();
    response.fold(
          (l) => emit(NotificationError()),
          (r) {
        invitationsList = r.data;
        emit(NotificationLoaded());
      },
    );
  }

}
