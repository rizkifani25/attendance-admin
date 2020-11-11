class Major {
  final int id;
  final String major;
  final String abbreviation;
  final String majorCode;

  Major({
    this.id,
    this.major,
    this.abbreviation,
    this.majorCode,
  });

  static List<Major> getMajor() {
    return <Major>[
      // School of Computer Science
      Major(id: 1, major: 'Information Technology', abbreviation: 'IT', majorCode: "001"),
      Major(id: 2, major: 'Information System', abbreviation: 'IS', majorCode: "002"),
      // School of Engineering
      Major(id: 3, major: 'Industrial Engineering', abbreviation: 'IE', majorCode: "003"),
      Major(id: 4, major: 'Electrical Engineering', abbreviation: 'EE', majorCode: "004"),
      Major(id: 5, major: 'Environmental Engineering', abbreviation: 'ENV', majorCode: "005"),
      Major(id: 6, major: 'Civil Engineering', abbreviation: 'CE', majorCode: "006"),
    ];
  }
}
