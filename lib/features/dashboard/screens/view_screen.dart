import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mess_mgmt/Global/enums/enums.dart';
import 'package:mess_mgmt/Global/enums/pagination_enum.dart';
import 'package:mess_mgmt/Global/models/coupon_data_model.dart';
import 'package:mess_mgmt/Global/widgets/custom_filter_dialog.dart';
import 'package:mess_mgmt/Global/widgets/custom_list_tile.dart';
import 'package:mess_mgmt/Global/widgets/loader.dart';
import 'package:mess_mgmt/features/dashboard/stores/dashboard_store.dart';

class ViewScreen extends StatelessWidget {
  const ViewScreen({
    super.key,
    required this.mealTimeType,
  });
  final MealTimeType mealTimeType;

  @override
  Widget build(BuildContext context) {
    List<CouponDataModel> list = [];
    switch (mealTimeType) {
      case MealTimeType.breakfast:
        list = dashboardStore.breakfastList;
        break;
      case MealTimeType.lunch:
        list = dashboardStore.lunchList;
        break;
      case MealTimeType.dinner:
        list = dashboardStore.dinnerList;
        break;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(mealTimeType.intoString()),
        actions: [
          TextButton.icon(
            onPressed: () {
              showFilterDialog(context: context);
            },
            label: const Text('Apply Filter'),
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blueAccent.withOpacity(0.2),
              Colors.white.withOpacity(1),
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Observer(builder: (context) {
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    if (index == list.length - 1) {
                      return Column(children: [
                        GlassyListTile(coupon: list[index], i: index),
                        Observer(builder: (context) {
                        //   final pagination = dashboardStore.breakfastPagination;

                        //   if (pagination == PaginationEnum.loading) {
                        //     return const AppLoader();
                        //   } else if (pagination == PaginationEnum.empty) {
                        //     return const SizedBox();
                        //   }
                          return ElevatedButton.icon(
                            onPressed: () {
                              dashboardStore.loadMore(type: mealTimeType);
                            },
                            label: const Text(
                              '- - - LoadMore - - -',
                            ),
                          );
                        }),
                      ]);
                    } else {
                      return GlassyListTile(
                        coupon: list[index],
                        i: index,
                      );
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
