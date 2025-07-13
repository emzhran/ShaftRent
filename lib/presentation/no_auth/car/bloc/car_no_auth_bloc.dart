import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/data/repository/car_repository.dart';
import 'package:shaftrent/presentation/no_auth/car/bloc/car_no_auth_event.dart';
import 'package:shaftrent/presentation/no_auth/car/bloc/car_no_auth_state.dart';

class CarNoAuthBloc extends Bloc<CarNoAuthEvent, CarNoAuthState> {
  final CarRepository carRepository;

  CarNoAuthBloc({required this.carRepository}) : super(CarNoAuthInitial()) {
    on<GetCarsNoAuth>(_onGetCars);
  }

  Future<void> _onGetCars(GetCarsNoAuth event, Emitter<CarNoAuthState> emit) async {
    final result = await carRepository.getCars();
    result.fold(
      (l) => emit(CarNoAuthFailure(message: l)),
      (r) => emit(CarNoAuthLoaded(cars: r.data)),
    );
  }
}
