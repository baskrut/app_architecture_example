import 'package:app_architecture_example/models/product_model.dart';
import 'package:app_architecture_example/providers/list_provider.dart';
import 'package:app_architecture_example/ui/styling/colors.dart';
import 'package:app_architecture_example/ui/widgets/common_app_bar.dart';
import 'package:app_architecture_example/ui/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  static const String id = '/HomePage';

  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePage();
}

class _HomePage extends ConsumerState<HomePage> {
  @override
  void initState() {
    ref.read(listProv).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(appBar: const CommonAppBar(), children: [
      ListView.builder(
          shrinkWrap: true,
          itemCount: ref.watch(listProv).currentProducts.length,
          itemBuilder: (ctx, i) {
            return ItemCard(product: ref.watch(listProv).currentProducts[i]);
          })
    ]);
  }
}

class ItemCard extends StatelessWidget {
  final ProductModel product;

  const ItemCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(product.name, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(width: 16),
                Text('рейтинг ${product.rating}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: appGreen)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'ціна ${product.price}',
                  style: product.inStock
                      ? Theme.of(context).textTheme.headlineMedium?.copyWith(color: appGreen)
                      : Theme.of(context).textTheme.headlineMedium?.copyWith(color: appError),
                ),
                Text(product.category, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 16),
            product.inStock
                ? Text('в наявності', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: appGreen))
                : Text('закінчився', style: Theme.of(context).textTheme.displaySmall?.copyWith(color: appError))
          ],
        ),
      ),
    );
  }
}
