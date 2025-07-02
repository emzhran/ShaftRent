import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaft_rent/data/repository/car_repository.dart';
import 'package:shaft_rent/presentation/admin/car/updatecar/updatecar_event.dart';
import 'package:shaft_rent/presentation/admin/car/updatecar/updatecar_state.dart';

class UpdateCarBloc extends Bloc<UpdateCarEvent, UpdateCarState> {
  final CarRepository carRepository;

  UpdateCarBloc({required this.carRepository}) : super(UpdateCarInitial()) {
    on<UpdateCar>(_onUpdateCar);
  }

  Future<void> _onUpdateCar(
    UpdateCar event,
    Emitter<UpdateCarState> emit,
  ) async {
    emit(UpdateCarLoaded());

    final result = await carRepository.updateCar(event.carId, event.requestModel);

    result.fold(
      (error) => emit(UpdateCarError(message: error)),
      (_) => emit(UpdateCarSuccess()),
    );
  }
}
