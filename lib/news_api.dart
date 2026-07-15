import 'dart:convert';
import 'package:api_492/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsApi extends StatefulWidget {
  @override
  State<NewsApi> createState() => _NewsApiState();
}

class _NewsApiState extends State<NewsApi> {
   var searchKeyword = TextEditingController();

  Future<List<ArticleModel>> fetchAllNews() async {
    bool query = searchKeyword.text.isNotEmpty;
    String url = query  ?    "https://newsapi.org/v2/everything?q=${searchKeyword.text}&apiKey=b9e0b4549daa417caff6427e13161ab6" : "https://newsapi.org/v2/top-headlines?country=us&apiKey=b9e0b4549daa417caff6427e13161ab6";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["totalResults"] > 0) {
        List<ArticleModel> mArticle = [];
        for (Map<String, dynamic> eachArticle in data["articles"]) {
          mArticle.add(ArticleModel.fromJson(eachArticle));
        }
        return mArticle;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text("News App"),),
      body: FutureBuilder<List<ArticleModel>>(future: fetchAllNews(),
          builder: (_, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator.adaptive(),);
            }

            if (snap.hasError) {
              return Text("Error - ${snap.error}");
            }

            if (snap.hasData && snap.data != null) {
              var allArticle = snap.data!;
              return allArticle.isNotEmpty ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      controller:  searchKeyword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21),
                        ),
                        hintText: 'Search News'
                      ),
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(
                        onPressed: ()=> setState(() {}),
                        child: Text("Search"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white
                      ),
                    ),
                    SizedBox(height: 10,),
                    Expanded(
                      child: ListView.builder(
                        itemCount: allArticle.length,
                        itemBuilder: (_, index) {
                          var eachArticle = allArticle[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (_) =>
                                      DetailsPage(image: eachArticle.urlToImage,
                                          title: eachArticle.title,
                                          description: eachArticle.description,
                                         content: eachArticle.content,
                                        author: eachArticle.author,
                                        publishedAt: eachArticle.publishedAt,
                                      )));
                            },
                            child: Card(
                              color: Colors.white,
                              elevation: 1,
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(8),
                                    height: 200,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(11),
                                        image: DecorationImage(image: NetworkImage(
                                            eachArticle.urlToImage ?? ""),
                                            fit: BoxFit.cover)
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  ListTile(
                                    title: Text(eachArticle.title ?? "",
                                      style: TextStyle(fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis),
                                      maxLines: 2,),
                                    subtitle: Text(eachArticle.description ?? ""),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ) : Center(child: Text("No Article Found!"),);
            }
            return Container();
          }),
    );
  }
}


class DetailsPage extends StatelessWidget {
  String? image;
  String? title;
  String? description;
  String? content;
  String? author;
  String? publishedAt;

  DetailsPage({
    required this.image,
    required this.title,
    required this.description,
    required this.content,
    required this.publishedAt,
    required this.author
  });

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(image!),fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(21),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text("Author - ${author!}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)),
                Expanded(child: Text(publishedAt!))
              ],
            ),
            SizedBox(height: 10,),
            Text(title!,style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text(description!),
            SizedBox(height: 20,),
            Text(content!),
          ],
        ),
      ),
    );
  }
}