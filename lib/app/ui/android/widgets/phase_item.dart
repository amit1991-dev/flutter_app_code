import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/data/model/event.dart';
import 'package:getx/app/ui/android/widgets/category_item.dart';
import '../../../controller/host_controller.dart';
import '../../../data/constants/errors.dart';
import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/api_response.dart';
import 'miscellaneous.dart';

class PhaseItem extends StatefulWidget {
  late String phaseId;
  late String eventId;
  late int seqNum;
  PhaseItem({required this.phaseId, required this.eventId,required this.seqNum,Key? key}) : super(key: key);

  @override
  State<PhaseItem> createState() => _PhaseItemState();
}

class _PhaseItemState extends State<PhaseItem> {
  TextEditingController categoryController = TextEditingController();
  bool categoryWait = false;
  @override
  Widget build(BuildContext context) {
    return AsyncBuilder<APIResponse>(
      future: Get.find<HostController>().getPhase(widget.phaseId),
      waiting: (context) {
        return Center(
          child: clumsyWaitingBar(),
        );
      },
      builder: (context,apiResponse){
        if(apiResponse!.status == TextMessages.SUCCESS)
        {
          EventPhase phase = apiResponse.data as EventPhase;
          print(phase.categories);
          List<PhaseCategory> categories = phase.categories;
          return Center(
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: appColors["background"]!,
                // border: Border.all(color: appColors["grey"]!),
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
                        Row(
                          children: [
                            clumsyTextLabel(widget.seqNum.toString()+".",color: appColors["primary"]!,fontsize: 42),
                            SizedBox(width: 10,),
                            Column(
                              children: [
                                clumsyTextLabel("Phase Name",color: appColors["grey"]!,fontsize: 12),
                                clumsyTextLabel(phase.name,color: appColors["primary"]!,fontsize: 22),

                              ],
                            ),
                          ],
                        ),
                        // SizedBox(width: 40,),
                        Row(

                          children: [
                            Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await callDialog("Name for the Phase Category",
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
                                          controller: categoryController,
                                          autofocus: false,
                                          cursorColor: appColors["primary"]!,
                                          cursorRadius: Radius.circular(10),
                                          decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelText: "Category Name",
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
                                                      if(await attemptCreateCategory(categoryController.text))
                                                      {
                                                        setState(() {
                                                          // phaseWait=false;
                                                        });
                                                      }
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
                                    child: Icon(Icons.add,color: appColors["green"]!,size: 30,)
                                ),
                                clumsyTextLabel("Add Category",color: appColors["grey"]!,fontsize: 12),


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

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(categories.isNotEmpty)
                          ...List.generate(categories.length, (index){
                            print("generating Categories widget");
                            return Container(
                              // padding: const EdgeInsets.all(8.0),
                              margin: const EdgeInsets.only(top:18.0),
                              child: Column(
                                children: [
                                  CategoryItem(categoryId: categories[index].id,phaseId: phase.id,),
                                  SizedBox(width: 40,),
                                  Column(
                                    children: [
                                      InkWell(
                                          onTap:() async {
                                            await callDialog("Are you sure?", Row(
                                              children: [
                                                ClumsyFinalButton("No", Get.width*0.3, () {
                                                  Get.back();
                                                }, false),
                                                ClumsyFinalButton("Yes", Get.width*0.3, () async {
                                                  Get.back();
                                                  await attemptDeleteCategory(categories[index].id);

                                                  setState(() {

                                                  });

                                                }, false)
                                              ],
                                            )
                                            );
                                          },
                                          child: Icon(Icons.delete,color: appColors["white"]!,size: 30,)
                                      ),
                                      clumsyTextLabel("Delete Category",color: appColors["grey"]!,fontsize: 12),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                      ],
                    ),
                  ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image.asset("assets/images/logo_title.png",width: Get.width/1.5,),
                          if(categories.isEmpty) clumsyTextLabel("Seems like You have created 0 categories",fontsize: 12),
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
          // showSnackbar("Error", apiResponse!.info!);
          print(apiResponse!.info!);
          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  headerBar("All Phases",parent: false),
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
                Text("Some error Occured"),
                Text(error.toString()),
              ],
            )
        );
      },
    );
  }

  Future<bool> attemptCreateCategory(String text) async {
    Map<String,dynamic> eventJson = {};
    if(text.isEmpty)
    {
      showSnackbar("Error", "Please enter a NAME for the Category");
      return false;
    }
    eventJson['name'] = text;
    eventJson['phase_id']= widget.phaseId;
    APIResponse res = await Get.find<HostController>().createCategory(eventJson);
    if(res.status == TextMessages.SUCCESS)
    {
      showSnackbar(TextMessages.SUCCESS,"Successfully created the Category!");
      return true;
    }
    else
    {
      showSnackbar("Error", res.info!);
      return false;
    }

  }

  Future<bool> attemptDeleteCategory(String categoryId) async {
    // print("deleteing category");
    APIResponse res = await Get.find<HostController>(). deleteCategory(categoryId);
    if(res.status == TextMessages.SUCCESS)
    {
      showSnackbar(TextMessages.SUCCESS,"Successfully deleted the Category!");
      return true;
    }
    else
    {
      showSnackbar("Error", res.info!);
      return false;
    }

  }

}