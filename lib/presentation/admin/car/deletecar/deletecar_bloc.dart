import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaft_rent/data/repository/car_repository.dart';
import 'package:shaft_rent/presentation/admin/car/deletecar/deletecar_event.dart';
import 'package:shaft_rent/presentation/admin/car/deletecar/deletecar_state.dart';

class DeleteCarBloc extends Bloc<DeleteCarEvent, DeleteCarState> {
  final CarRepository carRepository;

  DeleteCarBloc({required this.carRepository}) : super(DeleteCarInitial()) {
    on<DeleteCar>(_onDeleteCar);
  }

  Future<void> _onDeleteCar(
    DeleteCar event,
    Emitter<DeleteCarState> emit,
  ) async {
    emit(DeleteCarLoading());

    final result = await carRepository.deleteCar(event.carId);

    result.fold(
      (error) => emit(DeleteCarError(message: error)),
      (_) => emit(DeleteCarSuccess()),
    );
  }
}
