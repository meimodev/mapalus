class Version {
  int major;
  int minor;
  int patch;

  Version({required this.major, required this.minor, required this.patch});

  Version.fromMap(Map<String, dynamic> data)
      : major = data['major'],
        minor = data['minor'],
        patch = data['patch'];

  Version.fromList(List<String> data)
      : major = int.parse(data[0]),
        minor = int.parse(data[1]),
        patch = int.parse(data[2]);

  Map<String, dynamic> toMap() {
    return {
      'major': major,
      'minor': minor,
      'patch': patch,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Version &&
          runtimeType == other.runtimeType &&
          major == other.major &&
          minor == other.minor &&
          patch == other.patch;

  bool operator >(Version version) =>
      major > version.major || minor > version.minor;

  @override
  int get hashCode => major.hashCode ^ minor.hashCode ^ patch.hashCode;

  @override
  String toString() {
    return '$major.$minor.$patch';
  }
}