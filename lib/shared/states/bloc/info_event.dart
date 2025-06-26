part of 'info_bloc.dart';

abstract class InfoEvent {}

class GetFacultiesEvent extends InfoEvent {}

class GetMajorsEvent extends InfoEvent {
  final String facultyId;
  GetMajorsEvent({required this.facultyId});
}
