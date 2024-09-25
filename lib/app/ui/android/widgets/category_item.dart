import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/data/model/event.dart';
import 'package:getx/app/ui/android/widgets/ticket_item.dart';

import '../../../controller/host_controller.dart';
import '../../../data/constants/errors.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/api_response.dart';
import 'miscellaneous.dart';


class CategoryItem extends StatefulWidget {
  late String categoryId;
  late String phaseId;
  CategoryItem({required this.categoryId,required this.phaseId,Key? key}) : super(key: key);

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  TextEditingController ticketNameController=TextEditingController(),ticketPriceController=TextEditingController(),ticketCountController=TextEditingController(text: "-1");
  @override
  Widget build(BuildContext context) {
      return AsyncBuilder<APIResponse>(
        future: Get.find<HostController>().getCategory(widget.categoryId),
        waiting: (context) {
          return Center(
            child: clumsyWaitingBar(),
          );
        },
        builder: (context,apiResponse){
          if(apiResponse!.status == TextMessages.SUCCESS)
          {
            PhaseCategory category = apiResponse.data as PhaseCategory;
            print("category");
            print(category);
            List<CategoryTicket> tickets = category.tickets;
            return Center(
              child: Container(
                width: Get.width*0.7,
                margin:EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: appColors["background"]!,
                    border: Border.all(color: appColors["grey"]!),
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(width: 40,),
                          Column(
                            children: [
                              clumsyTextLabel("Category Name",color: appColors["grey"]!,fontsize: 12),
                              clumsyTextLabel(category.name,color: appColors["primary"]!,fontsize: 22),

                            ],
                          ),
                          // SizedBox(width: 40,),
                          Row(
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                      onTap: () async {
                                          await callDialog("Ticket Information",
                                              Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    // color: Color(0xff36363D),
                                                    border: Border.all(color:appColors["grey"]!),
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(18.0),
                                                    child: TextFormField(
                                                      controller: ticketNameController,
                                                      autofocus: false,
                                                      cursorColor: appColors["primary"]!,
                                                      cursorRadius: Radius.circular(10),
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        labelText: "Ticket Name",
                                                        labelStyle: TextStyle(color: appColors["primary"]!),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    // color: Color(0xff36363D),
                                                    border: Border.all(color:appColors["grey"]!),
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(18.0),
                                                    child: TextFormField(
                                                      controller: ticketPriceController,
                                                      autofocus: false,
                                                      cursorColor: appColors["primary"]!,
                                                      cursorRadius: Radius.circular(10),
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        labelText: "Price",
                                                        labelStyle: TextStyle(color: appColors["primary"]!),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    // color: Color(0xff36363D),
                                                    border: Border.all(color:appColors["grey"]!),
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(18.0),
                                                    child: TextFormField(
                                                      controller: ticketCountController,
                                                      autofocus: false,
                                                      cursorColor: appColors["primary"]!,
                                                      cursorRadius: Radius.circular(10),
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        labelText: "Max Supply(-1 for Infinite)",
                                                        labelStyle: TextStyle(color: appColors["primary"]!),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // ClumsyFinalButton("Create", Get.width*0.7, () async {
                                                //   Get.back();
                                                //   await attemptCreateCategory(categoryController.text);
                                                //   setState(() {
                                                //
                                                //   });
                                                // }, false),
                                                // ClumsyFinalButton("Cancel", Get.width*0.7, () async {
                                                //   Get.back();
                                                // }, false)

                                                Row(
                                                  children: [
                                                    ClumsyFinalButton("Create", Get.width*0.4, () async {
                                                      Get.back();
                                                      await attemptCreateTicket(ticketNameController.text,ticketPriceController.text,ticketCountController.text);
                                                      setState(() {
                                                        // phaseWait=false;
                                                      });
                                                    }, false),
                                                    ClumsyFinalButton("Cancel", Get.width*0.4, () async {
                                                      Get.back();
                                                    }, false)
                                                  ],
                                                )
                                          ],
                                          )
                                          );
                                          //await attemptCreateCategory(categoryController.text);
                                          // setState(() {
                                          // categoryWait=false;
                                          // });
                                      },
                                      child: Icon(Icons.add,color: appColors["green"]!,size: 30,)),
                                  clumsyTextLabel("Add Ticket",color: appColors["grey"]!,fontsize: 12),


                                ],
                              ),

                            ],
                          ),
                          // Row(
                          //   children: [
                          //
                          //     Padding(
                          //       padding: const EdgeInsets.all(18.0),
                          //       child: Icon(Icons.add,color: appColors["background"]!,size: 40,),
                          //     ),
                          //     Padding(
                          //       padding: const EdgeInsets.all(18.0),
                          //       child:,
                          //     ),
                          //
                          //   ],
                          // ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    if(tickets.isNotEmpty)
                      ...List.generate(tickets.length, (index){
                        print("generating Tickets widget");
                        return Container(
                          // padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.only(top:18.0),
                          child: Row(
                            children: [
                              Flexible(
                                  flex:6,
                                  child: TicketItem(index:index+1,ticketId: tickets[index].id,categoryId: category.id,)),


                              Flexible(
                                flex: 1,
                                child: InkWell(
                                    onTap: () async {
                                      await callDialog("Are you sure?", Row(
                                        children: [
                                          ClumsyFinalButton("No", Get.width*0.3, () {
                                            Get.back();
                                          }, false),
                                          ClumsyFinalButton("Yes", Get.width*0.3, () {
                                            Get.back();
                                             attemptDeleteTicket(tickets[index].id);

                                            setState(() {

                                            });

                                          }, false)
                                        ],
                                      )
                                      );
                                    },
                                    child: const Icon(Icons.delete,color: Colors.red,)
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image.asset("assets/images/logo_title.png",width: Get.width/1.5,),
                          if(tickets.isEmpty) clumsyTextLabel("Seems like You have created 0 tickets",fontsize: 12),
                          // ClumsyFinalButton("Categories +", Get.width*0.3, () async {
                          //   await callDialog("Name for the Phase Category",
                          //       Column(
                          //       mainAxisAlignment: MainAxisAlignment.start,
                          //       children: [
                          //       Container(
                          //       margin: EdgeInsets.all(10),
                          //   decoration: BoxDecoration(
                          //   // color: Color(0xff36363D),
                          //   border: Border.all(color:appColors["grey"]!),
                          //   borderRadius: BorderRadius.circular(20),
                          //   ),
                          //   child: Padding(
                          //   padding: const EdgeInsets.all(18.0),
                          //   child: TextFormField(
                          //   controller: categoryController,
                          //   autofocus: false,
                          //   cursorColor: appColors["primary"]!,
                          //   cursorRadius: Radius.circular(10),
                          //   decoration: InputDecoration(
                          //   border: InputBorder.none,
                          //   labelText: "Category Name",
                          //   labelStyle: TextStyle(color: appColors["primary"]!),
                          //   ),
                          //   ),
                          //   ),
                          //   ),
                          //         // ClumsyFinalButton("Create", Get.width*0.7, () async {
                          //         //   Get.back();
                          //         //   await attemptCreateCategory(categoryController.text);
                          //         //   setState(() {
                          //         //
                          //         //   });
                          //         // }, false),
                          //         // ClumsyFinalButton("Cancel", Get.width*0.7, () async {
                          //         //   Get.back();
                          //         // }, false)
                          //
                          //         Row(
                          //           children: [
                          //             ClumsyFinalButton("Create", Get.width*0.4, () async {
                          //               Get.back();
                          //               await attemptCreateCategory(categoryController.text);
                          //               setState(() {
                          //                 // phaseWait=false;
                          //               });
                          //             }, false),
                          //             ClumsyFinalButton("Cancel", Get.width*0.4, () async {
                          //               Get.back();
                          //             }, false)
                          //           ],
                          //         )
                          //   ],
                          //   )
                          //   );
                          //   //await attemptCreateCategory(categoryController.text);
                          //   // setState(() {
                          //   // categoryWait=false;
                          //   // });
                          // }, false)
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 50,
                    ),
                    // Divider(color: appColors["white"]!,),
                  ],
                ),
              ),
            );
          }
          else
          {
            print(apiResponse!.info!);
            return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                  const Text("Some error Occured"),
                  Text(error.toString()),
                ],
              )
          );
        },
      );
    }
  Future<bool> attemptCreateTicket(String name,String price,String maxCount) async {
    Map<String,dynamic> eventJson = {};

    if(name.isEmpty)
    {
      showSnackbar("Error", "Please enter a NAME for the Ticket");
      return false;
    }

    if(price.isEmpty || num.tryParse(maxCount)==null)
    {
      showSnackbar("Error", "Please enter a valid Price for the Ticket");
      return false;
    }

    price = num.tryParse(price).toString();
    print("price");

    if(maxCount.isEmpty || num.tryParse(maxCount)==null)
    {
      showSnackbar("Error", "Please enter a valid Supply");
      return false;
    }

    num? j = num.tryParse(maxCount);

    if(j! < -1)
      {
        j=-1;
      }

    eventJson['name'] = name;
    eventJson['price'] = price;
    eventJson['supply'] = j;
    eventJson['category_id'] = widget.categoryId;
    APIResponse res = await Get.find<HostController>().createTicket(eventJson);

    if(res.status == TextMessages.SUCCESS)
    {
      showSnackbar(TextMessages.SUCCESS,"Successfully created the Ticket!");
      return true;
    }
    else
    {
      showSnackbar("Error", res.info!);
      return false;
    }

  }
  Future<bool> attemptDeleteTicket(String ticketId) async {

    APIResponse res = await Get.find<HostController>(). deleteTicket(ticketId);
    if(res.status == TextMessages.SUCCESS)
    {
      showSnackbar(TextMessages.SUCCESS,"Successfully deleted the ticket!");
      return true;
    }
    else
    {
      showSnackbar("Error", res.info!);
      return false;
    }

  }
  }
