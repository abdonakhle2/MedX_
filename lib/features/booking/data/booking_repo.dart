import 'package:dartz/dartz.dart';
import 'package:project_1/core/errors/failure.dart';
import 'package:project_1/models/appointments.dart';

abstract class BookingRepo {
  Future<Either<Failure, List<Appointments>>> getUserAppointments();
  Future<Either<Failure, void>> updateAppointmentNotes({
    required int appointmentId,
    required String userNotes,
  });
  Future<Either<Failure, void>> cancelAppointment({required int appointmentId});
  Future<Either<Failure, String>> Rating({
    required String appointmentId,
    required double rating,
  });
}
