import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';

class ContactModel extends Equatable{
  String? name;

  List<Item>? phones;

  bool? isSelected;

  int numberOfInvitedPeople=0;

  ContactModel({this.name, this.phones, this.isSelected=false});

  @override
  String toString() {
    return 'ContactModel{name: $name, phones: $phones, isSelected: $isSelected}';
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
