import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaft_rent/data/repository/maps_repository.dart';
import 'package:shaft_rent/presentation/admin/maps/deletemaps/deletemaps_event.dart';
import 'package:shaft_rent/presentation/admin/maps/deletemaps/deletemaps_state.dart';

class DeleteMapsBloc extends Bloc<DeleteMapsEvent, DeleteMapsState> {
  final MapsRepository mapsRepository;

  DeleteMapsBloc({required this.mapsRepository}) : super(DeleteMapsInitial()) {
    on<DeleteMaps>(_onDeleteMaps);
  }

  Future<void> _onDeleteMaps(
    DeleteMaps event,
    Emitter<DeleteMapsState> emit,
  ) async {
    emit(DeleteMapsLoading());

    final result = await mapsRepository.deleteMap(event.mapId);

    result.fold(
      (error) => emit(DeleteMapsError(message: error)),
      (_) => emit(DeleteMapsSuccess()),
    );
  }
}
