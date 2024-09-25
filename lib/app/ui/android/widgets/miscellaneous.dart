import 'dart:math';
import 'dart:ui';
import 'package:getx/app/controller/gravity/student_controller.dart';
import 'package:getx/app/controller/gravity/test_series/test_state_controller.dart';
import 'package:getx/app/controller/gravity/test_series/dpp_test_state_controller.dart';

import 'package:getx/app/data/model/gravity/dpp_test_context.dart';
import 'package:getx/app/data/model/gravity/dpp_test_with_sections.dart';
import 'package:getx/app/data/model/gravity/dpp_question_status.dart';

import 'package:getx/app/data/model/gravity/test_context.dart';
import 'package:getx/app/data/model/gravity/test_with_sections.dart';

import '../../../data/constants/request_paths.dart';
import '../../../data/model/gravity/stream.dart';

import '../../../data/constants/miscellaneous.dart';

// import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:get/get.dart';
import '../../../controller/home/home_controller.dart';
import '../../../controller/host_controller.dart';
import '../../../data/model/api_response.dart';
import '../../../data/model/city_state.dart';
import '../../../data/model/wallet.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:location/location.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:permission_handler/permission_handler.dart'
    hide PermissionStatus;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../data/constants/miscellaneous.dart';
import '../../../data/model/booking.dart';
import '../../../data/model/event.dart';
import '../../../data/model/gravity/result.dart';
import '../../../data/model/gravity/test.dart';
import '../../../data/model/media.dart';
import '../../../routes/app_pages.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import 'gravity/test_result_questions.dart';

Widget ClumsySimpleButton(
    String string, double width, VoidCallback voidCallback, bool showProgress) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(border: Border.all(color: appColors["white"]!)),
    margin: const EdgeInsets.all(0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 0, sigmaX: 0),
        child: InkWell(
          highlightColor: appColors["primary"]!,
          focusColor: appColors["white"]!,
          splashColor: appColors["primary"]!,
          onTap: showProgress
              ? () {
                  showSnackbar("Progress", "Request is being processed");
                }
              : voidCallback,
          child: Container(
            padding: const EdgeInsets.all(7),
            // height: Get.width / 8,
            width: width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: appColors["white"]!.withOpacity(.0),
              borderRadius: BorderRadius.circular(15),
            ),
            child: showProgress
                ? clumsyWaitingBar()
                : Text(
                    string,
                    style: GoogleFonts.ubuntu(
                        fontSize: 20, color: appColors["white"]!),
                  ),
          ),
        ),
      ),
    ),
  );
}

Widget ClumsyFinalButton(
    String string, double width, VoidCallback voidCallback, bool showProgress,
    {Color? color}) {
  color ??= appColors["primary"]!;
  return Container(
    margin: const EdgeInsets.all(5),
    decoration: BoxDecoration(
        border: Border.all(color: appColors["white"]!),
        borderRadius: BorderRadius.circular(20)),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 30, sigmaX: 30),
        child: InkWell(
          focusColor: appColors["white"]!,
          splashColor: color,
          onTap: showProgress
              ? () {
                  showSnackbar("Progress", "Request is being processed");
                }
              : voidCallback,
          child: Container(
            height: Get.width / 8,
            width: width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: appColors["white"]!.withOpacity(.0),
            ),
            child: showProgress
                ? clumsyWaitingBar()
                : Text(
                    string,
                    style: GoogleFonts.ubuntu(fontSize: 20, color: color),
                  ),
          ),
        ),
      ),
    ),
  );
}

Widget ClumsyFinalButtonSmall(
    String string, double width, VoidCallback voidCallback, bool showProgress) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(border: Border.all(color: appColors["white"]!)),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 30, sigmaX: 30),
        child: InkWell(
          // highlightColor: appColors["primary"]!,
          focusColor: appColors["white"]!,
          splashColor: appColors["primary"]!,

          onTap: showProgress
              ? () {
                  showSnackbar("Progress", "Request is being processed");
                }
              : voidCallback,
          child: Container(
            alignment: Alignment.center,
            child: showProgress
                ? clumsyWaitingBar()
                : Text(
                    string,
                    style: GoogleFonts.ubuntu(
                        fontSize: 10, color: appColors["white"]!),
                  ),
          ),
        ),
      ),
    ),
  );
}

Widget ClumsyButton(
    String string, double width, VoidCallback voidCallback, bool showProgress,
    {double fontSize = 20}) {
  return GestureDetector(
    onTap: () {
      voidCallback();
    },
    child: Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // color: Color(0xff36363D),
        border: Border.all(color: appColors["grey"]!),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(0),
          width: width,
          alignment: Alignment.center,
          child: showProgress
              ? const CircularProgressIndicator()
              : Text(
                  string,
                  style: GoogleFonts.ubuntu(
                      fontSize: fontSize, color: appColors["primary"]!),
                ),
        ),
      ),
    ),
  );
}

Widget goluheaderBar(String label, {bool parent = true}) {
  return 
  Container(
    margin: EdgeInsets.symmetric(horizontal: 10),
    // padding: EdgeInsets.symmetric(horizontal: 18),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: appColors['primary']),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (parent)
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_circle_left_rounded,
                        size: 25,
                        color: appColors["white"]!,
                      )),
                  Container(
                      margin: const EdgeInsets.all(20),
                      // child: clumsyTextLabel(label,color: appColors["primary"]!,fontsize: 25)
                      child: clumsyTextLabel(label,
                          color: appColors['white']!, fontsize: 20)),
                ],
              )),
        if (!parent)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset("assets/images/c_logo.png", height: 30),
                Container(
                    margin: const EdgeInsets.all(20),
                    // child: clumsyTextLabel(label,color: appColors["primary"]!,fontsize: 25)
                    child: clumsyTextLabel(label,
                        color: appColors['grey'], fontsize: 20)),
              ],
            ),
          ),
      ],
    ),
  );

}


Widget headerBar(String label, {bool parent = true}) {
  return 
  Container(
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: appColors['primary']),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (parent)
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_circle_left_rounded,
                        size: 25,
                        color: appColors["white"]!,
                      )),
                  Container(
                      margin: const EdgeInsets.all(20),
                      // child: clumsyTextLabel(label,color: appColors["primary"]!,fontsize: 25)
                      child: clumsyTextLabel(label,
                          color: appColors['white']!, fontsize: 20)),
                ],
              )),
        if (!parent)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset("assets/images/c_logo.png", height: 30),
                Container(
                    margin: const EdgeInsets.all(20),
                    // child: clumsyTextLabel(label,color: appColors["primary"]!,fontsize: 25)
                    child: clumsyTextLabel(label,
                        color: appColors['grey'], fontsize: 20)),
              ],
            ),
          ),
      ],
    ),
  );

}

Widget ClumsyRealButton(
    String string, double width, VoidCallback voidCallback, bool showProgress,
    {Color? color}) {
  return Container(
    // margin: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: color ?? appColors["white"]!,
      boxShadow: [
        BoxShadow(
          color: appColors['green']!,
          blurRadius: 100,
          offset: const Offset(5.0, 5.0),
        ),
      ],
      // border: Border.all(color:appColors["grey"]!),
      borderRadius: BorderRadius.circular(12),
    ),
    child: TextButton(
      style: ButtonStyle(
        animationDuration: const Duration(seconds: 200),
        overlayColor: MaterialStateProperty.all(appColors["green"]!),
      ),
      onPressed: voidCallback,
      child: Container(
        margin: const EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            width: width,
            alignment: Alignment.center,
            child: showProgress
                ? const CircularProgressIndicator()
                : Text(
                    string,
                    style: GoogleFonts.ubuntu(
                        fontSize: 15, color: appColors["primary"]!),
                  ),
          ),
        ),
      ),
    ),
  );
}

Widget ClumsySimpleWidgetItem(
    Widget w, VoidCallback voidCallback, bool showProgress) {
  return Container(
    margin: const EdgeInsets.all(5),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 30, sigmaX: 30),
        child: InkWell(
          // highlightColor: appColors["primary"]!,
          focusColor: appColors["white"]!,
          splashColor: appColors["primary"]!,

          onTap: showProgress
              ? () {
                  showSnackbar("Progress", "Request is being processed");
                }
              : voidCallback,
          child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: appColors["white"]!.withOpacity(.0),
                // borderRadius: BorderRadius.circular(15),
              ),
              child: showProgress ? const CircularProgressIndicator() : w),
        ),
      ),
    ),
  );
}

