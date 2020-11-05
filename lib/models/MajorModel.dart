class MajorModel {
  final int id;
  final String major;
  final String abbreviation;

  MajorModel({
    this.id,
    this.major,
    this.abbreviation,
  });

  static List<MajorModel> getMajor() {
    return <MajorModel>[
      // School of Business
      MajorModel(id: 1, major: 'Accounting', abbreviation: 'ACC'),
      MajorModel(id: 2, major: 'Management', abbreviation: 'MGT'),
      // School of Computer Science
      MajorModel(id: 3, major: 'Information Technology', abbreviation: 'IT'),
      MajorModel(id: 4, major: 'Information System', abbreviation: 'IS'),
      // School of Engineering
      MajorModel(id: 5, major: 'Industrial Engineering', abbreviation: 'IE'),
      MajorModel(id: 6, major: 'Electrical Engineering', abbreviation: 'EE'),
      MajorModel(id: 7, major: 'Environmental Engineering', abbreviation: 'ENV'),
      MajorModel(id: 8, major: 'Civil Engineering', abbreviation: 'CE'),
    ];
  }
}
