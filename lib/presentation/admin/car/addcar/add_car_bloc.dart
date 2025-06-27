import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaft_rent_app/data/repository/car_repository.dart';
import 'package:shaft_rent_app/presentation/admin/car/addcar/add_car_event.dart';
import 'package:shaft_rent_app/presentation/admin/car/addcar/add_car_state.dart';

class AddCarBloc extends Bloc<AddCarEvent, AddCarState> {
  final CarRepository carRepository;

  AddCarBloc({required this.carRepository}) : super(AddCarInitial()) {
    on<AddCar>(_onAddCar);
    on<GetCarEvent>(_onGetCarEvent);
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

  Future<void> _onGetCarEvent(
    GetCarEvent event,
    Emitter<AddCarState> emit,
  ) async {
    emit(AddCarLoading());

    final result = await carRepository.getCars();

    result.fold(
      (error) => emit(AddCarError(message: error)),
      (cars) => emit(AddCarLoaded(cars: cars)),
    );
  }
}