Future<Widget> clumsyVideoElement(Media media) async {
  final uint8list = await VideoThumbnail.thumbnailData(
    video: media.url,
    imageFormat: ImageFormat.JPEG,
    maxWidth:
        128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
    quality: 25,
  );
  if (uint8list != null) {
    return InkWell(
      splashColor: appColors["primary"]!,
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 125,
          height: 100,
          decoration: BoxDecoration(
              border: Border.all(
                  color: appColors["primary"]!,
                  style: BorderStyle.solid,
                  width: 2),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: MemoryImage(uint8list), fit: BoxFit.cover)),
          child: Icon(
            Icons.play_circle_outline_rounded,
            color: appColors["white"]!,
            size: 34,
          ),
        ),
      ),
    );
  } else {
    return InkWell(
      splashColor: appColors["primary"]!,
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 125,
          height: 100,
          decoration: BoxDecoration(
              border: Border.all(
                  color: appColors["primary"]!,
                  style: BorderStyle.solid,
                  width: 2),
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                  image: AssetImage("assets/images/c_logo.png"),
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }
}

Widget clumsyMediaWidget(Media media) {
  if (media.mediaType == "image") {
    return InkWell(
      splashColor: appColors["primary"]!,
      onTap: () {
        // showSnackbar("asd", "asdsa");
        Get.toNamed(Routes.IMAGE_VIEWER, arguments: media.url);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 225,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(
                color: appColors["primary"]!,
                style: BorderStyle.solid,
                width: 2),
            borderRadius: BorderRadius.circular(10),
            // image: DecorationImage(image: NetworkImage(media.url), fit: BoxFit.cover)
          ),
          child: Image.network(media.url),
          // child: const Icon(
          //   Icons.play_circle_outline_rounded,
          //   color: appColors["white"]!,
          //   size: 34,
          // ),
        ),
      ),
    );
  } else {
    return FutureBuilder<Widget>(
      future: clumsyVideoElement(media),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[snapshot.data!];
        } else if (snapshot.hasError) {
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            ),
          ];
        } else {
          children = const <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Please Wait'),
            ),
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }
}

Widget ClumsySmallHeading(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(text,
        style: GoogleFonts.ubuntu(color: appColors["primary"]!, fontSize: 20)),
  );
}

Widget ClumsyMediaList(List<Media> medias, {bool host = false}) {
  return Row(
    children: [
      ...List.generate(medias.length, (index) {
        return clumsyMediaWidget(medias[index]);
      }),
      if (host)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: 225,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(
                    color: appColors["primary"]!,
                    style: BorderStyle.solid,
                    width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              // image: DecorationImage(image: NetworkImage(media.url), fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("+ Image"),
                  const Text("OR"),
                  const Text("+ Video"),
                  // ClumsyRealButton("+ Video", Get.width, () { }, false),
                ],
              )),
        ),
    ],
  );
}

// Widget qrCodeGenerate(path) {
//   return QrImage(
//     data: 'This QR code has an embedded image as well',
//     version: QrVersions.auto,
//     size: 320,
//     gapless: false,
//     embeddedImage: const AssetImage('assets/images/favicon.png'),
//     embeddedImageStyle: QrEmbeddedImageStyle(
//       size: const Size(80, 80),
//     ),
//   );
// }

class TicketVerificationSlider extends StatefulWidget {
  final Booking booking;
  const TicketVerificationSlider({Key? key, required this.booking})
      : super(key: key);

  @override
  State<TicketVerificationSlider> createState() =>
      _TicketVerificationSliderState();
}

class _TicketVerificationSliderState extends State<TicketVerificationSlider> {
  // late Booking booking;
  // _TicketVerificationSliderState({required this.booking});
  late int _selectedEntryCount;
  bool _waiting = false;
  @override
  Widget build(BuildContext context) {
    _selectedEntryCount = widget.booking.personCount;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.booking.personCount - widget.booking.verified >= 1)
            NumberPicker(
              value: _selectedEntryCount,
              minValue: 1,
              maxValue: widget.booking.personCount - widget.booking.verified,
              axis: Axis.horizontal,
              textStyle: TextStyle(color: appColors["white"]!),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: appColors["primary"]!),
              ),
              onChanged: (value) => setState(() => _selectedEntryCount = value),
            ),
          // SfSlider(
          //   min: 1.0,
          //   max: widget.booking.personCount.toDouble(),
          //   value: _selectedEntryCount,
          //   interval: 1,
          //   showTicks: true,
          //   showLabels: true,
          //   enableTooltip: true,
          //   minorTicksPerInterval: 1,
          //   activeColor: appColors["primary"]!,
          //   inactiveColor: appColors["grey"]!,
          //   onChanged: (dynamic value){
          //     setState(() {
          //       _selectedEntryCount = value;
          //     });
          //   },
          // ),
          _waiting
              ? const CircularProgressIndicator()
              : ClumsyRealButton("Done", Get.width, () async {
                  setState(() {
                    _waiting = true;
                  });
                  try {
                    if (await Get.find<HostController>()
                        .setEntry(_selectedEntryCount, widget.booking.event)) {
                      Get.back();
                    } else {
                      showSnackbar(
                          "Error", "Entry not marked, could be a server issue");
                    }
                  } catch (err) {
                    showSnackbar("Error", err.toString());
                  }
                }, false)
        ],
      ),
    );
  }
}

Widget createElement(
  String heading,
  Widget child, {
  bool border = true,
}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: border
            ? Border.all(color: appColors["grey"]!)
            : Border.all(color: Colors.transparent)),
    padding: const EdgeInsets.all(0.0),
    child: Column(children: [
      Text(heading,
          style:
              GoogleFonts.ubuntu(color: appColors["primary"]!, fontSize: 22)),
      child,
    ]),
  );
}

class TicketBookingWidget extends StatefulWidget {
  late Event event;
  TicketBookingWidget({Key? key, required this.event}) : super(key: key);

  @override
  State<TicketBookingWidget> createState() => _TicketBookingWidgetState();
}

class _TicketBookingWidgetState extends State<TicketBookingWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.event.currentPhase == null) {
      return const Text("Active Phase not found");
    } else {
      var categories = widget.event.currentPhase!.categories;
      return createElement(
          "",
          Column(
            children: [
              ...List.generate(categories.length, (index) {
                return clumsyCategory(categories[index].name,
                    categories[index].tickets, widget.event);
              })
            ],
          ));
    }
  }
}

class EventInfoWidget extends StatelessWidget {
  late Event event;
  EventInfoWidget({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return createElement(event.name, Column(
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          // color: appColors["white"]!,
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (event.published)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.live_tv,
                    color: appColors["green"]!,
                  ),
                ),
              if (event.published)
                clumsyTextLabel("Event is Live", color: appColors["green"]!),
              if (!event.published)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.airplanemode_inactive,
                    color: appColors["grey"]!,
                  ),
                ),
              if (!event.published)
                clumsyTextLabel("Event is not Live!",
                    color: appColors["grey"]!),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              infoElement("Name", event.name),
              infoElement("Event Date",
                  timeago.format(DateTime.parse(event.eventTimestamp!))),
            ],
          ),
          // infoElement("booking status", event.bookingStatus!.toUpperCase()??"Booking Closed"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              infoElement("category", event.category ?? "-"),
              infoElement("Published", event.published ? "YES" : "NO"),
            ],
          ),
          if (event.published)
            infoElement(
                "Active Phase",
                event.currentPhaseId != null
                    ? event.currentPhase!.name
                    : "Create from below"),
          clientVenueItem(event),
        ],
      ),
    );
  }
}

Widget clumsyText(String text) {
  return Text(text,
      style: GoogleFonts.ubuntu(color: appColors["primary"]!, fontSize: 22));
}

// Widget (String text)
// {
//   return Text(text, style:GoogleFonts.ubuntu(color: appColors["primary"]!,fontSize: 22));
// }

Widget clumsyTextBarookah(String text, {Color? color, double fontSize = 15.0}) {
  color ??= appColors["primary"]!;
  return Text(text,
      style:
          TextStyle(color: color, fontFamily: "Barokah", fontSize: fontSize));
}

Widget clumsyTextLabel(String text, {Color? color, double fontsize = 16,}) {
  color ??= appColors["grey"]!;
  return Text(
    text,
    style: GoogleFonts.ubuntu(color: color, fontSize: fontsize),
    textAlign: TextAlign.start,
  );
}

Widget clumsyTextLabelStylish(String text,
    {Color? color, double fontsize = 16}) {
  color ??= appColors["grey"]!;
  return Text(
    text,
    style: GoogleFonts.laBelleAurore(color: color, fontSize: fontsize),
    textAlign: TextAlign.center,
  );
}

Widget helperItem(String phone, String eventId) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        clumsyTextLabel(phone),
        MaterialButton(
          onPressed: () async {
            APIResponse res = await Get.find<HostController>()
                .removeHelper({"phone": phone}, eventId);
            if (res.status == TextMessages.SUCCESS) {
              showSnackbar("Success", "Removed helper");
            }
          },
          color: appColors["primary"]!,
          textColor: appColors["background"]!,
          child: Column(
            children: [
              const Icon(Icons.delete_forever, size: 24, color: Colors.red),
              clumsyTextLabel("Delete", fontsize: 10, color: Colors.red)
            ],
          ),
          padding: const EdgeInsets.all(16),
          shape: const CircleBorder(),
        ),
      ],
    ),
  );
}

