import 'package:ecart_driver/utils/constants/app_constants.dart';
import 'package:ecart_driver/utils/constants/font_constants.dart';
import 'package:ecart_driver/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WalletsScreen extends StatefulWidget {
  const WalletsScreen({Key? key}) : super(key: key);

  @override
  State<WalletsScreen> createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8FAF8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xffF8FAF8),
        title: const Text(
          AppConstants.wallet,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: FontConstants.bold,
              color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                title: const Text(
                  "\$39",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: FontConstants.bold,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                subtitle: const Text(
                  AppConstants.remainingAmount,
                  style: TextStyle(
                      fontFamily: FontConstants.medium,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 30)),
                    onPressed: () {
                      _withdrawDialog();
                    },
                    child: Text(
                      AppConstants.withdraw,
                      style: TextStyle(
                          fontFamily: FontConstants.bold,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.primary),
                    )),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildContainer(
                    const Color(0xffFF5555), "pending", AppConstants.totalJobs),
                const SizedBox(width: 16),
                _buildContainer(
                    const Color(0xff1B7575), "wallet", AppConstants.withdrawAmount),
              ],
            ),
            const SizedBox(height: 16),
            buildEarningList(),
          ],
        ),
      ),
    );
  }

  TextEditingController priceController = TextEditingController();
  FocusNode priceNode = FocusNode();

  _withdrawDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  AppConstants.withdraw,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff1B7575),
                      fontFamily: FontConstants.bold,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Amount you want to withdraw",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: FontConstants.bold,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: textField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        hintText: AppConstants.salePriceHint,
                        controller: priceController,
                        focusNode: priceNode,
                        isCode: true,
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 65,
                      decoration: const BoxDecoration(
                          color: Color(0xffF1F2ED),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8))),
                      child: const Icon(
                        Icons.attach_money,
                        color: Color(0xff1B7575),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Colors.white,
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            AppConstants.cancel,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontConstants.bold,
                            ),
                          ),
                        )),
                    const SizedBox(width: 16),
                    Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            AppConstants.withdraw,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: FontConstants.bold,
                            ),
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildEarningList() => ListView.separated(
    shrinkWrap: true,
    primary: false,
    separatorBuilder: (BuildContext context, int index) =>
        const SizedBox(height: 16),
    itemCount: 10,
    itemBuilder: (BuildContext context, int index) =>
        buildEarningItem(index),
  );

  Widget buildEarningItem(index) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
            border: Border.all(color: const Color(0xffEAEAEA)),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Order ID # 219387",
                  style: TextStyle(
                      fontFamily: FontConstants.bold,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  "Total: \$ 512",
                  style: TextStyle(
                      fontFamily: FontConstants.medium,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xff969696)),
                ),
              ],
            ),
            SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Date: 13-07-2021",
                  style: TextStyle(
                      fontFamily: FontConstants.medium,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xff969696)),
                ),
                Text(
                  "Earned: \$ 82",
                  style: TextStyle(
                      fontFamily: FontConstants.bold,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary),
                )
              ],
            )
          ],
        ),
      );

  Widget _buildContainer(Color color, String icon, String subTitle) => Expanded(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              border: Border.all(color: color),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                "images/${icon}_icon.svg",
                color: color,
                width: 50,
                height: 50,
              ),
              const SizedBox(height: 30),
              Text(
                subTitle==AppConstants.totalJobs?"9":"\$329",
                style: TextStyle(
                    fontFamily: FontConstants.bold,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: color),
              ),
              Text(
                subTitle,
                style: const TextStyle(
                    fontFamily: FontConstants.medium,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              )
            ],
          ),
        ),
      );
}
