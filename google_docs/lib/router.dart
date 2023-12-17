import 'package:flutter/material.dart';
import 'package:google_docs/screens/home.dart';
import 'package:google_docs/screens/login.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute=RouteMap(
  routes: {'/': (route)=>const MaterialPage(child: LoginScreen()),
  }
  );

  final loggedInRoute=RouteMap(
  routes: {'/': (route)=>const MaterialPage(child: HomeScreen()),
              
  }
  );