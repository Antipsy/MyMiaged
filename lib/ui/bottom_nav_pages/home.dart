import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miaged/const/AppColors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../product_details_screen.dart';
import '../search_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> _carouselImages = [];
  var _dotPosition = 0;
  List _products = [];
  TextEditingController _searchController = TextEditingController();
  var _firestoreInstance = FirebaseFirestore.instance;

  fetchCarouselImages() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("carousel-slider").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["img-path"],
        );
        print(qn.docs[i]["img-path"]);
      }
    });

    return qn.docs;
  }

  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-titre": qn.docs[i]["product-titre"],
          "product-taille": qn.docs[i]["product-taille"],
          "product-marque": qn.docs[i]["product-marque"],
          "product-prix": qn.docs[i]["product-prix"],
          "product-img": qn.docs[i]["product-img"],
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    fetchCarouselImages();
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
              Expanded(child:SizedBox(
                    height:40,
                    child: TextFormField(
                      controller: _searchController,
                      readOnly: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide: BorderSide(color: Colors.blue)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide: BorderSide(color: Colors.grey)),
                        hintText: "Search products here",
                        hintStyle: TextStyle(fontSize: 17),
                      ),
                      onTap: () => Navigator.push(context,
                          CupertinoPageRoute(builder: (_) => SearchScreen())),
                    ),
                  ),),
                  Container(
                    height: 40,
                    width: 40,
                    color: AppColors.vinted_color,
                    child: Center(
                      child: Icon(Icons.search,color: Colors.white,),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AspectRatio(
              aspectRatio: 3.6,
              child: CarouselSlider(
                  items: _carouselImages
                      .map((item) =>

                            Container(

                              width: ScreenUtil().screenWidth,

                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(item),
                                      fit: BoxFit.fill)),
                            ),
                          )
                      .toList(),
                  options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, carouselPageChangedReason) {
                        setState(() {
                          _dotPosition = val;
                        });
                      })),
            ),
            SizedBox(
              height: 10,
            ),
            DotsIndicator(
              dotsCount:
                  _carouselImages.length == 0 ? 1 : _carouselImages.length,
              position: _dotPosition.toDouble(),
              decorator: DotsDecorator(
                activeColor: AppColors.vinted_color,
                color: AppColors.vinted_color.withOpacity(0.5),
                spacing: EdgeInsets.all(2),
                activeSize: Size(8, 8),
                size: Size(6, 6),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _products.length,

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductDetails(_products[index]))),
                      child: Card(
                        elevation: 3,
                        child: Column(

                          children: [
                            AspectRatio(
                                aspectRatio: 2,
                                child: Container(
                                    color: Colors.white,
                                    child: Image.network(
                                      _products[index]["product-img"][0],
                                    ))),
                            Text("${_products[index]["product-titre"]}",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                            Text("taille : ${_products[index]["product-taille"]}"),

                            Text(
                                "prix : ${_products[index]["product-prix"].toString()} DH"),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      )),
    );
  }
}
