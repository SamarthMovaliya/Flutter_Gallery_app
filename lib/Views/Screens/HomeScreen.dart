import 'package:flutter/material.dart';
import 'package:gallery_viewer_api_app/Controller/Helpers/API_Helper.dart';
import 'package:gallery_viewer_api_app/Controller/Providers/ThemeProvider/ThemeProvider.dart';
import 'package:gallery_viewer_api_app/Modal/Modal_classes/Api_modal_class.dart';
import 'package:gallery_viewer_api_app/Modal/resources/res.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../Controller/Providers/CattegoryProvider/Category_Provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future data;

  @override
  void initState() {
    data = APIHelper.apiHelper.fetchImagesFromApi(s: "popular");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: (Provider.of<ThemeProvider>(context)
                                .themeModal
                                .isDark ==
                            false)
                        ? Colors.grey
                        : Colors.black,
                    offset: Offset(2, 3),
                    blurRadius: 10,
                  )
                ],
                borderRadius: BorderRadius.circular(50),
                image: const DecorationImage(
                  image:
                      AssetImage('assets/images/pexels-pixabay-268966 (2).jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.srgbToLinearGamma(),
                  opacity: 0.8,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.menu_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .changeTheTheme();
                            },
                            child: const Icon(
                              Icons.sunny,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'What Would you like to search?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontSize: 45,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: TextField(
                        onChanged: (val) async {
                          setState(() {
                            data =
                                APIHelper.apiHelper.fetchImagesFromApi(s: val);
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          prefix: const SizedBox(
                            width: 10,
                          ),
                          hintText: 'Search',
                          suffixIcon: Icon(
                            Icons.search_rounded,
                            color: Colors.grey.shade600,
                            size: 26,
                          ),
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.grey.shade600,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                          fillColor: Colors.white70,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: category
                    .map(
                      (e) => Builder(builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 16,
                            left: 20,
                            bottom: 12,
                          ),
                          child: Consumer<CategoryProvider>(
                              builder: (context, categoryProvider, _) {
                            return GestureDetector(
                              onTap: () {
                                int f = category.indexOf(e);
                                categoryProvider.changeCategory(indexValue: f);
                                setState(() {
                                  data = APIHelper.apiHelper
                                      .fetchImagesFromApi(s: e);
                                });
                              },
                              child: Container(
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: (categoryProvider.index.i ==
                                          category.indexOf(e))
                                      ? (Provider.of<ThemeProvider>(context)
                                                  .themeModal
                                                  .isDark ==
                                              false)
                                          ? Colors.grey
                                          : Colors.white
                                      : (Provider.of<ThemeProvider>(context)
                                                  .themeModal
                                                  .isDark ==
                                              false)
                                          ? Colors.white
                                          : Colors.grey,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(2, 3),
                                      blurRadius: 8,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Center(
                                    child: Text(
                                      e,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        );
                      }),
                    )
                    .toList(),
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: FutureBuilder(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error Ouccured:${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  List<ApiModal> allData = snapshot.data;
                  return MasonryGridView.count(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(8),
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    itemCount: allData.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            'ViewScreen',
                            arguments: allData[index].image,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            image: DecorationImage(
                              image: NetworkImage(allData[index].image),
                              opacity: 0.9,
                              colorFilter:
                                  const ColorFilter.srgbToLinearGamma(),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Image(
                            image: NetworkImage(allData[index].image),
                            fit: BoxFit.fitHeight,
                            color: Colors.white.withOpacity(0.0),
                            colorBlendMode: BlendMode.modulate,
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                    strokeWidth: 2,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
