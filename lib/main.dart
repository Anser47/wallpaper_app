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
          debugShowCheckedModeBanner: false,
          home: ProductPage(),
        ),
      ),
    );
  }
}
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// // Define your Photo and Urls classes here (from the previous example).

// Future<List<PhotoModal>> fetchPhotos() async {
//   final response = await http.get(
//     Uri.parse(
//         'https://api.unsplash.com/photos/?client_id=Xq2ECd-hdDq8E6pW8C6g7VmNbOJwmVbutih9niMl2VM&per_page=30'), // Replace with your API endpoint
//   );

//   if (response.statusCode == 200) {
//     List<dynamic> jsonResponse = json.decode(response.body);
//     return jsonResponse.map((data) => PhotoModal.fromJson(data)).toList();
//   } else {
//     throw Exception('Failed to load photos');
//   }
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: PhotoListScreen(),
//     );
//   }
// }

// class PhotoListScreen extends StatelessWidget {
//   final Future<List<PhotoModal>> photos = fetchPhotos();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Photos'),
//       ),
//       body: FutureBuilder<List<PhotoModal>>(
//         future: photos,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No photos available'));
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 PhotoModal photo = snapshot.data![index];
//                 return ListTile(
//                   leading: Image.network(photo.urls.thumb),
//                   title: Text(
//                     photo.altDescription,
//                     style: TextStyle(),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
