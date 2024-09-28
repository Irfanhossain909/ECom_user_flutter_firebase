import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_user/customwidgets/header_view.dart';
import 'package:ecom_user/models/comment_model.dart';
import 'package:ecom_user/models/ratting_model.dart';
import 'package:ecom_user/providers/auth_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
  final _commentController = TextEditingController();
  late ProductModel product; //decleard a veriable to recive product id.
  double rating = 1.0;

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
        padding: const EdgeInsets.only(left: 2, right: 2),
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
                      borderRadius:
                          BorderRadius.circular(15), // No border radius
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add_shopping_cart,
                    color: Colors.yellow,
                  ),
                  label: const Text(
                    'ADD',
                    style: TextStyle(color: Colors.yellow, fontSize: 26),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15), // No border radius
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.currency_bitcoin,
                    color: Colors.yellow,
                  ),
                  label: const Text(
                    'BUY',
                    style: TextStyle(color: Colors.yellow, fontSize: 26),
                  ),
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
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Rate this product',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                RatingBar.builder(
                  initialRating: 0.0,
                  minRating: 1.0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (value) {
                    rating = value;
                  },
                ),
                TextButton(
                  onPressed: _updateRatting,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Add a comment',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: 3,
                    controller: _commentController,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                TextButton(
                  onPressed: _saveComment,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: context
                .read<ProductProvider>()
                .getCommentByProduct(product.id!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Fetching Comments...');
              }

              if (snapshot.hasError) {
                return const Text('Failed to fetch comments');
              }

              if (snapshot.hasData) {
                final data = snapshot.data;
                if (data == null || data.docs.isEmpty) {
                  return const Text('No comments available');
                }

                final List<CommentModel> commentList = context
                    .read<ProductProvider>()
                    .getCommentList(snapshot.data!);
                return Column(children: [
                  HeaderView(title: 'Comment(${commentList.length})'),
                  for (final comments in commentList)
                    ListTile(
                      title: Text(comments.comment),
                      subtitle: Text(comments.userModel.email),
                      leading: const CircleAvatar(
                          child: Icon(Icons.person_2_outlined)),
                    )
                ]);
              }

              return const Text('Fetching Comments');
            },
          )
        ],
      ),
    );
  }

  void _updateRatting() async {
    EasyLoading.show(status: 'Update Your Rating');
    final ratingModel = RattingModel(
      userModer: context.read<FirebaseAuthProvider>().userModel!,
      productId: product.id!,
      ratting: rating,
    );
    try {
      await context.read<ProductProvider>().addRatings(ratingModel);
      showMsg(context, 'Rating Updated');
      EasyLoading.dismiss();
    } catch (error) {
      showMsg(context, 'Failed to update rating');
      EasyLoading.dismiss();
    }
  }

  void _saveComment() async {
    if (_commentController.text.isEmpty) {
      showMsg(context, 'Comment is empty');
      return;
    }
    final commentModel = CommentModel(
      userModel: context.read<FirebaseAuthProvider>().userModel!,
      productId: product.id!,
      comment: _commentController.text,
    );
    EasyLoading.show(status: 'Please wait');
    context.read<ProductProvider>().addComment(commentModel).then((value) {
      EasyLoading.dismiss();
      showMsg(context, 'Comment Saved');
      setState(() {
        _commentController.clear();
      });
    }).catchError((error) {
      EasyLoading.dismiss();
      showMsg(context, 'Failed to save comment');
    });
  }
}