Widget infoElement(final String title, final String content) {
  return createElement(
      "",
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          clumsyTextLabel(title, fontsize: 12),
          clumsyTextLabel(content, color: appColors["primary"]!, fontsize: 15),
        ],
      ),
      border: false);
}

Widget clumsyCategory(
    final String name, List<CategoryTicket> cts, Event event) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("text",
          style: GoogleFonts.ubuntu(color: appColors["grey"]!, fontSize: 16)),
      ...List.generate(cts.length, (index) {
        return clumsyTicketPicker(cts[index], event);
      }),
    ],
  );
}

Widget clumsyTicketPicker(CategoryTicket ct, Event event) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        children: [
          clumsyText(ct.price.toString()),
          clumsyTextLabel(ct.name),
        ],
      ),
      Obx(
        () => Row(
          children: [
            IconButton(
                onPressed: () {
                  Get.find<HomeController>()
                      .incrementCart(ct, event, ct.totalAvailable);
                },
                icon: const Icon(Icons.add_circle_outline)),
            clumsyText(Get.find<HomeController>()
                .cartGetQuantity("${ct.id}", event)
                .toString()),
            IconButton(
                onPressed: () {
                  Get.find<HomeController>().decrementCart(ct.id, event);
                },
                icon: const Icon(Icons.remove_circle_outline))
          ],
        ),
      )
    ],
  );
}

ImageProvider getThumbnail(Event e) {
  if (e.thumbnail == null) {
    return const AssetImage("asets/images/logo_title.png");
  } else {
    return NetworkImage(e.thumbnail!);
  }
}

Widget clumsyWaitingBar() {
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child:
        Center(child: CircularProgressIndicator(color: appColors["primary"]!)),
  );
}

void openPage(page, index) {
  // var page = Get.find<HostController>().page.value;
  switch (index) {
    case 0:
      if (page != 0) {
        Get.toNamed(Routes.HOST_HOME);
      }
      // Get.toNamed(Routes.HOME);
      break;
    case 1:
      if (page != 1) {
        Get.toNamed(Routes.HOST_CREATE_EVENT);
      }
      // Get.toNamed(Routes.SEARCH);
      break;
    case 2:
      if (page != 2) {
        Get.toNamed(Routes.HOST_BOOKINGS);
      }
      // Get.toNamed(Routes.BOOKINGS);
      break;
    case 3:
      if (page != 3) {
        Get.toNamed(Routes.HOST_PROFILE);
      }
      // Get.toNamed(Routes.BOOKINGS);
      break;
  }
}

Widget eventTrendingList(Event event) {
  return Container(
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: InkWell(
      splashColor: appColors["primary"]!,
      onTap: () {
        print(1);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 125,
          height: 100,
          decoration: BoxDecoration(
              border: Border.all(
                  color: appColors["primary"]!,
                  style: BorderStyle.solid,
                  width: 2),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(event.thumbnail!, scale: 10),
                  fit: BoxFit.cover)),
          // child: Image.network("https://picsum.photos/125/100"),
        ),
      ),
    ),
  );
}

Widget eventNormalList(Event event) {
  return InkWell(
    splashColor: appColors["primary"]!,
    onTap: () {
      Get.toNamed(Routes.EVENT, arguments: event.id);
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 225,
        height: 200,
        decoration: BoxDecoration(
            border: Border.all(
                color: appColors["grey"]!, style: BorderStyle.solid, width: 2),
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: NetworkImage(event.thumbnail!, scale: 10),
                fit: BoxFit.cover)),
      ),
    ),
  );
}

Widget streamsNormalList(GravityStream stream) {
  return InkWell(
      splashColor: appColors["primary"]!,
      onTap: () {
        Get.toNamed(Routes.STREAM_PAGE, arguments: stream.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 225,
          height: 100,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey, blurRadius: 20, offset: Offset(10, 10))
            ],
            color: appColors['white']!,
            // border: Border.all(color:Colors.grey,style: BorderStyle.solid,width: 2),
            borderRadius: BorderRadius.circular(10),
            // image: DecorationImage(image:  NetworkImage(event.thumbnail!,scale: 10), fit: BoxFit.cover)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                    height: 20, child: Image.asset('assets/images/glogoB.png')),
              ),
              Center(
                child: clumsyTextLabel(stream.name,
                    fontsize: 12, color: appColors['primary']),
              ),
            ],
          ),
        ),
      ));
}

Widget scrollWidget(Widget child) {
  return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: GlowingOverscrollIndicator(
        color: appColors["background"]!,
        axisDirection: AxisDirection.down,
        child: child,
      ));
}

Future callDialog(String title, Widget child) async {
  return await Get.defaultDialog(
      title: title,

      // middleText: "Select A place",
      backgroundColor: appColors["background"]!,
      titleStyle: TextStyle(color: appColors["primary"]!),
      middleTextStyle: TextStyle(color: appColors["primary"]!),
      radius: 20,
      content: child);
}

Widget gravityTestsList(List<TestWithSections> tests) {
  return Column(
    children: [
      ...List.generate(tests.length, (index) {
        return gravityTestsListTile(tests[index]);
      })
    ],
  );
}

Widget gravityTestsListTile(TestWithSections test) {
  return InkWell(
    // splashColor: appColors["primary"]!,

    onTap: () async {
      await Get.toNamed(Routes.TEST_REPORT_PAGE, arguments: test.id);
    },
    child: testItemWidget(test),
  );
}

Widget gravityDppTestsListTile(DppTestWithSections test) {
  return InkWell(
    // splashColor: appColors["primary"]!,

    onTap: () async {
      await Get.toNamed(Routes.DPP_TEST_REPORT_PAGE, arguments: test.id);
    },
    child: testItemWidgetDpp1(test),
  );
}

Widget testItemWidgetDpp1(DppTestWithSections test) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.all(5),
        // height: Get.height*0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          // color: Colors.red,
          // border: Border.all(color:appColors['primary']!,style: BorderStyle.solid,width: 2),
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(4, 4), blurRadius: 20)
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 2,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      // color: appColors["primary"]!,

                      ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: clumsyTextLabel(test.name.toUpperCase(),
                                  fontsize: 22, color: appColors["primary"]!),
                            ),
                          ),
                          // Spacer(),
                          // Flexible(
                          //   flex:1,
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: RatingBar.builder(
                          //       ignoreGestures: true,
                          //       initialRating: 4.5,
                          //       minRating: 1,
                          //       direction: Axis.horizontal,
                          //       allowHalfRating: true,
                          //       glow: true,
                          //       itemSize: 20,
                          //       itemCount: 5,
                          //       itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          //       itemBuilder: (context, _) => Icon(
                          //         Icons.star,
                          //         color: appColors["primary"]!,
                          //
                          //       ),
                          //       onRatingUpdate: (rating) {
                          //         print(rating);
                          //       },
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),

                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.stretch,

                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel("Duration: ",
                                fontsize: 12, color: appColors["primary"]!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel("${test.duration} Minutes",
                                fontsize: 12, color: appColors["primary"]!),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel("Type: ",
                                fontsize: 12, color: appColors["primary"]!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel(test.test_type,
                                fontsize: 12, color: appColors["primary"]!),
                          ),
                        ],
                      ),
                      // Spacer(),
                      const Divider(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.timer,
                              color: appColors['primary'],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel(test.duration.toString(),
                                fontsize: 12, color: appColors["primary"]!),
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Icon(Icons.calendar_month_rounded),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: clumsyTextLabel(timeago.format(DateTime.parse(test)),fontsize: 12,color:appColors["white"]!),
                      //     ),
                      //
                      //   ],
                      // ),
                      // if (showBook) ClumsyRealButton("Book Now", Get.width*0.2, () {
                      //   Get.toNamed(Routes.EVENT_TICKETS,arguments: event.id);
                      // }, false)
                    ],
                  )),
            )
          ],
        ),
      ));
}


