/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malabis_app/logic/authentication/authentication_cubit.dart';
import 'package:malabis_app/logic/home/home_cubit.dart';
import 'package:malabis_app/logic/home/home_state.dart';
import 'package:malabis_app/util/constant.dart';
import 'package:malabis_app/views/components/assets_provider.dart';
class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context, listen: false);
    final authCubit = BlocProvider.of<AuthenticationCubit>(context, listen: false);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kUniversalColor,
            title: const Text("All Categories"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: 3,
              children: List.generate(
                state.categoryResult!.data?['listCategoriesFilter']['categorys'].length,
                    (index) {
                  final data = state.categoryResult!.data?['listCategoriesFilter'];
                  var d = data['categorys'];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        cubit.assignCategoryId(d[index]['id'],authCubit.getuserID as int);
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: 8,
                                right: 8,
                                top: index == 0 ? 8.0 : 0,
                                bottom: index == 0 ? 8.0 : 0),
                            decoration: BoxDecoration(
                              // color: Color(0xffE4F9E8),
                                borderRadius: BorderRadius.circular(15)),
                            child: index == 0
                                ? const AssetProvider(
                              asset: "assets/category_icon/all_prod.png",
                              height: 40,
                              // width: 50,
                            )
                                : Image.network(
                              d[index]['image'],
                              height: 50,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            index == 0
                                ? "All Products"
                                : d[index]['description']['name'],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),),
              // itemBuilder: (ctx, i) {
              //   return Image.network(state.categoryResult!.data?['listCategoriesFilter']['categorys'][i]['image'],height: 50,width: 50,fit: BoxFit.fill,);
              // },
            ),
        );
      }
    );
  }
}
*/

import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  final List<String> popularCategories = const [
    'Electronics',
    'Fashion',
    'Home & Garden',
    'Beauty',
    'Sports'
  ];

  final List<String> otherCategories = const [
    'Books',
    'Toys',
    'Groceries',
    'Automotive',
    'Office Supplies',
    'Pets'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('All Categories'),
        backgroundColor: const Color(0xFFC58900),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Popular Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...popularCategories.map(
            (category) => ListTile(
              leading: const Icon(Icons.star, color: Colors.orange),
              title: Text(category),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to products by category
              },
            ),
          ),
          const Divider(height: 32),
          const Text(
            'Other Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...otherCategories.map(
            (category) => ListTile(
              leading: const Icon(Icons.category),
              title: Text(category),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to products by category
              },
            ),
          ),
        ],
      ),
    );
  }
}
