import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/data/repository/profile_repository.dart';
import 'package:shaftrent/presentation/customer/dashboard/profile/bloc/profile_event.dart';
import 'package:shaftrent/presentation/customer/dashboard/profile/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc({required this.profileRepository}) : super(ProfileInitial()) {
    on<FetchProfile>(_onFetchProfile);
    on<AddProfile>(_onAddProfile);
  }

  Future<void> _onFetchProfile(FetchProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await profileRepository.getProfile(); 
    result.fold(
      (error) {
        if (error == 'Profil belum lengkap.') {
          emit(ProfileEmpty());
        } else {
          emit(ProfileError(message: error));
        }
      },
      (profileResponse) {
        emit(ProfileLoaded(profile: profileResponse.data)); 
        },
    );
  }

  Future<void> _onAddProfile(AddProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await profileRepository.addProfile(event.requestModel);
    result.fold(
      (error) => emit(ProfileError(message: error)),
      (_) => emit(ProfileSuccess()),
    );
  }
}