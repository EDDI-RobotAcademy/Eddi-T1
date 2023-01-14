import 'package:flutter/material.dart';

class SellerCommonAppBar extends StatelessWidget with PreferredSizeWidget {
  const SellerCommonAppBar({Key? key, this.title, this.leading, this.actions}) : super(key: key);

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
      iconTheme: IconThemeData(
        color: Colors.black
      ),
      centerTitle: true,
      title: title,
      leading: leading,
      actions: actions,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
