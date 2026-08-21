import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_1/features/home/data/repo/home_repo/home_repo.dart';
import 'package:project_1/features/home/presentation/manager/home_cubit/home_state.dart';
import 'package:project_1/models/clinic.dart';
import 'package:project_1/models/department.dart';
import 'package:project_1/models/doctor.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;

  HomeCubit(this.homeRepo) : super(HomeInitial());

  List<ClinicModel> clinics = [];
  Map<String, List<Department>> clinicDepartments = {};

  Future<void> fetchClinics() async {
    if (clinics.isNotEmpty) {
      emit(HomeSuccess(clinics));
      return;
    }
    emit(HomeLoading());
    var result = await homeRepo.getClinics();
    result.fold(
      (failure) {
        emit(HomeFailure(failure.errorMessage));
      },
      (fetchedClinics) {
        clinics = fetchedClinics;
        emit(HomeSuccess(clinics));
      },
    );
  }

  Future<void> fetchClinicDepartments(String clinicId) async {
    if (clinicDepartments.containsKey(clinicId) &&
        clinicDepartments[clinicId]!.isNotEmpty) {
      emit(HomeSuccess(clinics));
      return;
    }

    var result = await homeRepo.getClinicDepartments(clinicId);
    result.fold(
      (failure) {
        emit(HomeFailure(failure.errorMessage));
      },
      (departments) {
        clinicDepartments[clinicId] = departments;
        emit(HomeSuccess(clinics));
      },
    );
  }

  Map<String, List<Doctor>> departmentDoctors = {};

  Future<void> fetchDoctorsByDepartment(String departmentId) async {
    if (departmentDoctors.containsKey(departmentId) &&
        departmentDoctors[departmentId]!.isNotEmpty) {
      emit(HomeSuccess(clinics));
      return;
    }

    emit(HomeLoading());
    var result = await homeRepo.getDoctorsByDepartment(departmentId);
    result.fold(
      (failure) {
        emit(HomeFailure(failure.errorMessage));
      },
      (doctors) {
        departmentDoctors[departmentId] = doctors;
        emit(HomeSuccess(clinics));
      },
    );
  }

  List<Doctor> allDoctors = [];

  Future<void> fetchAllDoctors() async {
    if (allDoctors.isNotEmpty) {
      emit(HomeSuccess(clinics));
      return;
    }

    emit(HomeLoading());
    var result = await homeRepo.getAllDoctors();
    result.fold(
      (failure) {
        emit(HomeFailure(failure.errorMessage));
      },
      (doctors) {
        allDoctors = doctors;
        emit(HomeSuccess(clinics));
      },
    );
  }

  Future<void> fetchAllDoctorsViaDepartments() async {
    // إضافة فحص للحالة الحالية لمنع إعادة الجلب دون داعٍ
    if (allDoctors.isNotEmpty || state is HomeLoading) {
      return;
    }

    emit(HomeLoading());

    List<Doctor> doctors = await homeRepo.getAllDoctorsUsingDepartments(
      maxDepartments: 20,
    );

    if (doctors.isNotEmpty) {
      allDoctors = doctors;
      emit(HomeSuccess(clinics));
    } else {
      emit(HomeFailure('there is no doctors'));
    }
  }
}
