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