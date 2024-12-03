import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app/bloc/photo_bloc.dart';
import 'package:wallpaper_app/view/home/widgets/bottomnavbar.dart';
import 'package:wallpaper_app/view/home/widgets/header.dart';
import '../widgets/product_card.dart';
import 'dart:io';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

enum _SelectedTab { home, favorite, add, search, person }

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ScrollController scrollController = ScrollController();
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  Future<void> _saveImage({
    required BuildContext context,
    required String url,
  }) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    String message;

    try {
      // Download image
      final response = await http.get(Uri.parse(url));

      // Get temporary directory
      final dir = await getTemporaryDirectory();

      // Create an image name
      final filename = '${dir.path}/SaveImage${DateTime.now()}.png';

      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      // Ask the user to save it
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        message = 'Image saved to disk';
      } else {
        message = 'Image saving canceled';
      }
    } catch (e) {
      message = e.toString();
    }

    scaffoldMessenger.showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.black,
    ));
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PhotoBloc>(context).add(PhotoInitailFetchEvent());
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final photoBloc = context.read<PhotoBloc>();
    if (_isBottom && !photoBloc.isFetching && !photoBloc.hasReachedMax) {
      photoBloc.add(PhotoFetchMoreEvent());
    }
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.black,
        body: BlocBuilder<PhotoBloc, PhotoState>(
          builder: (context, state) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'All Products',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        if (state is PhotoFetchLoadingState)
                          const Center(child: CircularProgressIndicator()),
                        if (state is PhotoFetchingSucessfulstate) ...[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MasonryGridView.count(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              crossAxisCount: 2,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.post.length,
                              itemBuilder: (context, index) {
                                double ht = ((index % 4) + 1) * 80;
                                final product = state.post[index];
                                return InkWell(
                                  onTap: () => _saveImage(
                                    context: context,
                                    url: product.urls.regular,
                                  ),
                                  child: ProductCard(
                                    ht: ht,
                                    price: '\$${index * 6}',
                                    image: product.urls.regular,
                                    title: product.description ?? '',
                                  ),
                                );
                              },
                            ),
                          ),
                          if (!state.hasReachedMax)
                            const Center(child: CircularProgressIndicator())
                        ],
                        if (state is PhotoFetchErrorState)
                          const Center(child: Text('Failed to load products')),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: CrystalNavigationBar(
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          height: 10,
          // indicatorColor: Colors.blue,
          unselectedItemColor: Colors.white70,
          backgroundColor: Colors.white,

          onTap: _handleIndexChanged,
          items: [
            /// Home
            CrystalNavigationBarItem(
                icon: Icons.home,
                selectedColor: Colors.red,
                unselectedColor: Colors.redAccent),

            /// Favourite
            /// Search
            CrystalNavigationBarItem(
                unselectedColor: Colors.grey,
                icon: Icons.search,
                selectedColor: Colors.grey),
            CrystalNavigationBarItem(
                icon: Icons.notifications,
                selectedColor: Colors.grey,
                unselectedColor: Colors.grey),

            /// Add
            CrystalNavigationBarItem(
                icon: Icons.circle,
                selectedColor: Colors.grey,
                unselectedColor: Colors.grey),

            /// Profile
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
