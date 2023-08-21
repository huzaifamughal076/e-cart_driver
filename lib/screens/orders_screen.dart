import 'package:ecart_driver/screens/order_selection_screen.dart';
import 'package:ecart_driver/utils/constants/app_constants.dart';
import 'package:ecart_driver/utils/constants/font_constants.dart';
import 'package:ecart_driver/utils/helping_method.dart';
import 'package:ecart_driver/widgets/dash_line.dart';
import 'package:ecart_driver/widgets/order_item.dart';
import 'package:ecart_driver/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<String> _tabs = [];
  int selectedTab = 0;
  PageController? controller;
  TextEditingController searchController = TextEditingController();
  FocusNode searchNode = FocusNode();
  final HelpingMethods helpingMethods = HelpingMethods();

  @override
  void initState() {
    controller = PageController(initialPage: selectedTab);
    _tabs = [
      AppConstants.pickOrders,
      AppConstants.orderDelivered,
    ];
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          AppConstants.allOrders,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: FontConstants.bold,
              color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTabs(),
          _buildPages(),
        ],
      ),
    );
  }

  Widget _buildPages() => Expanded(
          child: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildPickOrders(),
          orderListView(),
        ],
      ));

  Widget _buildTabs() => SizedBox(
        height: 75,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(width: 16),
          itemCount: _tabs.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () {
              selectedTab = index;
              setState(() {});
              controller!.animateToPage(selectedTab,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
            },
            child: Chip(
                label: Text(_tabs[index]),
                backgroundColor: selectedTab == index
                    ? const Color(0xffE1F5E9)
                    : const Color(0xffF3F2F4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                labelPadding: const EdgeInsets.symmetric(horizontal: 25),
                labelStyle: TextStyle(
                    color: selectedTab == index
                        ? const Color(0xff1B7575)
                        : const Color(0xff969696),
                    fontFamily: FontConstants.medium,
                    fontWeight: FontWeight.w500)),
          ),
        ),
      );

  Widget _buildPickOrders() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                    child: textField(
                  textInputAction: TextInputAction.search,
                  hintText: AppConstants.deliveryLocation,
                  controller: searchController,
                  focusNode: searchNode,
                  isCode: true,
                  isSearch: true,
                )),
                Container(
                  height: 48,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: orderListView(),
          )
        ],
      );

  ListView orderListView() {
    return ListView.separated(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            itemCount: 10,
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 16),
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: (){
                helpingMethods.openScreen(context: context, screen: const OrderSelectionScreen());
              },
                child: orderItem(index)),
          );
  }
}
