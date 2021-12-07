
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moon/layout/cubit/cubit.dart';
import 'package:moon/layout/cubit/states.dart';
import 'package:moon/models/category_models.dart';
import 'package:moon/modules/categories/categories_items_screen.dart';
import 'package:moon/modules/search/search_screen.dart';
import 'package:moon/shared/components/components.dart';
import 'package:moon/shared/components/constance.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {

          return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: buildAppBar(context),
            body: Column(
              children: [
                _buildListView(context),
              ],
            ),
          );
        },
    );
  }


  /// Category List View
  Widget _buildListView(context) {
    var cubit = HomeCubit.get(context);
    return Expanded(
      child: RefreshIndicator(
        onRefresh: HomeCubit.get(context).onRefresh,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        color: HexColor('1a2f3f'),
        child: ListView.separated(
          padding: EdgeInsets.only(
              top: 5,
              bottom: 5
          ),
          itemBuilder: (context, index) => _buildCategoryList(
            cubit.categoryModels!.data!.data[index],
            context,
          ),
          separatorBuilder: (context, index) => heightSizedBox(5),
          itemCount: cubit.categoryModels!.data!.data.length,
        ),
      ),
    );
    }

  /// Category card
  Widget _buildCategoryList(CategoryData categoryData,context)=> Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5,),
    child: Container(
      height: 170,
      width: double.infinity,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: HexColor('1a2f3f'),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // _heightSizeDBox(10),
            Container(
              height: double.infinity,
              width: double.infinity,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: NetworkImage('${categoryData.image}'),
                  fit: BoxFit.fill
                )
              ),
              child: Material(
               color: Colors.transparent,
                child: InkWell(
                  highlightColor: Colors.amber.withOpacity(0.1),
                  splashColor: Colors.amber.withOpacity(0.3),
                  onTap: ()
                  {
                    HomeCubit.get(context).getCategoryData(categoryId: categoryData.id!);
                    Navigator.of(context).push(
                      CustomPageRoute(
                        child : CategoriesItemsScreen(
                            name: categoryData.name!),
                        direction: AxisDirection.right,
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 5
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: HexColor('1a2f3f'),
                    borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Text(
                    '${categoryData.name}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),

          ],

        ),
      ),
    ),
  );

}
