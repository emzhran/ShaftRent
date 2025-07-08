import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/data/repository/maps_repository.dart';
import 'package:shaftrent/presentation/admin/maps/bloc/maps_event.dart';
import 'package:shaftrent/presentation/admin/maps/bloc/maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  final MapsRepository mapsRepository;

  MapsBloc({required this.mapsRepository}) : super(MapsInitial()) {
    on<FetchMaps>(_onFetchMaps);
    on<AddMap>(_onAddMap);
    on<UpdateMap>(_onUpdateMap);
    on<DeleteMap>(_onDeleteMap);
  }

  Future<void> _onFetchMaps(FetchMaps event, Emitter<MapsState> emit) async {
    final result = await mapsRepository.getMaps();
    result.fold(
      (error) => emit(MapsError(message: error)),
      (mapsResponse) {
        final updated = mapsResponse.data.map(
          (m) => m.copyWith(),
        ).toList();
        emit(MapsLoaded(maps: updated));
      },
    );
  }

  Future<void> _onAddMap(AddMap event, Emitter<MapsState> emit) async {
    final result = await mapsRepository.addMap(event.requestModel);
    result.fold(
      (error) => emit(MapsError(message: error)),
      (data) => emit(MapAdded(map: data.map!)),
    );
  }

  Future<void> _onUpdateMap(UpdateMap event, Emitter<MapsState> emit) async {
    final result = await mapsRepository.updateMap(event.mapId, event.requestModel);
    result.fold(
      (error) => emit(MapsError(message: error)),
      (_) => emit(MapUpdated()),
    );
  }

  Future<void> _onDeleteMap(DeleteMap event, Emitter<MapsState> emit) async {
    final result = await mapsRepository.deleteMap(event.mapId);
    result.fold(
      (error) => emit(MapsError(message: error)),
      (_) => emit(MapDeleted()),
    );
  }
}