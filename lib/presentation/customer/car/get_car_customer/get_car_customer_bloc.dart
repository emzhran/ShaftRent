import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaft_rent/data/repository/car_repository.dart';
import 'package:shaft_rent/presentation/customer/car/get_car_customer/get_car_customer_event.dart';
import 'package:shaft_rent/presentation/customer/car/get_car_customer/get_car_customer_state.dart';

class GetCarCustomerBloc extends Bloc<GetCarCustomerEvent, GetCarCustomerState> {
  final CarRepository carRepository;

  GetCarCustomerBloc({required this.carRepository}) : super(GetCarInitial()) {
    on<FetchCarsCustomer>((event, emit) async {
      emit(GetCarLoading());

      final result = await carRepository.getCars();
      result.fold(
        (error) => emit(GetCarError(message: error)),
        (cars) => emit(GetCarLoaded(cars: cars)),
      );
    });
  }
}
