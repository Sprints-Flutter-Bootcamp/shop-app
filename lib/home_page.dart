import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/grid_item.dart';
import 'package:shop_app/text_title.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> imagesURL = [
    "https://api.mistore-eg.com/storage/uploads/Band9_silver_1-1729505833.webp",
    "https://api.mistore-eg.com/storage/uploads/xiaomi-watch-s3-black_8662-dcce8349-458f-4ea3-5cef-8359bd9d64c5-1709546482.png",
    "https://api.mistore-eg.com/storage/uploads/d0359990-112d-4dd7-845b-08bfb3d8dc97-1704960031.jpg",
    "https://api.mistore-eg.com/storage/uploads/A-2025-55-front-1726669731-1729172704.jpg",
    "https://api.mistore-eg.com/storage/uploads/BHR4828GL_wr_02-1721554230.jpg",
    "https://api.mistore-eg.com/storage/uploads/333764_165536-1699795608.webp",
    "https://api.mistore-eg.com/storage/uploads/eng_pl_Tablet-Redmi-Pad-SE-8-7-4G-4-128GB-Sky-Blue-2892_4-1729075251.webp",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: Text(context.tr("Xiaomi_Shopping_App")),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              textTitle(
                context.tr("our_products"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: PageView(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.orange,
                      child: Image.network(
                        "https://api.mistore-eg.com/storage/uploads/vxnrDk-1635076131-1659965192%20(1)(11)-1669730623-1669733753.png",
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.orange,
                        child: Image.network(
                          "https://api.mistore-eg.com/storage/uploads/vxnrDk-1635076131-1659965192%20(1)(12)-1669731387-1669733713.png",
                          height: 100,
                          width: 100,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return gridItem(
                      context,
                      imagesURL[index],
                      "Product ${index + 1}",
                    );
                  },
                ),
              ),
              textTitle(context.tr("hot_offers")),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: ListView.builder(
                  itemCount: imagesURL.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.network(
                        imagesURL[index],
                      ),
                      title: Text("Product ${index + 1}"),
                      trailing: const Icon(Icons.info),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