Widget testItemWidget(TestWithSections test) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.all(5),
        // height: Get.height*0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          // color: Colors.red,
          // border: Border.all(color:appColors['primary']!,style: BorderStyle.solid,width: 2),
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(4, 4), blurRadius: 20)
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 2,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      // color: appColors["primary"]!,

                      ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: clumsyTextLabel(test.name.toUpperCase(),
                                  fontsize: 22, color: appColors["primary"]!),
                            ),
                          ),
                          // Spacer(),
                          // Flexible(
                          //   flex:1,
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: RatingBar.builder(
                          //       ignoreGestures: true,
                          //       initialRating: 4.5,
                          //       minRating: 1,
                          //       direction: Axis.horizontal,
                          //       allowHalfRating: true,
                          //       glow: true,
                          //       itemSize: 20,
                          //       itemCount: 5,
                          //       itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          //       itemBuilder: (context, _) => Icon(
                          //         Icons.star,
                          //         color: appColors["primary"]!,
                          //
                          //       ),
                          //       onRatingUpdate: (rating) {
                          //         print(rating);
                          //       },
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),

                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.stretch,

                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel("Duration: ",
                                fontsize: 12, color: appColors["primary"]!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel("${test.duration} Minutes",
                                fontsize: 12, color: appColors["primary"]!),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel("Type: ",
                                fontsize: 12, color: appColors["primary"]!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel(test.test_type,
                                fontsize: 12, color: appColors["primary"]!),
                          ),
                        ],
                      ),
                      // Spacer(),
                      const Divider(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.timer,
                              color: appColors['primary'],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel(test.duration.toString(),
                                fontsize: 12, color: appColors["primary"]!),
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Icon(Icons.calendar_month_rounded),
                      //     ),
                      //     Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: clumsyTextLabel(timeago.format(DateTime.parse(test)),fontsize: 12,color:appColors["white"]!),
                      //     ),
                      //
                      //   ],
                      // ),
                      // if (showBook) ClumsyRealButton("Book Now", Get.width*0.2, () {
                      //   Get.toNamed(Routes.EVENT_TICKETS,arguments: event.id);
                      // }, false)
                    ],
                  )),
            )
          ],
        ),
      ));
}

Widget testItemWidget2(TestWithSections test) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.all(0),
        // height: Get.height*0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          // color: Colors.red,
          // border: Border.all(color:appColors['primary']!,style: BorderStyle.solid,width: 2),
          // boxShadow: [BoxShadow(color: Colors.grey,offset: Offset(4,4),blurRadius: 20)],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 2,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      // color: appColors["primary"]!,

                      ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: clumsyTextLabel(test.name.toUpperCase(),
                                  fontsize: 22, color: appColors["primary"]!),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.stretch,

                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel("Duration: ",
                                fontsize: 12, color: appColors["primary"]!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel("${test.duration} Minutes",
                                fontsize: 12, color: appColors["primary"]!),
                          ),
                        ],
                      ),

                      if (test.startTime != null)
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,

                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: clumsyTextLabel("Start Time: ",
                                  fontsize: 12, color: appColors["primary"]!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: clumsyTextLabel(
                                  "${DateTime.parse(test.startTime!).toLocal()}",
                                  fontsize: 12,
                                  color: appColors["primary"]!),
                            ),
                          ],
                        ),

                      if (test.endTime != null)
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,

                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: clumsyTextLabel("End Time: ",
                                  fontsize: 12, color: appColors["primary"]!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: clumsyTextLabel(
                                  "${DateTime.parse(test.endTime!).toLocal()}",
                                  fontsize: 12,
                                  color: appColors["primary"]!),
                            ),
                          ],
                        ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel("Type: ",
                                fontsize: 12, color: appColors["primary"]!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel(test.test_type,
                                fontsize: 12, color: appColors["primary"]!),
                          ),
                        ],
                      ),
                      // Spacer(),
                      const Divider(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.timer,
                              color: appColors['primary'],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel(test.duration.toString(),
                                fontsize: 12, color: appColors["primary"]!),
                          ),
                        ],
                      ),
                    ],
                  )),
            )
          ],
        ),
      ));
}

Widget testItemWidgetDpp(DppTestWithSections test) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.all(0),
        // height: Get.height*0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          // color: Colors.red,
          // border: Border.all(color:appColors['primary']!,style: BorderStyle.solid,width: 2),
          // boxShadow: [BoxShadow(color: Colors.grey,offset: Offset(4,4),blurRadius: 20)],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 2,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      // color: appColors["primary"]!,

                      ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: clumsyTextLabel(test.name.toUpperCase(),
                                  fontsize: 22, color: appColors["primary"]!),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.stretch,

                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel("Duration: ",
                                fontsize: 12, color: appColors["primary"]!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel("${test.duration} Minutes",
                                fontsize: 12, color: appColors["primary"]!),
                          ),
                        ],
                      ),

                      if (test.startTime != null)
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,

                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: clumsyTextLabel("Start Time: ",
                                  fontsize: 12, color: appColors["primary"]!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: clumsyTextLabel(
                                  "${DateTime.parse(test.startTime!).toLocal()}",
                                  fontsize: 12,
                                  color: appColors["primary"]!),
                            ),
                          ],
                        ),

                      if (test.endTime != null)
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,

                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: clumsyTextLabel("End Time: ",
                                  fontsize: 12, color: appColors["primary"]!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: clumsyTextLabel(
                                  "${DateTime.parse(test.endTime!).toLocal()}",
                                  fontsize: 12,
                                  color: appColors["primary"]!),
                            ),
                          ],
                        ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel("Type: ",
                                fontsize: 12, color: appColors["primary"]!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel(test.test_type,
                                fontsize: 12, color: appColors["primary"]!),
                          ),
                        ],
                      ),
                      // Spacer(),
                      const Divider(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.timer,
                              color: appColors['primary'],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel(test.duration.toString(),
                                fontsize: 12, color: appColors["primary"]!),
                          ),
                        ],
                      ),
                    ],
                  )),
            )
          ],
        ),
      ));
}


Widget clientEventListTile(
  Event event, {
  bool showBook = true,
  String path = Routes.EVENT,
}) {
  return InkWell(
    splashColor: appColors["primary"]!,
    onTap: () async {
      await Get.toNamed(path, arguments: event.id);
    },
    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: Get.height * 0.3,
            decoration: BoxDecoration(
              // border: Border.all(color:Colors.cyan,style: BorderStyle.solid,width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Container(
                      // margin: EdgeInsets.all(20) ,
                      // color: appColors["primary"]!,
                      decoration: const BoxDecoration(
                          // color: appColors["grey"]!.shade900,
                          // borderRadius: BorderRadius.circular(20),
                          ),
                      child: Image.network(
                        event.thumbnail!,
                        fit: BoxFit.cover,
                      )
                      // child: Image.asset("assets/images/pager.jpg",fit: BoxFit.cover,)
                      ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                      // margin: EdgeInsets.all(20) ,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: appColors["background"]!,
                        // borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: clumsyTextLabel(
                                      event.name.toUpperCase(),
                                      fontsize: 22,
                                      color: appColors["primary"]!),
                                ),
                              ),
                              // Spacer(),
                              // Flexible(
                              //   flex:1,
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: RatingBar.builder(
                              //       ignoreGestures: true,
                              //       initialRating: 4.5,
                              //       minRating: 1,
                              //       direction: Axis.horizontal,
                              //       allowHalfRating: true,
                              //       glow: true,
                              //       itemSize: 20,
                              //       itemCount: 5,
                              //       itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              //       itemBuilder: (context, _) => Icon(
                              //         Icons.star,
                              //         color: appColors["primary"]!,
                              //
                              //       ),
                              //       onRatingUpdate: (rating) {
                              //         print(rating);
                              //       },
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),

                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,

                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel("Artist: ",
                                    fontsize: 12, color: appColors["white"]!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel(event.artist!,
                                    fontsize: 12, color: appColors["primary"]!),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel("Type: ",
                                    fontsize: 12, color: appColors["white"]!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel(event.eventType!,
                                    fontsize: 12, color: appColors["primary"]!),
                              ),
                            ],
                          ),
                          // Spacer(),
                          const Divider(),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.location_on_outlined),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel(event.venue!,
                                    fontsize: 12, color: appColors["white"]!),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.calendar_month_rounded),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel(
                                    timeago.format(
                                        DateTime.parse(event.eventTimestamp!)),
                                    fontsize: 12,
                                    color: appColors["white"]!),
                              ),
                            ],
                          ),
                          if (showBook)
                            ClumsyRealButton("Book Now", Get.width * 0.2, () {
                              Get.toNamed(Routes.EVENT_TICKETS,
                                  arguments: event.id);
                            }, false)
                        ],
                      )),
                )
              ],
            ),
          ),
        )),
  );
}

