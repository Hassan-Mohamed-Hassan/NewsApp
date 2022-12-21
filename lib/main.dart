import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/network/diohelpear.dart';

import 'Cubit/cubit.dart';
import 'layout/News_layout.dart';

void main() {
  Diohealper.dio;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        BlocProvider(create: (context) => cubitScreen.search==false?(cubitScreen()..getDateFromApi()):
        (cubitScreen()..searchDateFromApi(NewsLayout.control.text)),
      child: MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: NewsLayout(),
      ),
    );
  }
}
