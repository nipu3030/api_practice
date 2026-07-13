import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget{
  @override
  Widget build(context){
    return Scaffold(
      body: FutureBuilder(future: getQuotes(),
          builder: (_,snap){
        if(snap.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator.adaptive(),);
        }
        if(snap.hasError){
          return Center(child: Text('Error : ${snap.error}'),);
        }
        if(snap.hasData && snap.data != null){
          List<dynamic> mQuotes = snap.data;
          return mQuotes.isNotEmpty ? ListView.builder(
            itemCount: mQuotes.length,
            itemBuilder: (_,index){
              var eachQuotes = mQuotes[index];
              return Card(
                child: ListTile(
                  title: Text(eachQuotes['quote']),
                  subtitle: Text(eachQuotes['author']),
                ),
              );
            },
          ) : Center(child: Text('No Quotes Yet!'),);
        }
          return Container();
          }),
    );
  }
 Future<dynamic> getQuotes()async{
    String url = "https://dummyjson.com/quotes";

    http.Response response = await http.get(Uri.parse((url)));
    if(response.statusCode==200){
      var  data = jsonDecode(response.body);
      if(data["total"] > 0){
      List<dynamic> allQuotes = data['quotes'];
      return allQuotes;
      } else{
        return [];
      }
    }else{
       return [];
    }
  }
}

/*
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var allQuotes = [];

  @override
  void initState() {
    getQuotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: allQuotes.isNotEmpty ? ListView.builder(
        itemCount: allQuotes.length,
        itemBuilder: (_,index){
          var eachQuotes = allQuotes[index];
          return Card(
            child: ListTile(
              title: Text(eachQuotes['quote']),
              subtitle: Text(eachQuotes['author']),
            ),
          );
        },
      ) : Container(),
    );
  }

  getQuotes() async {
    String url = "https://dummyjson.com/quotes";

    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode==200){
      var data= jsonDecode(response.body);
      if(data["total"] > 0){
        allQuotes = data['quotes'];
        setState(() {});
      }

    }
  }
}

 */