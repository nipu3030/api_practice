import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommentsApi extends StatelessWidget{
  @override
  Widget build(context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: FutureBuilder(future: getComments(),
          builder: (_,snap){
        
        if(snap.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator.adaptive(),);
        }
        if(snap.hasError){
          return Text("Error ${snap.error}");
        }
        if(snap.hasData && snap.data !=null){
          List<dynamic> mComments = snap.data!;
          return mComments.isNotEmpty ? ListView.builder(
            itemCount: mComments.length,
            itemBuilder: (_,index){
              var eachComments = mComments[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 15,
                  child: Text(eachComments['id'].toString()),
                ),
                title: Text(eachComments["body"]),
                subtitle: Text("Likes - ${eachComments["likes"]}"),
              );
            },
          ) : Center(child: Text("No Comments Yet!!"),);
        }
        return Container();
          }),
    );
  }
  
  
  Future<List<dynamic>> getComments()async{
    String url = "https://dummyjson.com/comments";
    var response = await  http.get(Uri.parse(url));
    
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      if(data["total"]>0){
        List<dynamic> allComments = data['comments'];
        return allComments;
      }else{
        return [];
      }
    } else {
      return [];
    }
  }
}


/*

class CommentsApi extends StatefulWidget{
  @override
  State<CommentsApi> createState() => _CommentsApiState();
}

class _CommentsApiState extends State<CommentsApi> {

  var allComments = [];

  @override
  void initState() {
    getComments();
    super.initState();
  }

  @override
  Widget build(context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: allComments.isNotEmpty ? ListView.builder(
        itemCount: allComments.length,
        itemBuilder: (_,index){
          var eachComment = allComments[index];
          return ListTile(
            leading: CircleAvatar(
              radius: 15,
              child: Text(eachComment["id"].toString()),
            ),
            title: Text(eachComment["body"]),
            subtitle: Text("Likes - ${eachComment['likes']}"),
          );
        },
      ) : Center(child: Text("No Comments Yet!!!"),),
    );
  }

  getComments()async{
    String url = "https://dummyjson.com/comments";

    var response = await http.get(Uri.parse(url));

    if(response.statusCode==200){
      var data = jsonDecode(response.body);
     if(data['total']>0){
       allComments = data['comments'];
       setState(() {});
     }
    }
  }

}

 */