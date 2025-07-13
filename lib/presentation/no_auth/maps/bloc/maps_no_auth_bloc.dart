import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/data/repository/maps_repository.dart';
import 'package:shaftrent/presentation/no_auth/maps/bloc/maps_no_auth_event.dart';
import 'package:shaftrent/presentation/no_auth/maps/bloc/maps_no_auth_state.dart';

class MapsNoAuthBloc extends Bloc<MapsNoAuthEvent, MapsNoAuthState> {
  final MapsRepository mapsRepository;

  MapsNoAuthBloc({required this.mapsRepository}) : super(MapsNoAuthInitial()) {
    on<GetMapsNoAuth>(_onGetMaps);
  }

  Future<void> _onGetMaps(GetMapsNoAuth event, Emitter<MapsNoAuthState> emit) async {
    final result = await mapsRepository.getMaps();
    result.fold(
      (l) => emit(MapsNoAuthFailure(message: l)),
      (r) => emit(MapsNoAuthLoaded(locations: r.data)),
    );
  }
}
