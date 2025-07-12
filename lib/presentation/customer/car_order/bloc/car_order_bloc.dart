import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/data/model/response/car_response_model.dart';
import 'package:shaftrent/data/repository/car_repository.dart';
import 'package:shaftrent/data/repository/order_car_repository.dart';
import 'package:shaftrent/presentation/customer/car_order/bloc/car_order_event.dart';
import 'package:shaftrent/presentation/customer/car_order/bloc/car_order_state.dart';

class CarOrderBloc extends Bloc<CarOrderEvent, CarOrderState> {
  final CarRepository carRepository;
  final CarOrderRepository carOrderRepository;

  CarOrderBloc({
    required this.carRepository,
    required this.carOrderRepository,
  }) : super(CarOrderInitial()) {
    on<FetchCarsCustomer>(_onFetchCars);
    on<SearchCarsCustomer>(_onSearchCarsCustomer);
    on<FilterCarsCustomer>(_onFilterCarsCustomer);
    on<ResetSearchCustomer>(_onResetSearchCustomer);
    on<OrderCarSubmitted>(_onOrderCarSubmitted);
  }

  List<Car> _allCars = [];

  Future<void> _onFetchCars(
    FetchCarsCustomer event,
    Emitter<CarOrderState> emit,
  ) async {
    emit(CarOrderLoading());
    final result = await carRepository.getCars();
    result.fold(
      (error) => emit(CarOrderError(error: error)),
      (response) {
        _allCars = response.data;
        emit(CarOrderLoadSuccess(cars: _allCars, filteredCars: _allCars));
      },
    );
  }

  void _onSearchCarsCustomer(
    SearchCarsCustomer event,
    Emitter<CarOrderState> emit,
  ) {
    final keyword = event.keyword.toLowerCase();
    final filtered = _allCars.where((car) {
      return car.namaMobil.toLowerCase().contains(keyword);
    }).toList();
    emit(CarOrderLoadSuccess(cars: _allCars, filteredCars: filtered));
  }

  void _onFilterCarsCustomer(
    FilterCarsCustomer event,
    Emitter<CarOrderState> emit,
  ) {
    List<Car> filtered = [..._allCars];

    if (event.transmisi != null) {
      filtered = filtered
          .where((car) =>
              car.transmisi.toLowerCase() == event.transmisi!.toLowerCase())
          .toList();
    }

    if (event.sortByHarga != null) {
      if (event.sortByHarga == 'asc') {
        filtered.sort((a, b) => a.hargaMobil.compareTo(b.hargaMobil));
      } else if (event.sortByHarga == 'desc') {
        filtered.sort((a, b) => b.hargaMobil.compareTo(a.hargaMobil));
      }
    }

    emit(CarOrderLoadSuccess(cars: _allCars, filteredCars: filtered));
  }

  void _onResetSearchCustomer(
    ResetSearchCustomer event,
    Emitter<CarOrderState> emit,
  ) {
    emit(CarOrderLoadSuccess(cars: _allCars, filteredCars: _allCars));
  }

  Future<void> _onOrderCarSubmitted(
    OrderCarSubmitted event,
    Emitter<CarOrderState> emit,
  ) async {
    emit(CarOrderLoading());
    final result = await carOrderRepository.orderCar(event.request);
    result.fold(
      (error) => emit(CarOrderError(error: error)),
      (response) => emit(
        CarOrderSuccess(message: response.message, order: response.data),
      ),
    );
  }
}