Widget clientBookingListTile(
  Event event,
  String bookingId, {
  bool showBook = true,
  String path = Routes.BOOKING,
}) {
  return InkWell(
    splashColor: appColors["primary"]!,
    onTap: () async {
      await Get.toNamed(path, arguments: bookingId);
    },
    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: Get.height * 0.3,
            decoration: BoxDecoration(
              // border: Border.all(color:Colors.cyan,style: BorderStyle.solid,width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Container(
                      // margin: EdgeInsets.all(20) ,
                      // color: appColors["primary"]!,
                      decoration: const BoxDecoration(
                          // color: appColors["grey"]!.shade900,
                          // borderRadius: BorderRadius.circular(20),
                          ),
                      child: Image.network(
                        event.thumbnail!,
                        fit: BoxFit.cover,
                      )
                      // child: Image.asset("assets/images/pager.jpg",fit: BoxFit.cover,)
                      ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                      // margin: EdgeInsets.all(20) ,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: appColors["background"]!,
                        // borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: clumsyTextLabel(
                                      event.name.toUpperCase(),
                                      fontsize: 22,
                                      color: appColors["primary"]!),
                                ),
                              ),
                              // Spacer(),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RatingBar.builder(
                                    ignoreGestures: true,
                                    initialRating: 4.5,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    glow: true,
                                    itemSize: 5,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: appColors["primary"]!,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,

                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel("Artist: ",
                                    fontsize: 12, color: appColors["white"]!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel(event.artist!,
                                    fontsize: 12, color: appColors["primary"]!),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel("Type: ",
                                    fontsize: 12, color: appColors["white"]!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel(event.eventType!,
                                    fontsize: 12, color: appColors["primary"]!),
                              ),
                            ],
                          ),
                          // Spacer(),
                          const Divider(),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.location_on_outlined),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel(event.venue!,
                                    fontsize: 12, color: appColors["white"]!),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.calendar_month_rounded),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel(
                                    timeago.format(
                                        DateTime.parse(event.eventTimestamp!)),
                                    fontsize: 12,
                                    color: appColors["white"]!),
                              ),
                            ],
                          ),
                          if (showBook)
                            ClumsyRealButton("Book Now", Get.width * 0.2, () {
                              Get.toNamed(Routes.EVENT_TICKETS,
                                  arguments: event.id);
                            }, false)
                        ],
                      )),
                )
              ],
            ),
          ),
        )),
  );
}

Widget hostsEventListTile(Event event) {
  return InkWell(
    splashColor: appColors["primary"]!,
    onTap: () async {
      await Get.toNamed(Routes.HOST_EVENT, arguments: event.id);
    },
    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: Get.height * 0.3,
            decoration: BoxDecoration(
              // border: Border.all(color:Colors.cyan,style: BorderStyle.solid,width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Container(
                      // margin: EdgeInsets.all(20) ,
                      // color: appColors["primary"]!,
                      decoration: const BoxDecoration(
                          // color: appColors["grey"]!.shade900,
                          // borderRadius: BorderRadius.circular(20),
                          ),
                      child: Image.network(
                        event.thumbnail!,
                        fit: BoxFit.cover,
                      )
                      // child: Image.asset("assets/images/pager.jpg",fit: BoxFit.cover,)
                      ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                      // margin: EdgeInsets.all(20) ,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: appColors["background"]!,
                        // borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: clumsyTextLabel(
                                      event.name.toUpperCase(),
                                      fontsize: 22,
                                      color: appColors["primary"]!),
                                ),
                              ),
                              // Spacer(),
                              // Flexible(
                              //   flex:1,
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: RatingBar.builder(
                              //       ignoreGestures: true,
                              //       initialRating: 4.5,
                              //       minRating: 1,
                              //       direction: Axis.horizontal,
                              //       allowHalfRating: true,
                              //       glow: true,
                              //       itemSize: 20,
                              //       itemCount: 5,
                              //       itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              //       itemBuilder: (context, _) => Icon(
                              //         Icons.star,
                              //         color: appColors["primary"]!,
                              //
                              //       ),
                              //       onRatingUpdate: (rating) {
                              //         print(rating);
                              //       },
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),

                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,

                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel("Artist: ",
                                    fontsize: 12, color: appColors["white"]!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel(event.artist!,
                                    fontsize: 12, color: appColors["primary"]!),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel("Type: ",
                                    fontsize: 12, color: appColors["white"]!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel(event.eventType!,
                                    fontsize: 12, color: appColors["primary"]!),
                              ),
                            ],
                          ),
                          // Spacer(),
                          const Divider(),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.location_on_outlined),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel(event.venue!,
                                    fontsize: 12, color: appColors["white"]!),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.calendar_month_rounded),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel(
                                    timeago.format(
                                        DateTime.parse(event.eventTimestamp!)),
                                    fontsize: 12,
                                    color: appColors["white"]!),
                              ),
                            ],
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        )),
  );
}

Widget helperEventListTile(Event event, {bool clickDisabled = false}) {
  return InkWell(
    splashColor: appColors["primary"]!,
    onTap: () async {
      if (!clickDisabled)
        await Get.toNamed(Routes.HELPER_EVENT, arguments: event.id);
    },
    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: Get.height * 0.3,
            decoration: BoxDecoration(
              // border: Border.all(color:Colors.cyan,style: BorderStyle.solid,width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Container(
                      // margin: EdgeInsets.all(20) ,
                      // color: appColors["primary"]!,
                      decoration: const BoxDecoration(
                          // color: appColors["grey"]!.shade900,
                          // borderRadius: BorderRadius.circular(20),
                          ),
                      child: Image.network(
                        event.thumbnail!,
                        fit: BoxFit.cover,
                      )
                      // child: Image.asset("assets/images/pager.jpg",fit: BoxFit.cover,)
                      ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                      // margin: EdgeInsets.all(20) ,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: appColors["background"]!,
                        // borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: clumsyTextLabel(
                                      event.name.toUpperCase(),
                                      fontsize: 22,
                                      color: appColors["primary"]!),
                                ),
                              ),
                              // Spacer(),
                              // Flexible(
                              //   flex:1,
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: RatingBar.builder(
                              //       ignoreGestures: true,
                              //       initialRating: 4.5,
                              //       minRating: 1,
                              //       direction: Axis.horizontal,
                              //       allowHalfRating: true,
                              //       glow: true,
                              //       itemSize: 20,
                              //       itemCount: 5,
                              //       itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              //       itemBuilder: (context, _) => Icon(
                              //         Icons.star,
                              //         color: appColors["primary"]!,
                              //
                              //       ),
                              //       onRatingUpdate: (rating) {
                              //         print(rating);
                              //       },
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),

                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,

                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel("Artist: ",
                                    fontsize: 12, color: appColors["white"]!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel(event.artist!,
                                    fontsize: 12, color: appColors["primary"]!),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel("Type: ",
                                    fontsize: 12, color: appColors["white"]!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel(event.eventType!,
                                    fontsize: 12, color: appColors["primary"]!),
                              ),
                            ],
                          ),
                          // Spacer(),
                          const Divider(),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.location_on_outlined),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel(event.venue!,
                                    fontsize: 12, color: appColors["white"]!),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.calendar_month_rounded),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel(
                                    timeago.format(
                                        DateTime.parse(event.eventTimestamp!)),
                                    fontsize: 12,
                                    color: appColors["white"]!),
                              ),
                            ],
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        )),
  );
}

Widget hostsWalletTransaction(WalletTransaction transaction) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: Get.height * 0.3,
          decoration: BoxDecoration(
            // border: Border.all(color:Colors.cyan,style: BorderStyle.solid,width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 2,
                child: Container(
                    // margin: EdgeInsets.all(20) ,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: appColors["background"]!,
                      // borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel(
                                    transaction.status!.toUpperCase(),
                                    fontsize: 22,
                                    color: appColors["primary"]!),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: clumsyTextLabel("Amount: ",
                                  fontsize: 12, color: appColors["white"]!),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: clumsyTextLabel(
                                  transaction.amount.toString(),
                                  fontsize: 12,
                                  color: appColors["primary"]!),
                            ),
                          ],
                        ),
                        // Spacer(),
                        const Divider(),

                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: clumsyTextLabel(transaction.amount.toString(),fontsize: 12,color:appColors["white"]!),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: clumsyTextLabel(transaction.,fontsize: 12,color:appColors["white"]!),
                        // ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ));
}

Widget clientEventHeader(Event event, {bool showBooking = true}) {
  print(event.eventTimestamp!);
  return InkWell(
    splashColor: appColors["primary"]!,
    onTap: () async {
      await Get.toNamed(Routes.EVENT, arguments: event.id);
    },
    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // height: 400,

          decoration: const BoxDecoration(
              // color: appColors["primary"]!
              // border: Border.all(color:appColors["grey"]!.shade900,style: BorderStyle.solid,width: 2),
              // borderRadius: BorderRadius.circular(20),
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(20),
                    // color: appColors["primary"]!,
                    decoration: BoxDecoration(
                      border: Border.all(color: appColors["primary"]!),
                      // color: appColors["grey"]!.shade900,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.network(
                      event.thumbnail!,
                      fit: BoxFit.cover,
                    )),
              ),
              Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(event.name.toUpperCase(),
                                  style: TextStyle(
                                      color: appColors["primary"]!,
                                      fontFamily: "Barokah",
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (event.published)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.live_tv,
                                color: appColors["green"]!,
                              ),
                            ),
                          if (event.published)
                            clumsyTextLabel("Booking Open!",
                                color: appColors["green"]!),
                          if (!event.published)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.airplanemode_inactive,
                                color: appColors["grey"]!,
                              ),
                            ),
                          if (!event.published)
                            clumsyTextLabel("Event is not Live!",
                                color: appColors["grey"]!),
                        ],
                      ),

                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.stretch,

                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel("Artist: ",
                                fontsize: 12, color: appColors["white"]!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel(event.artist!,
                                fontsize: 12, color: appColors["primary"]!),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel("Type: ",
                                fontsize: 12, color: appColors["white"]!),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel(event.eventType!,
                                fontsize: 12, color: appColors["primary"]!),
                          ),
                        ],
                      ),
                      // Spacer(),
                      const Divider(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.location_on_outlined),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel(event.venue!,
                                fontsize: 12, color: appColors["white"]!),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.calendar_month_rounded),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: clumsyTextLabel(
                                timeago.format(
                                    DateTime.parse(event.eventTimestamp!)),
                                fontsize: 12,
                                color: appColors["white"]!),
                          ),
                        ],
                      ),
                      if (showBooking)
                        ClumsyRealButton(
                            "Book Now", Get.width * 0.2, () {}, false)
                    ],
                  ))
            ],
          ),
        )),
  );
}

