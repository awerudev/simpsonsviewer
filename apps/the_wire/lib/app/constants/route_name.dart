enum RouteName {
  initial('/'),
  viewer('/viewer'),
  error('/error'),
  postDetails(':character');

  const RouteName(this.path);
  final String path;
}
