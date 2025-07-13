import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/data/repository/car_repository.dart';
import 'package:shaftrent/presentation/admin/car/bloc/car_event.dart';
import 'package:shaftrent/presentation/admin/car/bloc/car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final CarRepository carRepository;

  CarBloc({required this.carRepository}) : super(CarInitial()) {
    on<FetchCars>(_onFetchCars);
    on<AddCar>(_onAddCar);
    on<UpdateCar>(_onUpdateCar);
    on<DeleteCar>(_onDeleteCar);
  }

  Future<void> _onFetchCars(FetchCars event, Emitter<CarState> emit) async {
    final result = await carRepository.getCars();
    result.fold(
      (error) => emit(CarError(message: error)),
      (cars) => emit(CarListLoaded(cars: cars)),
    );
  }

  Future<void> _onAddCar(AddCar event, Emitter<CarState> emit) async {
    emit(CarLoading());
    final result = await carRepository.addCar(event.requestModel);
    await result.fold(
      (error) async => emit(CarError(message: error)),
      (_) async {
        final fetchResult = await carRepository.getCars();
        fetchResult.fold(
          (error) => emit(CarError(message: error)),
          (cars) => emit(CarListLoaded(cars: cars)),
        );
      },
    );
  }

  Future<void> _onUpdateCar(UpdateCar event, Emitter<CarState> emit) async {
  emit(CarLoading());

  final result = await carRepository.updateCar(event.carId, event.requestModel);
  await result.fold(
    (error) async {
      emit(CarError(message: error));
    },
    (_) async {
      emit(CarUpdated());
      final fetchResult = await carRepository.getCars();
      fetchResult.fold(
        (error) => emit(CarError(message: error)),
        (cars) => emit(CarListLoaded(cars: cars)),
        );
      },
    );
  }

  Future<void> _onDeleteCar(DeleteCar event, Emitter<CarState> emit) async {
    final result = await carRepository.deleteCar(event.carId);
    result.fold(
      (error) => emit(CarError(message: error)),
      (_) => emit(CarDeleted()),
    );
  }
}