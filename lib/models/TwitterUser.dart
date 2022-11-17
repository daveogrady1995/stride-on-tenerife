class TwitterUser {
  // high quality image cant be accessed through api
  final photoUrl =
      'https://pbs.twimg.com/profile_images/1277520026829012996/UYf2fcXC_400x400.jpg';

  String username, userHandle;

  TwitterUser(String username, String userHandle) {
    this.username = username;
    this.userHandle = '@' + userHandle;
  }
}
