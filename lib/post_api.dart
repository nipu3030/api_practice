import 'dart:convert';

import 'package:api_492/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostApi extends StatelessWidget {

 Future<List<PostModel>> fetchAllPost() async {
    String url = "https://dummyjson.com/posts";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["total"] > 0) {
        List<PostModel> mPost = [];
        for (Map<String, dynamic> eachPost in data["posts"]) {
          mPost.add(PostModel.fromJson(eachPost));
        }
        return mPost;
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
      appBar: AppBar(title: Text('Post')),
      body: FutureBuilder(
          future: fetchAllPost(),
          builder: (_,snap){
            if(snap.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator.adaptive(),);
            }
            if(snap.hasError){
              return Text("Error - ${snap.error}");
            }
            if(snap.hasData && snap.data != null){
             List<PostModel> mPost = snap.data!;
             return mPost.isNotEmpty ? ListView.builder(
               itemCount: mPost.length,
               itemBuilder: (_,index){
                 var eachPost = mPost[index];
                 return ListTile(
                   leading: CircleAvatar(radius: 15,child: Text(eachPost.id.toString()),),
                   title: Text(eachPost.title!),
                   subtitle: Row(
                     children: [
                       Text("Likes - ${eachPost.reactions!.likes}"),
                       SizedBox(width: 30,),
                       Text("Dislikes - ${eachPost.reactions!.dislikes}")
                     ],
                   )
                 );
               },
             ) : Center(child: Text('Post Not Found.'),);
            }

            return Container();
          }),
    );
  }
}
