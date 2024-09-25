import 'dart:io';

import 'package:async_builder/async_builder.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/controller/home/home_controller.dart';
import 'package:getx/app/controller/host_controller.dart';
import 'package:getx/app/controller/networking/networking.dart';
import 'package:getx/app/data/model/wallet.dart';
import 'package:getx/app/routes/app_pages.dart';
import 'package:getx/app/ui/android/widgets/loading_widget.dart';
import 'package:getx/app/ui/android/widgets/miscellaneous.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:simple_s3/simple_s3.dart';

import '../../../data/constants/errors.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/api_response.dart';
import '../../../data/model/booking.dart';
import '../../../data/model/event.dart';

class HostWallet extends StatefulWidget {
  // late Function openPage;
  HostWallet({super.key});

  @override
  State<HostWallet> createState() => _HostWalletState();
}

class _HostWalletState extends State<HostWallet> {

  @override
  Widget build(BuildContext context) {
    return Material(
        color: appColors["background"]!,
        child: SafeArea(
          child: Column(
            children: [
              headerBar("Wallet",parent: true),
              Expanded(
                child: AsyncBuilder<APIResponse>(
                  future: Get.find<HostController>().getMyWallet(),
                  waiting: (context) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  builder: (context,apiResponse){
                    if(apiResponse!.status == TextMessages.SUCCESS)
                    {
                      Wallet wallet = apiResponse.data as Wallet;
                      return ScrollConfiguration(
                        behavior: ScrollBehavior(),
                        child: GlowingOverscrollIndicator(
                          axisDirection: AxisDirection.down,
                          color: appColors["primary"]!,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(child: clumsyTextLabel("Host Wallet",color: appColors["white"]!,fontsize: 30)),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: clumsyTextLabel("Outstanding Amount: Rs ${wallet.unsettledAmount}",color: appColors["primary"]!),
                                  ),
                                ),

                                Divider(),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: clumsyTextLabel("transactions #${wallet.transactions.length}",fontsize: 10),
                                  ),
                                ),
                                if(wallet.transactions.isNotEmpty)
                                  ...List.generate(wallet.transactions.length, (index){
                                    return hostsWalletTransaction(wallet.transactions[index]);
                                  })
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    else
                    {
                      // showSnackbar("Error", apiResponse!.info!);
                      print(apiResponse.info!);
                      return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              headerBar("Wallet",parent: false),
                              Text(ErrorMessages.SOMETHINGS_WRONG),

                              ClumsyFinalButton("Retry", Get.width*0.6, () {
                                setState(() {

                                });
                              }, false)
                              // Text(error.toString()),
                            ],
                          )
                      );
                    }

                  },
                  error: (context, error, stackTrace) {
                    return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/favicon.png"),
                            Text("Some error Occured"),
                            // Text(error.toString()),
                            ClumsyRealButton("Retry", Get.width, () {
                              setState(() {

                              });
                            }, false),
                          ],
                        )
                    );
                  },
                ),
              ),
            ],
          ),
        )

      );
  }
}
