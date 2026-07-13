import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TodoApi extends StatelessWidget{
  @override
  Widget build(context){
    return Scaffold(
      body: FutureBuilder(future: getTodo(),
          builder: (_,snap){
        if(snap.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator.adaptive(),);
        }
        if(snap.hasError){
          return Center(child: Text('Error : ${snap.error}'),);
        }
        if(snap.hasData && snap.data != null){
          List<dynamic> mTodo = snap.data!;
          return mTodo.isNotEmpty ? ListView.builder(
            itemCount: mTodo.length,
            itemBuilder: (_,index){
              var eachTodo = mTodo[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 15,
                  child: Text(eachTodo[index]),
                ),
                title: Text(eachTodo['todo']),
                subtitle: Text("Status - ${eachTodo['completed']}"),
              );
            },
          ) : Center(child: Text('No Todos Yet !!!'),);
        }


        return Container();
          }),
    );
  }
 Future<List<dynamic>> getTodo()async{
    String url = "https://dummyjson.com/todos";

    var response = await http.get(Uri.parse(url));

    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      if(data['total']>0){
        List<dynamic> allTodo = data['todo'];
        return allTodo;
      } else{
        return [];
      }
    }else{
      return [];
    }
  }
}

/*

class TodoApi extends StatefulWidget {
  const TodoApi({super.key});

  @override
  State<TodoApi> createState() => _TodoApiState();
}

class _TodoApiState extends State<TodoApi> {

  var allTodo = [];

  @override
  void initState() {
    getAllTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
      ),
      body: allTodo.isNotEmpty ? ListView.builder(
        itemCount: allTodo.length,
        itemBuilder: (_,index){
          var eachTodo = allTodo[index];
          return ListTile(
            leading: CircleAvatar(child: Text(eachTodo["id"].toString()),radius: 15,),
            title: Text(eachTodo['todo']),
            subtitle: Text("Status : ${eachTodo['completed'].toString()}"),
          );
        },
      ) : Center(child: Text('No Todo Yet!!!'),),
    );
  }

  getAllTodo()async{

    String url = "https://dummyjson.com/todos";

    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      if(data['total']>0){
         allTodo = data['todos'];
         setState(() {});
      }else{
        return [];
      }
    }else{
      return [];
    }
  }

}

 */