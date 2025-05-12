/*import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malabis_app/logic/home/home_cubit.dart';
import 'package:malabis_app/logic/home/home_state.dart';
import 'package:malabis_app/util/config/asset_config.dart';
import 'package:malabis_app/util/constant.dart';
import 'package:malabis_app/views/components/assets_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
class Bannerhome extends StatelessWidget {
  const Bannerhome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit,HomeState>(builder: (context,state){
      if(state.bannerImageStatus == 'searching'){
        return Shimmer.fromColors(
          direction: ShimmerDirection.ttb,
          baseColor: Colors.grey[200]!,
          highlightColor: Colors.grey,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }else{
        return CarouselSlider(
            items: state.bannerImagesList!.map((e){
              return Container(
                height: 150,
                decoration: BoxDecoration(
                  // border: Border.all(color: kUniversalColor),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(e['promotion_image'])
                  )
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: kIsWeb ? 300 : 150,
              aspectRatio: 16/9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            )
        );
      }
    });
  }
}
Widget oldBannerWidget(){
  return Container(
    height: 150,
    decoration: BoxDecoration(
      color: kUniversalColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          width: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Get 10% Off",
              style: GoogleFonts.montserrat(
                  fontSize: 25,
                  color: Colors.white,
                  shadows: const [
                    Shadow(color: Color(0xffFBC108), offset: Offset(2, 0))
                  ]),
            ),
            const SizedBox(
              height: 7,
            ),
            Text("All Fruits and vegetables",
                style: GoogleFonts.montserrat(
                  fontSize: 11,
                  color: Colors.white,
                )),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xffFBC108),
              ),
              child: Text("Period 25th Nov - 5th Dec",
                  style: GoogleFonts.montserrat(
                      fontSize: 8, color: Colors.white)),
            )
          ],
        ),
        const Expanded(child: AssetProvider(asset: AssetConfig.cardImg)),
      ],
    ),
  );
}
*/