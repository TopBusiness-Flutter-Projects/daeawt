import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';

class ContactModel {
  String? name;

  List<Item>? phones;

  bool? isSelected;
  String? title;

  int numberOfInvitedPeople=0;

  ContactModel({this.name, this.phones, this.isSelected=false,this.title="المكرم"});

  @override
  String toString() {
    return 'ContactModel{name: $name, phones: $phones, isSelected: $isSelected , title: $title}';
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
