bool isValidEmail(String email) {
  RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  return emailRegExp.hasMatch(email);
}

bool isValidSpaceId(String spaceId) {
  RegExp spaceIdRegExp = RegExp(r'^[A-Za-z_0-9]+$');

  return spaceIdRegExp.hasMatch(spaceId);
}

bool isValidGroupName(String groupName) {
  RegExp groupNameRegExp = RegExp(r'^[a-zA-Z _0-9\-]+$');

  return groupNameRegExp.hasMatch(groupName);
}
