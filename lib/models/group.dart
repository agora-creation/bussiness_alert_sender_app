class GroupModel {
  String _name = '';
  List<String> userIds = [];

  String get name => _name;

  GroupModel.fromMap(Map data) {
    _name = data['name'] ?? '';
    userIds = data['userIds'] ?? [];
  }
}
