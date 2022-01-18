class UTDRoomsBackedException implements Exception {
  int statusCode;
  String cause;
  UTDRoomsBackedException(this.statusCode, this.cause);

  @override
  String toString() {
    return "(statusCode = $statusCode, cause = $cause)";
  }
}

class RoomTimeRangesRequestFailed extends UTDRoomsBackedException {
  RoomTimeRangesRequestFailed(int statusCode, String cause) : super(statusCode, cause);
}

class RoomScheduleRequestFailed extends UTDRoomsBackedException {
  RoomScheduleRequestFailed(int statusCode, String cause) : super(statusCode, cause);
}

class CheckIntoRoomFailed extends UTDRoomsBackedException {
  CheckIntoRoomFailed(int statusCode, String cause) : super(statusCode, cause);
}

class CheckOutOfRoomFailed extends UTDRoomsBackedException {
  CheckOutOfRoomFailed(int statusCode, String cause) : super(statusCode, cause);
}

class GetCheckedRoomsFailed extends UTDRoomsBackedException {
  GetCheckedRoomsFailed(int statusCode, String cause) : super(statusCode, cause);
}


class UnableToGetAllRooms extends UTDRoomsBackedException {
  UnableToGetAllRooms(int statusCode, String cause) : super(statusCode, cause);
}