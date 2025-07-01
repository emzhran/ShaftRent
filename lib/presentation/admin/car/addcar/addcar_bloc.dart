import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaft_rent/data/repository/car_repository.dart';
import 'package:shaft_rent/presentation/admin/car/addcar/addcar_event.dart';
import 'package:shaft_rent/presentation/admin/car/addcar/addcar_state.dart';

class AddCarBloc extends Bloc<AddCarEvent, AddCarState> {
  final CarRepository carRepository;

  AddCarBloc({required this.carRepository}) : super(AddCarInitial()) {
    on<AddCar>(_onAddCar);
  }

  Future<void> _onAddCar(
    AddCar event,
    Emitter<AddCarState> emit,
  ) async {
    emit(AddCarLoading());

    final result = await carRepository.addCar(event.requestModel);

    result.fold(
      (error) => emit(AddCarError(message: error)),
      (addCarModel) => emit(
        AddCarSuccess(car: addCarModel.car!),
      ),
    );
  }
}
