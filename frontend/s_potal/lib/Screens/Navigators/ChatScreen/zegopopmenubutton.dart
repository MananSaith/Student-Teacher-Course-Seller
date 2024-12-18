import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import '../../../widegts/textwidget.dart';

class Zegopopmenubutton extends StatefulWidget {
  const Zegopopmenubutton({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ZegopopmenubuttonState createState() => _ZegopopmenubuttonState();
}

class _ZegopopmenubuttonState extends State<Zegopopmenubutton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        position: PopupMenuPosition.under,
        icon: const Icon(Icons.add),
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
                child: ListTile(
              onTap: () => ZIMKit().showDefaultNewPeerChatDialog(context),
              leading: const Icon(Icons.person),
              title: TextWidget(
                text: "New Chat",
                fSize: 15,
                maxLine: 1,
              ),
            )),
            PopupMenuItem(
                child: ListTile(
              onTap: () => ZIMKit().showDefaultNewGroupChatDialog(context),
              leading: const Icon(Icons.group_add_outlined),
              title: TextWidget(
                text: "New Group",
                fSize: 15,
                maxLine: 1,
              ),
            )),
            PopupMenuItem(
                child: ListTile(
              onTap: () => ZIMKit().showDefaultJoinGroupDialog(context),
              leading: const Icon(Icons.group_add),
              title: TextWidget(
                text: "Join Group",
                fSize: 15,
                maxLine: 1,
              ),
            ))
          ];
        });
  }
}
