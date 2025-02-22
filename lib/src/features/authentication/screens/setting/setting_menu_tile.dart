import "package:flourish/src/utils/constants/colors.dart";
import "package:flourish/src/utils/helpers/helper_function.dart";
import "package:flutter/material.dart";

class SettingMenuTile extends StatelessWidget {
  const SettingMenuTile(
      {super.key,
      required this.title,
      required this.icon,
      this.trailing,
      this.onTap});

  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunction.isDarkMode(context);
    return ListTile(
      leading: Icon(icon, size: 28, color: isDark ? slate400 : dark),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .apply(color: isDark ? slate400 : dark),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
