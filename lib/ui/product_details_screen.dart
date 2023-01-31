import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miaged/const/AppColors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetails extends StatefulWidget {
  var _product;
  ProductDetails(this._product);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {

  Future addToCart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-cart-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "titre": widget._product["product-titre"],
      "taille": widget._product["product-taille"],
      "marque": widget._product["product-marque"],
      "prix": widget._product["product-prix"],
      "images": widget._product["product-img"],
    }).then((value) => Fluttertoast.showToast(msg: "Produit ajouté au panier"));
  }

  Future addToFavourite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users-favourite-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "titre": widget._product["product-titre"],
      "taille": widget._product["product-taille"],
      "marque": widget._product["product-marque"],
      "prix": widget._product["product-prix"],
      "images": widget._product["product-img"],
    }).then((value) => Fluttertoast.showToast(msg: "Produit ajouté au favourite"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.vinted_color,
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
        ),
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users-favourite-items").doc(FirebaseAuth.instance.currentUser!.email)
                .collection("items").where("titre",isEqualTo: widget._product['product-titre']).snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.data==null){
                return Text("");
              }
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: IconButton(
                    onPressed: () => snapshot.data.docs.length==0?addToFavourite():print("Already Added"),
                    icon: snapshot.data.docs.length==0? Icon(
                      Icons.favorite_outline,
                      color: Colors.white,
                    ):Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },

          ),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 3.7,
              child: CarouselSlider(
                  items: widget._product['product-img']
                      .map<Widget>((item) =>

                            Container(
                              color: Colors.white,
                              child: Image.network(item),
                            ),
                          )
                      .toList(),
                  options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, carouselPageChangedReason) {
                        setState(() {});
                      })),
            ),
            Text( widget._product['product-titre'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text("taille : ${widget._product['product-taille']}"),
            Text("marque : ${widget._product['product-marque']}"),
            SizedBox(
              height: 10,
            ),
            Text(
              "${widget._product['product-prix'].toString()} DH",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 25, color: Colors.red),
            ),
            Divider(),
            Center(
              child: SizedBox(
                width: 0.5.sw,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => addToCart(),
                  child: Text(
                    "Ajouter au panier",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.vinted_color,
                    elevation: 3,
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
