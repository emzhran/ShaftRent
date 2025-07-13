import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/data/repository/maps_repository.dart';
import 'package:shaftrent/presentation/customer/maps_customer/bloc/maps_customer_event.dart';
import 'package:shaftrent/presentation/customer/maps_customer/bloc/maps_customer_state.dart';

class MapsCustomerBloc extends Bloc<MapsCustomerEvent, MapsCustomerState> {
  final MapsRepository mapsRepository;

  MapsCustomerBloc({required this.mapsRepository}) : super(MapsInitial()) {
    on<GetMaps>(_onGetMaps);
    on<GetMapById>(_onGetMapById);
  }

  Future<void> _onGetMaps(
    GetMaps event,
    Emitter<MapsCustomerState> emit,
  ) async {
    emit(MapsLoading());
    final result = await mapsRepository.getMaps();
    result.fold(
      (error) => emit(MapsError(error)),
      (data) => emit(MapsLoaded(data.data)),
    );
  }

  Future<void> _onGetMapById(
    GetMapById event,
    Emitter<MapsCustomerState> emit,
  ) async {
    emit(MapsLoading());
    final result = await mapsRepository.getMapById(event.id.toString());
    result.fold(
      (error) => emit(MapsError(error)),
      (data) => emit(MapByIdLoaded(data.data)),
    );
  }
}
