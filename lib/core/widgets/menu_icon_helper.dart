class MenuIconHelper {
  static String iconPath(bool expanded, bool isDark) {
    final mode = isDark ? 'dark' : 'light';
    final state = expanded ? 'collapse' : 'expand';
    return 'assets/icons/menu/menu-bar-$state-$mode.png';
  }
}
