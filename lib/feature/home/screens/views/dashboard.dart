import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/styles.dart';
import '../../../../core/utils/responsive.dart';
import '../../../_global/widgets/action_button.dart';
import '../../../_global/widgets/appbar_widget.dart';
import '../../../manage_orders/model/order_details_model.dart';
import '../../../manage_orders/screens/order_details.dart';
import '../../widgets/header_widget.dart';
import '../../widgets/side_bar.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<OrderDetailsModel> orders = orderList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarWidget(
        title: 'Dashboard',
        widget: Responsive.isTablet(context)
            ? IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              )
            : const SizedBox(),
        actions: [
          ActionButton(
            icon: Icons.refresh,
            title: 'Refresh',
            action: () {},
          )
        ],
      ),
      drawer: Responsive.isTablet(context) ? const SideBar() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  child: Row(
                    children: [
                      const HeaderWidget(
                        text: 'Total Number of Orders',
                        amount: 0,
                        icon: Icons.bar_chart_rounded,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                      const HeaderWidget(
                          text: 'Total No. of Products',
                          amount: 0,
                          icon: Icons.shopping_bag_outlined),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                      const HeaderWidget(
                          text: 'Total No. of POS',
                          amount: 0,
                          icon: Icons.storefront_rounded)
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.deepGold),
                    borderRadius: BorderRadius.circular(7)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Latest Orders',
                        style: AppTextStyles.nunitoSansBold,
                      ),
                    ),
                    if (orders.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Container(
                        height: 54,
                        decoration: const BoxDecoration(color: AppColors.grey5),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Order Id',
                              style: AppTextStyles.nunitoSansBold,
                            ),
                            Text(
                              'POS',
                              style: AppTextStyles.nunitoSansBold,
                            ),
                            Text(
                              'DATE',
                              style: AppTextStyles.nunitoSansBold,
                            ),
                            Text(
                              'Customer Name',
                              style: AppTextStyles.nunitoSansBold,
                            ),
                            Text(
                              'Action',
                              style: AppTextStyles.nunitoSansBold,
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final model = orders[index];
                          return Table(
                            border: const TableBorder(
                                bottom: BorderSide(color: AppColors.grey7)),
                            columnWidths: const <int, TableColumnWidth>{
                              0: FlexColumnWidth(4.5),
                              1: FlexColumnWidth(3),
                              2: FlexColumnWidth(4),
                              3: FlexColumnWidth(5),
                              4: FlexColumnWidth(4),
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: [
                              TableRow(children: [
                                // Create a Separate Widget for this
                                Align(
                                    child: Text(
                                  model.orderId,
                                  style: AppTextStyles.sairaGoldSmall
                                      .copyWith(fontWeight: FontWeight.bold),
                                )),
                                Align(child: Text(model.pos)),
                                Align(child: Text(model.updatedAt.toString())),
                                Align(child: Text(model.customerName)),
                                Align(
                                    child: IconButton(
                                        splashRadius: 10,
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderDetails(
                                                        orderDetailsModel:
                                                            model,
                                                      )));
                                        },
                                        icon: const Icon(Icons.info))),
                              ]),
                            ],
                          );
                        },
                      ),
                    ]
                  ],
                ),
              ),
            ]),
            if (orders.isEmpty)
              const Center(
                child: Text(
                  'No latest orders',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.sairaLightGrey,
                ),
              )
          ],
        ),
      ),
    );
  }
}
