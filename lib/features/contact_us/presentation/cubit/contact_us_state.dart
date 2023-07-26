part of 'contact_us_cubit.dart';

@immutable
abstract class ContactUsState {}

class ContactUsInitial extends ContactUsState {}
class ContactUsFailed extends ContactUsState {}
class ContactUsSuccess extends ContactUsState {}
