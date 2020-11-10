class Room {
  final int id;
  final String room;

  Room({
    this.id,
    this.room,
  });

  static List<Room> getRoom() {
    return <Room>[
      Room(id: 1, room: 'B101'),
      Room(id: 2, room: 'B102'),
      Room(id: 3, room: 'B103'),
      Room(id: 4, room: 'B104'),
      Room(id: 5, room: 'B105'),
    ];
  }
}
