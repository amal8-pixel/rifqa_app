import 'package:flutter_bloc/flutter_bloc.dart';
import 'trip_members_state.dart';

class TripMembersCubit extends Cubit<TripMembersState> {
  TripMembersCubit() : super(const TripMembersInitial());
  void increase() {
    final current = state.membersCount;
    emit(TripMembersLoading(current));
    emit(TripMembersSuccess(current + 1));
  }

  void decrease() {
    final current = state.membersCount;
    if (current <= 1) {
      emit(
        TripMembersError(
          current,
          'لا يمكن أن يكون عدد الأعضاء أقل من 1',
        ),
      );
      return;
    }

    emit(TripMembersLoading(current));
    emit(TripMembersSuccess(current - 1));
  }
}
