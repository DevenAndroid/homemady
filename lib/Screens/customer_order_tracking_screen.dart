import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homemady/resources/add_text.dart';
import 'package:homemady/widgets/app_assets.dart';
import 'package:homemady/widgets/app_theme.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:homemady/widgets/dimenestion.dart';
import 'package:homemady/widgets/editprofiletextfiled.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/my_address_controller.dart';
import '../controller/order_tracking_controller.dart';
import '../model/my_address_model.dart';
import '../repository/add_address_repo.dart';
import '../repository/edit_address_repo.dart';
import '../widgets/custome_size.dart';
import 'myAddressScreen.dart';


class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({Key? key}) : super(key: key);
  static var orderTrackingScreen = "/orderTrackingScreen";

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  final orderTrackingController = Get.put(OrderTrackingController());
  Rx<AddressData> addressModel = AddressData().obs;
  final _formKey = GlobalKey<FormState>();
  //  final addressController = Get.put(MyAddressController());
  // Rx<AddressData> addressModel = AddressData().obs;

  final RxBool _isValue = false.obs;
  RxBool customTip = false.obs;
  RxString selectedChip = "Home".obs;
  final TextEditingController searchController = TextEditingController();
  final Completer<GoogleMapController> googleMapController = Completer();
  GoogleMapController? mapController;

  String? _currentAddress;
  String? _address = "";
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(
                  _currentPosition!.latitude, _currentPosition!.longitude),
              zoom: 15)));
      _onAddMarkerButtonPressed(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          "current location");
      setState(() {});
      // location = _currentAddress!;
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
        _address =
        '${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  final TextEditingController otherController = TextEditingController();

  _makingPhoneCall(call) async {
    var url = Uri.parse(call);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderTrackingController.getOrderTrackingDetails();
    _getCurrentPosition();
    if (Get.arguments != null) {
      addressModel.value = Get.arguments[0];
      print(Get.arguments[0]);
    }
  }

  String googleApikey = "AIzaSyDDl-_JOy_bj4MyQhYbKbGkZ0sfpbTZDNU";
  GoogleMapController? mapController1; //contrller for Google map
  CameraPosition? cameraPosition;
  String location = "Search Location";
  final Set<Marker> markers = {};
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> _onAddMarkerButtonPressed(LatLng lastMapPosition, markerTitle,
      {allowZoomIn = true}) async {
    final Uint8List markerIcon =
    await getBytesFromAsset(AppAssets.locationMarker, 100);
    markers.clear();
    markers.add(Marker(
        markerId: MarkerId(lastMapPosition.toString()),
        position: lastMapPosition,
        infoWindow: const InfoWindow(
          title: "",
        ),
        icon: BitmapDescriptor.fromBytes(markerIcon)));
    // BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan,)));
    if (googleMapController.isCompleted) {
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: lastMapPosition, zoom: allowZoomIn ? 14 : 11)));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        mapController!.dispose();
        return true;
      },
      child:
      Scaffold(
          appBar: backAppBar(
              title: "Tracking",
              context: context,
              dispose: "dispose",
              disposeController: () {
                mapController!.dispose();
              }),
          body:
          Stack(
            children: [
              GoogleMap(
                zoomGesturesEnabled: true,
                //enable Zoom in, out on map
                initialCameraPosition: const CameraPosition(
                  target: LatLng(0, 0),
                  zoom: 14.0, //initial zoom level
                ),
                mapType: MapType.normal,
                //map type
                onMapCreated: (controller) {
                  setState(() async {
                    mapController = controller;
                  });
                },
                markers: markers,

                // myLocationEnabled: true,
                // myLocationButtonEnabled: true,
                // compassEnabled: true,
                // markers: Set<Marker>.of(_markers),
                onCameraMove: (CameraPosition cameraPositions) {
                  cameraPosition = cameraPositions;
                },
                onCameraIdle: () async {},
              ),
              // _isValue.value == true
              //     ? const SizedBox()
              //     : Positioned(
              //   //search input bar
              //     top: 10,
              //     child: InkWell(
              //         onTap: () async {
              //           var place = await PlacesAutocomplete.show(
              //               context: context,
              //               apiKey: googleApikey,
              //               mode: Mode.overlay,
              //               types: [],
              //               strictbounds: false,
              //               // components: [
              //               //   Component(Component.country, 'np')
              //               // ],
              //               onError: (err) {
              //                 log("error.....   ${err.errorMessage}");
              //               });
              //           if (place != null) {
              //             setState(() {
              //               _address = place.description.toString();
              //             });
              //             final plist = GoogleMapsPlaces(
              //               apiKey: googleApikey,
              //               apiHeaders:
              //               await const GoogleApiHeaders().getHeaders(),
              //             );
              //             print(plist);
              //             String placeid = place.placeId ?? "0";
              //             final detail =
              //             await plist.getDetailsByPlaceId(placeid);
              //             final geometry = detail.result.geometry!;
              //             final lat = geometry.location.lat;
              //             final lang = geometry.location.lng;
              //             var newlatlang = LatLng(lat, lang);
              //             setState(() {
              //               _address = place.description.toString();
              //               _onAddMarkerButtonPressed(
              //                   LatLng(lat, lang), place.description);
              //             });
              //             mapController?.animateCamera(
              //                 CameraUpdate.newCameraPosition(CameraPosition(
              //                     target: newlatlang, zoom: 17)));
              //             setState(() {});
              //           }
              //         },
              //         child: Padding(
              //           padding: const EdgeInsets.all(15),
              //           child: Card(
              //             child: Container(
              //                 padding: const EdgeInsets.all(0),
              //                 width: MediaQuery.of(context).size.width - 40,
              //                 child: ListTile(
              //                   leading: Image.asset(
              //                     AppAssets.drawer_location,
              //                     width: AddSize.size15,
              //                   ),
              //                   title: Text(
              //                     _address.toString(),
              //                     style:
              //                     TextStyle(fontSize: AddSize.font14),
              //                   ),
              //                   trailing: const Icon(Icons.search),
              //                   dense: true,
              //                 )),
              //           ),
              //         ))),
              orderTrackingController.isDataLoading && orderTrackingController.orderTrackingModel.value.data != null ?
              Positioned(
                  bottom: 0,
                  child: 
                  Column(
                    children: [
                      Container(
                      //  height: height * .55,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: AppTheme.backgroundcolor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AddSize.padding16,
                            vertical: AddSize.padding10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 10,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        color: Color(0xffEEEEEE),
                                        borderRadius: BorderRadius.circular(50)
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 20,),
                              ListView.builder(
                                shrinkWrap: true,
                                  itemCount: orderTrackingController.orderTrackingModel.value.data!.length,
                                  itemBuilder: (BuildContext, index){
                                    return  Column(
                                      children: [
                                        IntrinsicHeight(
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                Flexible(
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                    decoration: BoxDecoration(

                                                      border: Border.all(color: Colors.green),
                                                      shape: BoxShape.circle
                                                    ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(5.0),
                                                            child: Container(
                                                              height: AddSize.size20,
                                                              width: AddSize.size20,
                                                              decoration: BoxDecoration(
                                                                color:const Color(0xff6CC845),
                                                              shape: BoxShape.circle),
                                                            ),
                                                          ),
                                                        ),
                                                        // Expanded(
                                                        //   child: Container(
                                                        //     width: width * 0.001,
                                                        //     height: 2,
                                                        //     decoration: const BoxDecoration(
                                                        //       color:  Color(0xff6CC845),
                                                        //       borderRadius: BorderRadius.all(
                                                        //           Radius.circular(5)),
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                        DottedVerticalLine()
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                addWidth(10),
                                                Expanded(
                                                  flex:8,
                                                  child: SizedBox(
                                                    width: double.maxFinite,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          orderTrackingController.orderTrackingModel.value.data![index].note.toString(),
                                                          style: GoogleFonts.poppins(
                                                              fontWeight: FontWeight.w400,
                                                              color: Color(0xff141C19),
                                                              fontSize: AddSize.font16),
                                                        ),
                                                        SizedBox(height: AddSize.size5,),
                                                        Text(
                                                          orderTrackingController.orderTrackingModel.value.data![index].date.toString(),
                                                          style: GoogleFonts.poppins(
                                                              fontWeight: FontWeight.w300,
                                                              color:Color(0xff48585E),
                                                              fontSize: AddSize.font12),
                                                        ),

                                                        // SizedBox(height: AddSize.size10,),

                                                      ],
                                                    ),
                                                  ),
                                                ),

                                              ]),
                                        ),
                                        // SizedBox(height: height * .02,),
                                      ],
                                    );
                                  }),
                              SizedBox(height: height * .02,),
                              Container(
                                //height: height * .12,
                               decoration: BoxDecoration(
                                 color: Color(0xff6CC844).withOpacity(.10),
                                 borderRadius: BorderRadius.circular(17)
                               ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/images/trackBox.png',height: 62,width: 70,),
                                         SizedBox(width: 5,),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Bike - RJ-14745',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff262F33),
                                                    fontSize: AddSize.font16),
                                              ),
                                              Text(
                                                "Satyam rathore",
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff666666),
                                                    fontSize: AddSize.font16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                     // SizedBox(width: AddSize.size50,),
                                      GestureDetector(
                                          onTap: (){
                                            _makingPhoneCall("tel:+91${8854952858}");
                                          },
                                          child: Image.asset('assets/images/callIcon.png',height: 60,width: 70,)),
                                    ],
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   height: height * .35,
                              // ),
                              SizedBox(height: AddSize.size10,),
                              CommonButton1(
                                title: 'Confirm Delivery',
                                onPressed: () {

                                },
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
                  :Center(child: CircularProgressIndicator())

            ],
          )
      )
    );
  }

}




class DottedVerticalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(2.0, 40.0), // Adjust the size as needed
      painter: DottedVerticalLinePainter(),
    );
  }
}

class DottedVerticalLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.green // Color of the dots
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0; // Width of the line

    final double dashWidth = 2.0; // Width of each dash
    final double dashSpace = 5.0; // Space between dashes
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashWidth),
        paint,
      );
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
