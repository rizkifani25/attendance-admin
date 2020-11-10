class Major {
  final int id;
  final String major;
  final String abbreviation;

  Major({
    this.id,
    this.major,
    this.abbreviation,
  });

  static List<Major> getMajor() {
    return <Major>[
      // School of Business
      Major(id: 1, major: 'Accounting', abbreviation: 'ACC'),
      Major(id: 2, major: 'Management', abbreviation: 'MGT'),
      // School of Computer Science
      Major(id: 3, major: 'Information Technology', abbreviation: 'IT'),
      Major(id: 4, major: 'Information System', abbreviation: 'IS'),
      // School of Engineering
      Major(id: 5, major: 'Industrial Engineering', abbreviation: 'IE'),
      Major(id: 6, major: 'Electrical Engineering', abbreviation: 'EE'),
      Major(id: 7, major: 'Environmental Engineering', abbreviation: 'ENV'),
      Major(id: 8, major: 'Civil Engineering', abbreviation: 'CE'),
    ];
  }
}
