import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaft_rent/data/repository/car_repository.dart';
import 'package:shaft_rent/presentation/admin/car/getcar/getcar_event.dart';
import 'package:shaft_rent/presentation/admin/car/getcar/getcar_state.dart';

class GetCarBloc extends Bloc<GetCarEvent, GetCarState> {
  final CarRepository carRepository;

  GetCarBloc({required this.carRepository}) : super(GetCarInitial()) {
    on<FetchCars>((event, emit) async {
      emit(GetCarLoading());

      final result = await carRepository.getCars();
      result.fold(
        (error) => emit(GetCarError(message: error)),
        (cars) => emit(GetCarLoaded(cars: cars)),
      );
    });
  }
}
