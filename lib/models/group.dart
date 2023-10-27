class GroupModel {
  String _name = '';
  List<String> userIds = [];

  String get name => _name;

  GroupModel.fromMap(Map data) {
    _name = data['name'] ?? '';
    userIds = _convertUserIds(data['userIds'] ?? []);
  }

  Map toMap() => {
        'name': name,
        'userIds': userIds,
      };

  List<String> _convertUserIds(List list) {
    List<String> ret = [];
    for (String id in list) {
      ret.add(id);
    }
    return ret;
  }
}
