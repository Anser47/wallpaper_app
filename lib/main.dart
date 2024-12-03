import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/bloc/photo_bloc.dart';
import 'package:wallpaper_app/models/photo_model.dart';
import 'package:wallpaper_app/repo/repo.dart';
import 'package:wallpaper_app/view/home/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => PhotoRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                PhotoBloc(photoRepo: context.read<PhotoRepo>()),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          home: ProductPage(),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:wallpaper_app/sample.dart';

// void main() {
//   runApp(const MyApp());
// }

// enum _SelectedTab { home, favorite, add, search, person }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Crystal Bottom Bar Example',
      // theme: ThemeData(
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      // themeMode: ThemeMode.dark,
//       home: const HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   var _selectedTab = _SelectedTab.home;

//   void _handleIndexChanged(int i) {
//     setState(() {
//       _selectedTab = _SelectedTab.values[i];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       extendBody: true,
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         child: Image.network(
//           "https://mrahkat.net/wp-content/uploads/2019/07/unnamed-file-416.jpg",
//           fit: BoxFit.fitHeight,
//         ),
//       ),
//       bottomNavigationBar: CrystalNavigationBar(
//         currentIndex: _SelectedTab.values.indexOf(_selectedTab),
//         height: 10,
//         // indicatorColor: Colors.blue,
//         unselectedItemColor: Colors.white70,
//         backgroundColor: Colors.black,

//         onTap: _handleIndexChanged,
//         items: [
//           /// Home
//           CrystalNavigationBarItem(
//               icon: Icons.home,
//               selectedColor: Colors.white,
//               unselectedColor: Colors.grey),

//           /// Favourite
//           /// Search
//           CrystalNavigationBarItem(
//               unselectedColor: Colors.grey,
//               icon: Icons.search,
//               selectedColor: Colors.white),
//           CrystalNavigationBarItem(
//               icon: Icons.notifications,
//               selectedColor: Colors.red,
//               unselectedColor: Colors.grey),

//           /// Add
//           CrystalNavigationBarItem(
//               icon: Icons.circle,
//               selectedColor: Colors.white,
//               unselectedColor: Colors.grey),

//           /// Profile
//         ],
//       ),
//     );
//   }
// }
