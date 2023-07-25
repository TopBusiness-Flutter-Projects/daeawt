import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/model/InvitationDataModel.dart';
import '../../../core/remote/service.dart';

part 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  final ServiceApi api;
  List<InvitationModel> invitationsList = [];
  ScanCubit(this.api) : super(ScanInitial()){
    geInvitationsHome();
  }
  geInvitationsHome() async {
    //  print("ddldlldld0");
    // print(selectedIndividualType);
    invitationsList.clear();
    emit(InvitationsSacanLoading());
    final response = await api.getInvitationHome("");
    response.fold(
          (l) => emit(InvitationsSacanError()),
          (r) {
        invitationsList = r.data;
        emit(InvitationsSacanLoaded());
      },
    );
  }

}
