import 'package:chatter/Screens/Screens.dart';
import 'package:chatter/pages/calls_page.dart';
import 'package:chatter/pages/contacts_page.dart';
import 'package:chatter/pages/messages_page.dart';
import 'package:chatter/pages/notification_page.dart';
import 'package:chatter/theme.dart';
import 'package:chatter/widgets/glowing_action_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatter/helpers.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(1);
  final ValueNotifier<String> title = ValueNotifier('Messages');
  final pages = const [
    MessagesPage(),
    NotificationPage(),
    CallsPage(),
    ContactsPage(),
  ];
  final pageTitles = const [
    'Messages'
    'Notifications'
    'Calls'
    'Contact'
  ];
  void _onNavigationItemSelected(index) {
    title.value = pageTitles[index];
    pageIndex.value = index;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ValueListenableBuilder(
          valueListenable: title,
          builder: (BuildContext context, String value, _) {
            return Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            );
          }
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Avatar.small(url: Helpers.randomPictureUrl()),
          ),
        ],
        leadingWidth: 54,
        leading: Align(
          alignment: Alignment.centerRight,
          child: IconBackground(icon: Icons.search, onTap: (){
            print('Todo search');
          }),
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: pageIndex,
          builder: (BuildContext context, int value, _) {
            return pages[value];
          }),
      bottomNavigationBar: _ButtonNavigationBar(
        onItemSelected: _onNavigationItemSelected,
      ),
    );
  }
}

class _ButtonNavigationBar extends StatefulWidget {
  const _ButtonNavigationBar({Key? key, required this.onItemSelected})
      : super(key: key);
  final ValueChanged<int> onItemSelected;

  @override
  State<_ButtonNavigationBar> createState() => _ButtonNavigationBarState();
}

class _ButtonNavigationBarState extends State<_ButtonNavigationBar> {
  var selectedIndex = 0;
  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      elevation: 0,
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavigationBarItem(
                label: 'Messages',
                icon: CupertinoIcons.bubble_left_bubble_right,
                index: 0,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 0),
              ),
              _NavigationBarItem(
                label: 'Notifications',
                icon: CupertinoIcons.bell_solid,
                index: 1,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GlowingActionButton(color: AppColors.secondary, icon: Icons.add, onPressed: (){
                  print('Todo later');
                }),
              ),
              _NavigationBarItem(
                label: 'Calls',
                icon: CupertinoIcons.phone_fill,
                index: 2,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 2),
              ),
              _NavigationBarItem(
                label: 'Contacts',
                icon: CupertinoIcons.person_2_fill,
                index: 3,
                onTap: handleItemSelected,
                isSelected: (selectedIndex == 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem(
      {Key? key,
      required this.label,
      required this.icon,
      required this.index,
      required this.onTap,
      this.isSelected = false})
      : super(key: key);
  final int index;
  final String label;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<int> onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppColors.secondary : null,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              label,
              style: isSelected
                  ? const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary)
                  : const TextStyle(
                      fontSize: 11,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