Widget clientEventHighlights(Event event) {
  return InkWell(
    splashColor: appColors["primary"]!,
    onTap: () async {
      showSnackbar("Information", "These are the highlights for the event!");
      // await Get.toNamed(Routes.EVENT,arguments: event.id);
    },
    child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          decoration: BoxDecoration(
            color: appColors["primary"]!,
            // border: Border.all(color:appColors["grey"]!.shade900,style: BorderStyle.solid,width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: clumsyTextLabel("Highlights".toUpperCase(),
                    color: appColors["background"]!, fontsize: 15),
              ),
              ...List.generate(
                  event.highlights!.length,
                  (index) => Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: ListTile(
                          leading: const Icon(Icons.stars_rounded),
                          title: clumsyTextLabel(event.highlights![index]),
                        ),
                      )),
              if (event.highlights!.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: clumsyTextLabel("Sorry, no highlights for the event",
                      color: appColors["background"]!, fontsize: 12),
                )
            ],
          ),
        )),
  );
}

Widget clientEventTermsConditions(Event event) {
  return InkWell(
    splashColor: appColors["primary"]!,
    onTap: () async {
      showSnackbar("Information",
          "These are the Terms & Conditions for the event by the event Host!");
      // await Get.toNamed(Routes.EVENT,arguments: event.id);
    },
    child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          decoration: BoxDecoration(
            // color: appColors["grey"]!.shade900,
            border: Border.all(
                color: appColors["grey"]!, style: BorderStyle.solid, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: clumsyTextLabel("Terms & Conditions",
                    color: appColors["primary"]!, fontsize: 15),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: clumsyTextLabel(event.termsConditions!,
                    color: appColors["white"]!),
              ),
            ],
          ),
        )),
  );
}

Widget clientEventDescription(Event event) {
  return InkWell(
    splashColor: appColors["primary"]!,
    onTap: () async {
      // showSnackbar("Information", "");
      // await Get.toNamed(Routes.EVENT,arguments: event.id);
    },
    child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          decoration: BoxDecoration(
            // color: appColors["grey"]!.shade900,
            border: Border.all(
                color: appColors["grey"]!, style: BorderStyle.solid, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: clumsyTextLabel("Description",
                    color: appColors["primary"]!, fontsize: 15),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: clumsyTextLabel(event.description!,
                    color: appColors["white"]!),
              ),
            ],
          ),
        )),
  );
}

Widget clientVenueItem(Event event) {
  return InkWell(
    splashColor: appColors["primary"]!,
    onTap: () async {
      // showSnackbar("Information", "");
      // await Get.toNamed(Routes.EVENT,arguments: event.id);
    },
    child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          width: Get.width * 0.8,
          decoration: BoxDecoration(
            // color: appColors["grey"]!.shade900,
            border: Border.all(
                color: appColors["grey"]!, style: BorderStyle.solid, width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(08.0),
                child: clumsyTextLabel("Venue Details",
                    color: appColors["primary"]!, fontsize: 15),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: clumsyTextLabel(event.venue!,
                    color: appColors["white"]!, fontsize: 20),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: clumsyTextLabel("City:${event.city!}",
                    color: appColors["grey"]!, fontsize: 12),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: clumsyTextLabel("State:${event.state!}",
                    color: appColors["grey"]!, fontsize: 12),
              ),
              // Divider(),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: clumsyTextLabel("Google Maps:${event.googlePlaces!}",color: appColors["grey"]!),
              // ),
            ],
          ),
        )),
  );
}

Widget clientTransactionItem(Transaction transaction) {
  return InkWell(
    splashColor: appColors["primary"]!,
    onTap: () async {
      // showSnackbar("Information", "");
      // await Get.toNamed(Routes.EVENT,arguments: event.id);
    },
    child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          width: Get.width * 0.8,
          decoration: BoxDecoration(
            // color: appColors["grey"]!.shade900,
            // border: Border.all(color:appColors["grey"]!.shade900,style: BorderStyle.solid,width: 2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(08.0),
                child: clumsyTextLabel("Transaction Details",
                    color: appColors["primary"]!, fontsize: 25),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: clumsyTextLabel("Transaction ID",
                    color: appColors["grey"]!, fontsize: 12),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: clumsyTextLabel(transaction.orderId,
                    color: appColors["white"]!, fontsize: 12),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: clumsyTextLabel("Total Amount Paid",
                    color: appColors["grey"]!, fontsize: 12),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: clumsyTextLabel("Rs. ${transaction.amountPaid}",
                    color: appColors["primary"]!, fontsize: 22),
              ),
              // Divider(),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: clumsyTextLabel("Google Maps:${event.googlePlaces!}",color: appColors["grey"]!),
              // ),
            ],
          ),
        )),
  );
}

// Future<String> getUserCityState() async {
//   //call this async method from whereever you need

//   LocationData? myLocation;
//   String error;
//   Location location = Location();
//   print("Trying Location!");

//   bool serviceEnabled;
//   PermissionStatus permissionGranted;
//   // LocationData _locationData;

//   serviceEnabled = await location.serviceEnabled();
//   if (!serviceEnabled) {
//     print("Location 1");
//     serviceEnabled = await location.requestService();
//     print(serviceEnabled);
//     if (!serviceEnabled) {
//       print("service is not enabled");

//       return "-:-";
//     }
//   } else {
//     print(serviceEnabled);
//     print("lcaotion 6");
//   }

//   permissionGranted = await location.hasPermission();

//   if (permissionGranted == PermissionStatus.denied) {
//     print("Location 3");
//     permissionGranted = await location.requestPermission();
//     if (permissionGranted != PermissionStatus.granted) {
//       print("Location 4");
//       return "-:-";
//     }
//   } else {
//     print(permissionGranted);
//     print("lcaotion 7");
//   }
//   String city = "-", state = "-";

//   if (!await Permission.location.request().isGranted) {
//     print("Perrmission is not given");
//     return "";
//   }

//   try {
//     await location.changeSettings(accuracy: LocationAccuracy.low);
//     await location.changeSettings(accuracy: LocationAccuracy.reduced);
//     myLocation = await location.getLocation();
//     print("location is not null");
//     List<Placemark> placemarks = await placemarkFromCoordinates(
//         myLocation.latitude!, myLocation.longitude!);
//     print(placemarks.toString());
//     city = placemarks[0].locality!;
//     state = placemarks[0].administrativeArea!;
//     //showSnackbar("Info","Location: $city, $state ");
//     bool found = false;
//     CityState current = CityState(city: city, state: state);
//     for (var i in cities) {
//       if (i.equals(current)) {
//         found = true;
//       }
//     }
//     if (found) {
//       Get.find<HomeController>().cityState.value = current;
//     } else {
//       Get.find<HomeController>().cityState.value = CityState.defaultCity();
//     }
//   } catch (err) {
//     print(err);
//   }
//   return "$city:$state";
// }

Widget grid(List<GravityStream> streams, {required int crossAxisCount}) {
  int pending = streams.length;
  int count = 0;
  int mainAxisCount = (streams.length / crossAxisCount).ceil();
  return Column(
    children: List.generate(mainAxisCount, (index1) {
      print(min(crossAxisCount, pending));
      var w = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(min(crossAxisCount, pending), (index2) {
          print("pending$pending");
          pending--;
          // count++;
          // int count = ((mainAxisCount-1) * index1) + index2;
          print("count: $count");
          Widget w =
              Flexible(flex: 1, child: streamsNormalList(streams[count]));
          count++;
          return w;
        }),
      );
      // pending-=crossAxisCount;
      return w;
    }),
  );
}

