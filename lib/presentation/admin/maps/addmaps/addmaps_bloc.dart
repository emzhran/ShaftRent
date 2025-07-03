import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaft_rent/data/repository/maps_repository.dart';
import 'package:shaft_rent/presentation/admin/maps/addmaps/addmaps_event.dart';
import 'package:shaft_rent/presentation/admin/maps/addmaps/addmaps_state.dart';

class AddMapsBloc extends Bloc<AddMapsEvent, AddMapsState> {
  final MapsRepository mapsRepository;

  AddMapsBloc({required this.mapsRepository}) : super(AddMapsInitial()) {
    on<AddMaps>(_onAddMaps);
  }

  Future<void> _onAddMaps(
    AddMaps event,
    Emitter<AddMapsState> emit,
  ) async {
    emit(AddMapsLoading());

    final result = await mapsRepository.addMap(event.requestModel);

    result.fold(
      (error) => emit(AddMapsError(message: error)),
      (addMapsModel) => emit(
        AddMapsSuccess(map: addMapsModel.map!),
      ),
    );
  }
}
