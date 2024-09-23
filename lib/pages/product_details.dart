import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import '../models/product_model.dart';
import '../providers/product_provider.dart';
import '../utils/widgets_functions.dart';

class ProductDetailsPage extends StatefulWidget {
  static const String routeName = '/productdetails';

  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late ProductModel product; //decleard a veriable to recive product id.

  @override
  void didChangeDependencies() {
    final id = ModalRoute.of(context)!.settings.arguments
        as String; //recived id to exicute this line,now i have specofic product id,
    product = context.watch<ProductProvider>().getProductFromListById(
        id); //use context.watch to update widget automaticlly.alwys use context.read,
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 2,right: 2),
        child: BottomAppBar(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // No border radius
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.add_shopping_cart,color: Colors.yellow,),
                  label: const Text('ADD',style: TextStyle(color: Colors.yellow,fontSize: 26),),
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // No border radius
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.currency_bitcoin,color: Colors.yellow,),
                  label: const Text('BUY',style: TextStyle(color: Colors.yellow,fontSize: 26),),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border,
                  )),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          Card(
            elevation: 10.0,
            shadowColor: Colors.black,
            child: CachedNetworkImage(
              width: double.infinity,
              height: 250.0,
              fit: BoxFit.cover,
              imageUrl: product.imageUrl,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Center(
                child: Icon(
                  Icons.error,
                ),
              ),
              fadeInDuration: const Duration(milliseconds: 1000),
              fadeInCurve: Curves.bounceInOut,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.productName,
                  style: const TextStyle(fontSize: 24.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: [
                      RichText(
                          text: TextSpan(
                              text: '${product.priceAfterDiscount}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                              ))),
                      RichText(
                          text: TextSpan(
                              text: '${product.price}',
                              style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ))),
                    ],
                  ),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Card(
              child: ReadMoreText(
                product.description,
                trimLines: 6,
                textAlign: TextAlign.justify,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'see more',
                trimExpandedText: 'see less',
                lessStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
                moreStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
                style: const TextStyle(fontSize: 16.0, height: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
