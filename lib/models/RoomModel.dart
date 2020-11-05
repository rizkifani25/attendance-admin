class RoomModel {
  final int id;
  final String room;

  RoomModel({
    this.id,
    this.room,
  });

  static List<RoomModel> getRoom() {
    return <RoomModel>[
      RoomModel(id: 1, room: 'B101'),
      RoomModel(id: 2, room: 'B102'),
      RoomModel(id: 3, room: 'B103'),
      RoomModel(id: 4, room: 'B104'),
      RoomModel(id: 5, room: 'B105'),
      RoomModel(id: 6, room: 'B106'),
      RoomModel(id: 7, room: 'B107'),
      RoomModel(id: 8, room: 'B108'),
      RoomModel(id: 9, room: 'B109'),
      RoomModel(id: 10, room: 'B110'),
      RoomModel(id: 11, room: 'B111'),
      RoomModel(id: 12, room: 'B201'),
    ];
  }
}
