


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Cubit/cubit.dart';
import 'package:news/layout/search.dart';
import 'package:news/layout/webview.dart';
import 'package:news/main.dart';

import '../Cubit/states.dart';

class NewsLayout extends StatelessWidget {
 static var control=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
 BlocConsumer<cubitScreen, StatesScreen>(
          listener: (context, state) => () {},
          builder: (context, state) {
           var cubit=cubitScreen.getcubit(context);
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(backgroundColor: Colors.brown,
              title: Text('اخبار',style: TextStyle(color: Colors.white,fontSize: 35),),
              ),
              body: cubit.loding==false? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(

                    children: [
                      TextFormField(keyboardType: TextInputType.text,
                        textAlign:TextAlign.right,
                        decoration: InputDecoration(
                            label: Text('بحث',textAlign: TextAlign.right),
                            suffixIcon: Icon(Icons.search,color: Colors.brown,),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),),
                        ),
                        controller: control,
                        onFieldSubmitted: (value){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>searchLayout()));
                        cubit.searchDateFromApi('${control.text}');

                         // v2/everything?q=bitcoin&apiKey=005655fa0f4d42828d0dd5dabd14975c
                        },

                      ),

                      Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) =>
                          buildnews(cubit.data[index],context),
                          separatorBuilder: (context,index)=>SizedBox(height: 20),
                          itemCount:cubit.data.length,
                      ),
                    ),
                  ],
                ),
              ): Center(child: CircularProgressIndicator(color: Colors.brown,)),
            );
          }

    );
  }
  Widget buildnews(data,context)=>InkWell(
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
                data['urlToImage']!=null?
                  Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.elliptical(50,50))),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network('${data['urlToImage']}',fit: BoxFit.fill,width: 180,height: 170,
                     errorBuilder:  (BuildContext context, Object exception, StackTrace? stackTrace) {

 return  Text('error');
 },

                      )
                  ):

                  Image.asset('assets/noimage.png',fit: BoxFit.fill,width: 180,height: 170,),
                SizedBox(width: 10,),
                Expanded(child: Text('${data['title']}',maxLines: 4,overflow:TextOverflow.ellipsis,textAlign:TextAlign.right,style: TextStyle(fontSize: 18),))
              ],),
          ),
          Container(height: 2,color: Colors.brown,)
        ],
      ),
    ),
  );
}
