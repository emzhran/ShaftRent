import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaft_rent/data/repository/maps_repository.dart';
import 'package:shaft_rent/presentation/admin/maps/getmaps/getmaps_event.dart';
import 'package:shaft_rent/presentation/admin/maps/getmaps/getmaps_state.dart';
import 'package:shaft_rent/data/model/response/maps_response_model.dart';

class GetMapsBloc extends Bloc<GetMapsEvent, GetMapsState> {
  final MapsRepository mapsRepository;

  GetMapsBloc({required this.mapsRepository}) : super(GetMapsInitial()) {
    on<FetchMaps>(_onFetchMaps);
  }

  Future<void> _onFetchMaps(
    FetchMaps event,
    Emitter<GetMapsState> emit,
  ) async {
    emit(GetMapsLoading());

    final result = await mapsRepository.getMaps();

    result.fold(
      (error) => emit(GetMapsError(message: error)),
      (mapsResponse) {
        final List<Maps> mapsWithStaticUrls = mapsResponse.data.map((mapItem) {
          final updatedMapItem = mapItem.copyWith(
            staticMapImageUrl: mapsRepository.getStaticMapImageUrl(
              mapItem.latitude,
              mapItem.longitude,
            ),
          );
          return updatedMapItem;
        }).toList();
        emit(GetMapsLoaded(maps: mapsWithStaticUrls));
      },
    );
  }
}