// Widget getQRCode(Booking booking) {
//   return Container(
//     width: Get.width,
//     decoration: BoxDecoration(
//         color: appColors["background"]!,
//         borderRadius: BorderRadius.circular(20)),
//     padding: const EdgeInsets.all(20),
//     margin: const EdgeInsets.all(20),
//     child: Column(
//       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             clumsyTextLabel(booking.id,
//                 color: appColors["primary"]!, fontsize: 15),
//             clumsyTextLabel("Status: ${booking.bookingStatus}",
//                 color: appColors["primary"]!, fontsize: 15),
//           ],
//         ),
//         Divider(
//           color: appColors["background"]!,
//         ),
//         ClipRRect(
//           borderRadius: BorderRadius.circular(20),
//           child: QrImage(
//             eyeStyle: QrEyeStyle(
//                 color: appColors["background"]!, eyeShape: QrEyeShape.circle),
//             embeddedImageStyle: QrEmbeddedImageStyle(
//                 // color: appColors["primary"]!
//                 ),
//             backgroundColor: appColors["white"]!,
//             data: booking.id,
//             version: QrVersions.auto,
//             embeddedImage: const AssetImage("assets/images/favicon.png"),
//             size: Get.width * 0.6,
//           ),
//         )
//       ],
//     ),
//   );
// }

Widget hostBookingListTile(Booking booking, {bool showBook = true}) {
  Event event = booking.event;
  return InkWell(
    splashColor: appColors["primary"]!,
    onTap: () async {
      await Get.toNamed(Routes.HOST_BOOKINGS, arguments: event.id);
    },
    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: Get.height * 0.3,
            decoration: BoxDecoration(
              // border: Border.all(color:Colors.cyan,style: BorderStyle.solid,width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Container(
                      // margin: EdgeInsets.all(20) ,
                      // color: appColors["primary"]!,
                      decoration: const BoxDecoration(
                          // color: appColors["grey"]!.shade900,
                          // borderRadius: BorderRadius.circular(20),
                          ),
                      child: Image.network(
                        event.thumbnail!,
                        fit: BoxFit.cover,
                      )
                      // child: Image.asset("assets/images/pager.jpg",fit: BoxFit.cover,)
                      ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                      // margin: EdgeInsets.all(20) ,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: appColors["background"]!,
                        // borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: clumsyTextLabel(
                                      event.name.toUpperCase(),
                                      fontsize: 22,
                                      color: appColors["primary"]!),
                                ),
                              ),
                              // Spacer(),
                              Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RatingBar.builder(
                                    ignoreGestures: true,
                                    initialRating: 4.5,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    glow: true,
                                    itemSize: 5,
                                    itemCount: 5,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: appColors["primary"]!,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.stretch,

                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel("Artist: ",
                                    fontsize: 12, color: appColors["white"]!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel(event.artist!,
                                    fontsize: 12, color: appColors["primary"]!),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel("Type: ",
                                    fontsize: 12, color: appColors["white"]!),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel(event.eventType!,
                                    fontsize: 12, color: appColors["primary"]!),
                              ),
                            ],
                          ),
                          // Spacer(),
                          const Divider(),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.location_on_outlined),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel(event.venue!,
                                    fontsize: 12, color: appColors["white"]!),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.calendar_month_rounded),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: clumsyTextLabel(event.eventTimestamp!,
                                    fontsize: 12, color: appColors["white"]!),
                              ),
                            ],
                          ),
                          if (showBook)
                            ClumsyRealButton("Book Now", Get.width * 0.2, () {
                              Get.toNamed(Routes.EVENT_TICKETS,
                                  arguments: event.id);
                            }, false)
                        ],
                      )),
                )
              ],
            ),
          ),
        )),
  );
}

int getTicketCount(EventPhase? phase) {
  if (phase == null) {
    return 0;
  }
  int tickets = 0;
  for (PhaseCategory category in phase.categories) {
    for (var ticket in category.tickets) {
      tickets += 1;
    }
  }
  return tickets;
}

Widget getResultWidget(BuildContext context, Result result) {
  Map<String, double> dataMap = {
    "Answered": result.resultInfo.b.toDouble(),
    "Not Answered": result.resultInfo.f.toDouble(),
    "Not Visited": result.resultInfo.h.toDouble(),
  };

  List<List<dynamic>> data = [
    ["Answered", result.resultInfo.b.toDouble(), appColors['green']],
    ["Not Answered", result.resultInfo.f.toDouble(), appColors['red']],
    ["Not Visited", result.resultInfo.h.toDouble(), appColors['grey']],
  ];

  var testUrl = RequestPaths.GET_STUDENT_TEST_PDF;
  return SingleChildScrollView(
    child: Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // headerBar("Test Results",parent:true),
          Center(
              child: clumsyTextLabel("Result Declaration Time",
                  fontsize: 20, color: Colors.blue)),
          if (result.declarationTime != null)
            Center(
                child: clumsyTextLabel(DateTime.parse(result.declarationTime!)
                    .toLocal()
                    .toString())),
          // clumsyTextLabel(DateTime.parse(result.declarationTime!).toLocal().isBefore(DateTime.now()).toString()),
          // if(result.declarationTime!=null?DateTime.parse(result.declarationTime!).toLocal().isBefore(DateTime.now()):true)
          Column(
            children: [
              SfCircularChart(
                  title: ChartTitle(
                      text: "Questions Analysis",
                      textStyle: TextStyle(color: appColors['blue'])),
                  legend: Legend(
                      isVisible: true,
                      textStyle: TextStyle(color: appColors['primary']),
                      iconHeight: 50),
                  series: <CircularSeries>[
                    // Renders radial bar chart
                    RadialBarSeries<List<dynamic>, String>(
                        useSeriesColor: true,
                        trackOpacity: 0.3,
                        cornerStyle: CornerStyle.bothCurve,
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                        ),
                        radius: "100%",
                        dataSource: data,
                        xValueMapper: (data, _) => data[0],
                        yValueMapper: (data, _) => data[1],
                        pointColorMapper: (data, _) => data[2],
                        gap: '10%')
                  ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    // await launch(testUrl);
                  },
                  // child: const Text("Download PDF"),
                  child: const Text(""),

                ),
              ),

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      // decoration: BoxDecoration(color:appColors['primary'],boxShadow: [BoxShadow(color: Colors.black,blurRadius: 2.0)]),
                      child: Center(
                          child: Column(
                        children: [
                          const Text(
                            "Marks",
                            style: TextStyle(color: Colors.green),
                          ),
                          Text(
                            result.total.toString() +
                                "/" +
                                result.maxMarks.toString(),
                            style: const TextStyle(
                                color: Colors.green, fontSize: 30),
                          ),
                        ],
                      )),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      // decoration: BoxDecoration(color: appColors['primary'],boxShadow: [BoxShadow(color: Colors.black,blurRadius: 2.0)]),
                      child: Center(
                          child: Column(
                        children: [
                          const Text(
                            "Percentage " + "%",
                            style: TextStyle(color: Colors.green),
                          ),
                          Text(
                            (result.total.toDouble() * 100 / result.maxMarks)
                                    .toStringAsFixed(2) +
                                "%",
                            style: const TextStyle(
                                color: Colors.green, fontSize: 30),
                          ),
                        ],
                      )),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Total number of questions: ',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                      children: <TextSpan>[
                        TextSpan(
                            text: result.qml.length.toString(),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        // TextSpan(text: ' world!'),
                      ],
                    ),
                  ),
                ),
              ),
              // Center(child: clumsyTextLabel("View Questions and Solutions",color: appColors['primary'],fontsize: 25)),
              TestResultQuestions(result.subjectWiseMarking),
            ],
          ),
        ],
      ),
    ),
  );
}

// Widget getDppResultWidget(BuildContext context, Result result) {
//   Map<String, double> dataMap = {
//     "Answered": result.resultInfo.b.toDouble(),
//     "Not Answered": result.resultInfo.f.toDouble(),
//     "Not Visited": result.resultInfo.h.toDouble(),
//   };

//   List<List<dynamic>> data = [
//     ["Answered", result.resultInfo.b.toDouble(), appColors['green']],
//     ["Not Answered", result.resultInfo.f.toDouble(), appColors['red']],
//     ["Not Visited", result.resultInfo.h.toDouble(), appColors['grey']],
//   ];

//   var testUrl = RequestPaths.GET_STUDENT_TEST_PDF;
//   return SingleChildScrollView(
//     child: Container(
//       decoration: const BoxDecoration(color: Colors.white),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // headerBar("Test Results",parent:true),
//           Center(
//               child: clumsyTextLabel("Result Declaration Time",
//                   fontsize: 20, color: Colors.blue)),
//           if (result.declarationTime != null)
//             Center(
//                 child: clumsyTextLabel(DateTime.parse(result.declarationTime!)
//                     .toLocal()
//                     .toString())),
//           // clumsyTextLabel(DateTime.parse(result.declarationTime!).toLocal().isBefore(DateTime.now()).toString()),
//           // if(result.declarationTime!=null?DateTime.parse(result.declarationTime!).toLocal().isBefore(DateTime.now()):true)
//           Column(
//             children: [
//               SfCircularChart(
//                   title: ChartTitle(
//                       text: "Questions Analysis",
//                       textStyle: TextStyle(color: appColors['blue'])),
//                   legend: Legend(
//                       isVisible: true,
//                       textStyle: TextStyle(color: appColors['primary']),
//                       iconHeight: 50),
//                   series: <CircularSeries>[
//                     // Renders radial bar chart
//                     RadialBarSeries<List<dynamic>, String>(
//                         useSeriesColor: true,
//                         trackOpacity: 0.3,
//                         cornerStyle: CornerStyle.bothCurve,
//                         dataLabelSettings: const DataLabelSettings(
//                           isVisible: true,
//                         ),
//                         radius: "100%",
//                         dataSource: data,
//                         xValueMapper: (data, _) => data[0],
//                         yValueMapper: (data, _) => data[1],
//                         pointColorMapper: (data, _) => data[2],
//                         gap: '10%')
//                   ]),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: GestureDetector(
//                   onTap: () async {
//                     // await launch(testUrl);
//                   },
//                   child: const Text("Download PDF"),
//                 ),
//               ),

