import 'package:app_architecture_example/providers/list_provider.dart';
import 'package:app_architecture_example/ui/styling/colors.dart';
import 'package:app_architecture_example/ui/widgets/common_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommonAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  @override
  ConsumerState<CommonAppBar> createState() => _CommonAppBarState();
}

class _CommonAppBarState extends ConsumerState<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AppBar(backgroundColor: appLightBlue, elevation: 1.0, titleSpacing: 0.0, actions: [
        const FilterCategoryMenu(),
        const SortingMenu(),
        Row(
          children: [
            const Text('Є на складі'),
            const SizedBox(width: 4),
            InkWell(
              child: ref.watch(listProv).isOutOfStock
                  ? const Icon(Icons.check_box_outline_blank)
                  : const Icon(Icons.check_box_outlined),
              onTap: () {
                ref.read(listProv).isOutOfStock = !ref.read(listProv).isOutOfStock;
              },
            ),
          ],
        )
      ]),
    );
  }
}

class FilterCategoryMenu extends ConsumerWidget {
  const FilterCategoryMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0), child: Icon(Icons.filter_list_alt)),
      itemBuilder: (context) => [
        ...ref.read(listProv).getTypes().map(
              (e) => PopupMenuItem<int>(
                padding: EdgeInsets.zero,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: CommonTextButton(
                    label: e,
                    onTap: () {
                      ref.read(listProv).filterType = e;
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            )
      ],
    );
  }
}

class SortingMenu extends ConsumerWidget {
  const SortingMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0), child: Icon(Icons.sort_rounded)),
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          padding: EdgeInsets.zero,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: CommonTextButton(
              label: 'Price',
              onTap: () {
                ref.read(listProv).sortByPrice();
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        PopupMenuItem<int>(
          padding: EdgeInsets.zero,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: CommonTextButton(
              label: 'Rating',
              onTap: () {
                ref.read(listProv).sortByRating();
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ],
    );
  }
}
