
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class CategoryPage extends StatefulWidget {
  static const String routeName = '/category';

  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<CategoryPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Category'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Consumer<ProductProvider>(
          builder: (context, provider, child) => provider.categoryList.isEmpty
              ? const Center(
                  child: Text('No Category Found'),
                )
              : ListView.builder(
                  itemCount: provider.categoryList.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Card(child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(provider.categoryList[index].name,style: const TextStyle(fontSize: 18.0),),
                    )),
                  ),
                ),
        ));
  }
}
