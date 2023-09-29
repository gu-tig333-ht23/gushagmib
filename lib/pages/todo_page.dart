import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/collection_state.dart';
import 'add_item_page.dart';
import '../models/enums.dart';
import 'package:flutter/foundation.dart';
// Widgets
import '../widgets/toggle_theme_widget.dart';
import '../widgets/reorderable_list_widget.dart';

class MainPage extends StatelessWidget {
  MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainPageAppBar(),
      body: ReorderableListWidget(),
      floatingActionButton: GoToAddPageFloatingButton(),
    );
  }
}

class MainPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  MainPageAppBar({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        ToggleDarkThemeWidget(),
        PopUpMenu(),
      ],
      title: Center(
        child: Text(
          "TodoHub",
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Stateful since PopUpMenu only needs to manage it's own state.
class PopUpMenu extends StatefulWidget {
  const PopUpMenu({
    super.key,
  });

  @override
  State<PopUpMenu> createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<PopUpMenu> {
  // Default is the option "all"
  MenuOption selectedOption = MenuOption.all;

  // Options for sorting the todo lists.
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      initialValue: selectedOption,
      onSelected: (var option) {
        setState(() {
          selectedOption = option;
          // We dont want to listen only update the operation
          Provider.of<TaskCollectionState>(context, listen: false)
              .setSort(selectedOption);
        });
      },
      itemBuilder: (context) =>
          MenuOption.values.map((option) => createMenuItem(option)).toList(),
    );
  }

  PopupMenuItem<dynamic> createMenuItem(MenuOption option) {
    return PopupMenuItem(
      value: option,
      child: Text(describeEnum(option)),
    );
  }
}

class GoToAddPageFloatingButton extends StatelessWidget {
  const GoToAddPageFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddToDoItemPage()),
        ),
      },
      tooltip: 'Add to-do item',
      child: const Icon(Icons.add),
    );
  }
}
