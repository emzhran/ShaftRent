import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaft_rent/data/repository/maps_repository.dart';
import 'package:shaft_rent/presentation/admin/maps/updatemaps/updatemaps_event.dart';
import 'package:shaft_rent/presentation/admin/maps/updatemaps/updatemaps_state.dart';

class UpdateMapsBloc extends Bloc<UpdateMapsEvent, UpdateMapsState> {
  final MapsRepository mapsRepository;

  UpdateMapsBloc({required this.mapsRepository}) : super(UpdateMapsInitial()) {
    on<UpdateMaps>(_onUpdateMaps);
  }

  Future<void> _onUpdateMaps(
    UpdateMaps event,
    Emitter<UpdateMapsState> emit,
  ) async {
    emit(UpdateMapsLoading());

    final result = await mapsRepository.updateMap(event.mapId, event.requestModel);

    result.fold(
      (error) => emit(UpdateMapsError(message: error)),
      (_) => emit(UpdateMapsSuccess()),
    );
  }
}
