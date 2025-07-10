import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shaftrent/data/repository/profile_repository.dart';
import 'package:shaftrent/presentation/admin/dashboard/customer_profile/bloc/customer_profile_event.dart';
import 'package:shaftrent/presentation/admin/dashboard/customer_profile/bloc/customer_profile_state.dart';

class CustomerProfileBloc extends Bloc<CustomerProfileEvent, CustomerProfileState> {
  final ProfileRepository customerRepository;

  CustomerProfileBloc({required this.customerRepository}) : super(CustomerProfileInitial()) {
    on<FetchAllCustomer>(_onFetchAllCustomer);
    on<FetchCustomerDetail>(_onFetchCustomerDetail);
    on<SubmitUpdateStatus>(_onSubmitUpdateStatus);
  }

  Future<void> _onFetchAllCustomer(
    FetchAllCustomer event,
    Emitter<CustomerProfileState> emit,
  ) async {
    emit(CustomerProfileLoading());

    final result = await customerRepository.getAllCustomers();

    result.fold(
      (error) => emit(UpdateStatusError(message: error)),
      (profile) => emit(CustomerProfileLoaded(profile: profile.data)),
    );
  }

  Future<void> _onFetchCustomerDetail(
    FetchCustomerDetail event,
    Emitter<CustomerProfileState> emit,
  ) async {
    emit(CustomerProfileLoading());

    final result = await customerRepository.getCustomerDetail(event.customerId);

    result.fold(
      (error) => emit(UpdateStatusError(message: error)),
      (profile) => emit(CustomerDetailLoaded(profile: profile)),
    );
  }
 

  Future<void> _onSubmitUpdateStatus(
    SubmitUpdateStatus event,
    Emitter<CustomerProfileState> emit,
  ) async {
    emit(CustomerProfileLoading());

    final result = await customerRepository.updateStatusAccount(event.requestModel);

    result.fold(
      (error) => emit(UpdateStatusError(message: error)),
      (_) => emit(UpdateStatusSuccess()),
    );
  }
}
