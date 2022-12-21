
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Cubit/cubit.dart';
import 'package:news/main.dart';

import '../Cubit/states.dart';
import 'webview.dart';

class searchLayout extends StatefulWidget {

  @override
  State<searchLayout> createState() => _searchLayoutState();
}

class _searchLayoutState extends State<searchLayout> {
  bool x = true;
  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<cubitScreen, StatesScreen>(
          listener: (context, state) => () {},
          builder: (context, state) {
            var cubit = cubitScreen.getcubit(context);
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(backgroundColor: Colors.brown,
                title: Text('اخبار',style: TextStyle(color: Colors.white,fontSize: 35),),),
              body: cubit.searchlist.length > 0 ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.separated(
                  itemBuilder: (context, index) =>
                      buildnews(cubit.searchlist[index]),
                  separatorBuilder: (context, index) => SizedBox(height: 20),
                  itemCount: cubit.searchlist.length,
                ),
              ) :

              buildload(),
            );
          }

      );
  }

  Widget buildnews(data) =>
      InkWell(
    onTap:(){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>webview('${data['url']}')));
},
        child: Card(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    data['urlToImage'] != null ?
                    Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(
                            Radius.elliptical(50, 50))),
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(
                          '${data['urlToImage']}', fit: BoxFit.fill,
                          width: 180,
                          height: 170,)) :

                    Image.asset('assets/noimage.png', fit: BoxFit.fill,
                      width: 180,
                      height: 170,),
                    SizedBox(width: 10,),
                    Expanded(child: Text('${data['title']}', maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18),))
                  ],),
              ),
              Container(height: 2, color: Colors.brown,)
            ],
          ),
        ),
      );


  Widget buildload() {

    Timer(Duration(seconds: 40), () {
      setState(() {
        x = false;
      });
    });
    print(x);
    return x == true ? Center(
        child: CircularProgressIndicator(color: Colors.brown,)) :Center(child: Text('no result found'));
  }

}