//               Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       margin: const EdgeInsets.all(8.0),
//                       padding: const EdgeInsets.all(8.0),
//                       // decoration: BoxDecoration(color:appColors['primary'],boxShadow: [BoxShadow(color: Colors.black,blurRadius: 2.0)]),
//                       child: Center(
//                           child: Column(
//                         children: [
//                           const Text(
//                             "Marks",
//                             style: TextStyle(color: Colors.green),
//                           ),
//                           Text(
//                             result.total.toString() +
//                                 "/" +
//                                 result.maxMarks.toString(),
//                             style: const TextStyle(
//                                 color: Colors.green, fontSize: 50),
//                           ),
//                         ],
//                       )),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       margin: const EdgeInsets.all(8.0),
//                       padding: const EdgeInsets.all(8.0),
//                       // decoration: BoxDecoration(color: appColors['primary'],boxShadow: [BoxShadow(color: Colors.black,blurRadius: 2.0)]),
//                       child: Center(
//                           child: Column(
//                         children: [
//                           const Text(
//                             "Percentage-" + "%",
//                             style: TextStyle(color: Colors.green),
//                           ),
//                           Text(
//                             (result.total.toDouble() * 100 / result.maxMarks)
//                                     .toStringAsFixed(2) +
//                                 "%",
//                             style: const TextStyle(
//                                 color: Colors.green, fontSize: 50),
//                           ),
//                         ],
//                       )),
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 margin: const EdgeInsets.only(top: 20),
//                 child: Center(
//                   child: RichText(
//                     text: TextSpan(
//                       text: 'Total # of questions ',
//                       style: const TextStyle(fontSize: 12, color: Colors.grey),
//                       children: <TextSpan>[
//                         TextSpan(
//                             text: result.qml.length.toString(),
//                             style:
//                                 const TextStyle(fontWeight: FontWeight.bold)),
//                         // TextSpan(text: ' world!'),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               // Center(child: clumsyTextLabel("View Questions and Solutions",color: appColors['primary'],fontsize: 25)),
//               TestResultQuestions(result.subjectWiseMarking),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }


Widget DppTestClockWidget() {
  return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: appColors['primary'],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [const BoxShadow(color: Colors.black, blurRadius: 3)]),
      child: Column(
        children: [
          Obx(() => clumsyTextLabel(
              formatTime(Get.find<DppTestStateController>().time.value),
              fontsize: 20,
              color: appColors['white'])),
          clumsyTextLabel("Time Remaining",
              fontsize: 12, color: appColors['white']),
        ],
      ));
}


Widget TestClockWidget() {
  return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: appColors['primary'],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [const BoxShadow(color: Colors.black, blurRadius: 3)]),
      child: Column(
        children: [
          Obx(() => clumsyTextLabel(
              formatTime(Get.find<TestStateController>().time.value),
              fontsize: 20,
              color: appColors['white'])),
          clumsyTextLabel("Time Remaining",
              fontsize: 12, color: appColors['white']),
        ],
      ));
}

String formatTime(int seconds) {
  var secs = seconds;
  var hours = (secs ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
  var sec = (secs % 60).toString().padLeft(2, '0');
  // return "$hours:$minutes:$seconds";
  return "$hours:$minutes:$sec";
}

Widget legends() {
  return Padding(
    padding: const EdgeInsets.all(18.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              child: Image.asset("assets/images/saved.png"),
              height: 30,
            ),
            const Text(
              "Answered",
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              child: Image.asset("assets/images/empty.png"),
              height: 30,
            ),
            const Text("Not visited",
                style: TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              child: Image.asset("assets/images/ans_marked.png"),
              height: 30,
            ),
            const Text("Answered and marked for review",
                style: TextStyle(fontSize: 10, color: Colors.grey))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              child: Image.asset("assets/images/not_saved.png"),
              height: 30,
            ),
            const Text("Viewed but not answered",
                style: TextStyle(fontSize: 10, color: Colors.grey))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              child: Image.asset("assets/images/review_latr.png"),
              height: 30,
            ),
            const Text("Marked for review",
                style: TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ],
    ),
  );
}

Widget TestStatusReport({TestContext? tc = null}) {
  tc = tc ?? Get.find<TestStateController>().testContext;
  return Obx(() {
    Map<String, int> data =
        Get.find<StudentsController>().evaluateQuestionStatus(tc!.lqs);
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              child: Image.asset("assets/images/saved.png"),
              height: 30,
            ),
            clumsyTextLabel(data['saved']!.toString(), fontsize: 12),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              child: Image.asset("assets/images/not_saved.png"),
              height: 30,
            ),

            // Image.asset("assets/images/not_saved.png",height:25,width: 20,),
            clumsyTextLabel(data['unanswered']!.toString(), fontsize: 12),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              child: Image.asset("assets/images/empty.png"),
              height: 30,
            ),
            // Image.asset("assets/images/empty.png",height:25,width: 20,),
            clumsyTextLabel(data['unvisited']!.toString(), fontsize: 12),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              child: Image.asset("assets/images/review_latr.png"),
              height: 30,
            ),
            // Image.asset("assets/images/review_latr.png",height:25,width: 20,),
            clumsyTextLabel(data['marked']!.toString(), fontsize: 12),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              child: Image.asset("assets/images/ans_marked.png"),
              height: 30,
            ),
            // Image.asset("assets/images/ans_marked.png",height:25,width: 20,),
            clumsyTextLabel(data['marked_saved']!.toString(), fontsize: 12),
          ],
        ),
      ),
    ]);
  });
}

 Map<String,int> evaluateDppQuestionStatus(List<DppQuestionStatus> lqs){
    Map<String,int> data = {'visited':0,'unvisited':0,'unanswered':0,'marked_saved':0,'saved':0,'marked':0,'total':lqs.length};
    for(DppQuestionStatus qs in lqs){
      if(qs.vstate.value==VisitState.VISITED){
        data['visited'] = data['visited']!+1;
        if(qs.astate.value==AnsweredState.ANSWERED_SAVED ){
          data['saved'] = data['saved']!+1;
        }
        if(qs.rstate.value==ReviewState.MARKED){
          data['marked'] = data['marked']!+1;
        }
        if(qs.astate.value==AnsweredState.ANSWERED_SAVED && qs.rstate.value==ReviewState.MARKED){
          data['marked_saved'] = data['marked_saved']!+1;
        }
      }
      else{
        data['unvisited'] = data['unvisited']!+1;
      }
    }
    data['unanswered']=data['total']!-data['saved']!-data['unvisited']!;
    return data;
  }


Widget DppTestStatusReport({DppTestContext? tc = null}) {
  tc = tc ?? Get.find<DppTestStateController>().testContext;
  return Obx(() {
    Map<String, int> data =
        evaluateDppQuestionStatus(tc!.lqs);
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              child: Image.asset("assets/images/saved.png"),
              height: 30,
            ),
            clumsyTextLabel(data['saved']!.toString(), fontsize: 12),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              child: Image.asset("assets/images/not_saved.png"),
              height: 30,
            ),

            // Image.asset("assets/images/not_saved.png",height:25,width: 20,),
            clumsyTextLabel(data['unanswered']!.toString(), fontsize: 12),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              child: Image.asset("assets/images/empty.png"),
              height: 30,
            ),
            // Image.asset("assets/images/empty.png",height:25,width: 20,),
            clumsyTextLabel(data['unvisited']!.toString(), fontsize: 12),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              child: Image.asset("assets/images/review_latr.png"),
              height: 30,
            ),
            // Image.asset("assets/images/review_latr.png",height:25,width: 20,),
            clumsyTextLabel(data['marked']!.toString(), fontsize: 12),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              child: Image.asset("assets/images/ans_marked.png"),
              height: 30,
            ),
            // Image.asset("assets/images/ans_marked.png",height:25,width: 20,),
            clumsyTextLabel(data['marked_saved']!.toString(), fontsize: 12),
          ],
        ),
      ),
    ]);
  });
}


void showSnackbar(String title, String message) {
  Get.snackbar(title, message,
      backgroundColor: appColors['primary'], colorText: appColors['white']);
}

