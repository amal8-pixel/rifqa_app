abstract class TripMembersState {
  final int membersCount;

  const TripMembersState(this.membersCount);
}

class TripMembersInitial extends TripMembersState {
  const TripMembersInitial() : super(7);
}

class TripMembersLoading extends TripMembersState {
  const TripMembersLoading(super.membersCount);
}

class TripMembersSuccess extends TripMembersState {
  const TripMembersSuccess(super.membersCount);
}

class TripMembersError extends TripMembersState {
  final String message;

  const TripMembersError(super.membersCount, this.message);
}
