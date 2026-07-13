import 'dart:convert';
import 'package:api_492/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductApi extends StatelessWidget{

 Future<List<ProductModel>>  fetchAllProduct() async {
    String url = "https://dummyjson.com/products";
    var response = await http.get(Uri.parse(url));

    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      if(data["total"] > 0){
        List<ProductModel> mProduct = [];
        for(Map<String,dynamic> eachProduct in data["products"]){
          mProduct.add(ProductModel.fromJson(eachProduct));
        }
        return mProduct;
      }else{
        return [];
      }
    }else{
      return [];
    }
  }


  @override
  Widget build(context){
    return Scaffold(
      appBar: AppBar(title: Text("Product"),),
      body: FutureBuilder(
          future: fetchAllProduct(),
          builder: (_,snap){
            if(snap.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator.adaptive(),);
            }
            if(snap.hasError){
              return Text("Error = ${snap.error}");
            }
            if(snap.hasData && snap.data != null){
              List<ProductModel> allProduct = snap.data!;
              return allProduct.isNotEmpty ? ListView.builder(
                itemCount: allProduct.length,
                itemBuilder: (_,index){
                  var eachProduct = allProduct[index];
                  return ListTile(
                    leading: Image.network(eachProduct.thumbnail!),
                    title: Text(eachProduct.title!),
                    subtitle: Column(
                      children: [
                        Text(eachProduct.description!),
                        eachProduct.images != null && eachProduct.images!.isNotEmpty ? SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: eachProduct.images!.length,
                            itemBuilder: (_,childIndex){
                              return Image.network(
                                eachProduct.images![childIndex]
                              );
                            },
                          ),
                        ) : Container()
                      ],
                    ),
                  );
                },
              ) : Center(child: Text("No Product Found!"),);
            }

            return Container();
          }),
    );
  }
}