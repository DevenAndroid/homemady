import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:homemady/resources/add_text.dart';
import 'package:homemady/widgets/app_assets.dart';
import 'package:homemady/widgets/app_theme.dart';
import 'package:homemady/widgets/custome_textfiled.dart';
import 'package:homemady/widgets/dimenestion.dart';
import 'package:homemady/widgets/editprofiletextfiled.dart';
import '../controller/my_address_controller.dart';
import '../model/my_address_model.dart';
import '../repository/add_address_repo.dart';
import '../repository/edit_address_repo.dart';


class ChooseAddress extends StatefulWidget {
  const ChooseAddress({Key? key}) : super(key: key);
  static var chooseAddressScreen = "/chooseAddressScreen";

  @override
  State<ChooseAddress> createState() => _ChooseAddressState();
}

class _ChooseAddressState extends State<ChooseAddress> {
  final myAddressController = Get.put(MyAddressController());
  Rx<AddressData> addressModel = AddressData().obs;
  final _formKey = GlobalKey<FormState>();
  //  final addressController = Get.put(MyAddressController());
  // Rx<AddressData> addressModel = AddressData().obs;
  final List<String> choiceAddress = ["Home", "Office", "Hotel", "Other"];
  final RxBool _isValue = false.obs;
  RxBool customTip = false.obs;
  RxString selectedChip = "Home".obs;
  final TextEditingController searchController = TextEditingController();
  final Completer<GoogleMapController> googleMapController = Completer();
  GoogleMapController? mapController;

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
        _address =
        '${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  final TextEditingController otherController = TextEditingController();
  showChangeAddressSheet(AddressData addressModel) {
    final TextEditingController flatNoController = TextEditingController(text: addressModel.flatNo ?? '');
    final TextEditingController cityController = TextEditingController(text: addressModel.landmark ?? '');
    final TextEditingController postalCodeController = TextEditingController(text: addressModel.pinCode ?? '');
    final TextEditingController recipientController = TextEditingController(text:  addressModel.name ?? '');
    final TextEditingController deliveryInstructionController = TextEditingController(text:  addressModel.note ?? '');
    selectedChip.value = addressModel.addressType ?? "Home";

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Obx(() {
              return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isValue.value = !_isValue.value;
                              });
                              Get.back();
                              setState(() {});
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: const ShapeDecoration(
                                  color: AppTheme.blackcolor,
                                  shape: CircleBorder()),
                              child: Center(
                                  child: Icon(
                                    Icons.clear,
                                    color: AppTheme.backgroundcolor,
                                    size: AddSize.size30,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: AddSize.size20,
                          ),
                          Container(
                            width: double.maxFinite,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AddSize.padding16,
                                  vertical: AddSize.padding16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 const Text(
                                    "Enter complete address",
                                    style: TextStyle(
                                        color: AppTheme.blackcolor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: AddSize.size12,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      choiceAddress.length,
                                          (index) => chipList(choiceAddress[index]),
                                    ),
                                  ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  if (customTip.value)
                                    EditProfileTextFieldWidget(
                                      hint: "Other",
                                      controller: otherController,
                                    ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  EditProfileTextFieldWidget(
                                    controller: flatNoController,
                                    hint: "Flat, House no, Floor, Tower,Street",
                                    label: "Flat, House no, Floor, Tower,Street",
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText:
                                          'Flat, House no, Floor, Tower,Street'),
                                    ]),
                                  ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  EditProfileTextFieldWidget(
                                    controller: cityController,
                                    hint: "City",
                                    label: "City",
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText:
                                          'Select city'),
                                    ]),
                                  ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  EditProfileTextFieldWidget(
                                    length: 7,
                                    controller: postalCodeController,
                                    hint: "Eircode",
                                    label: "Eircode",
                                    validator:(value){
                                      if(value!.length<7){
                                        return "Enter valid Eircode";
                                      }
                                      return null;
                                    }
                                  ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),

                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  EditProfileTextFieldWidget(
                                    controller: deliveryInstructionController,
                                    hint: "Delivery Instructions",
                                    label: "Delivery Instructions",
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: 'Recipient’s name'),
                                    ]),
                                  ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  EditProfileTextFieldWidget(
                                    controller: recipientController,
                                    hint: "Recipient’s name",
                                    label: "Recipient’s name",
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: 'Recipient’s name'),
                                    ]),
                                  ),
                                  SizedBox(
                                    height: AddSize.size20,
                                  ),
                                  CommonButton1(title: 'save address'.toUpperCase(),
                                    onPressed: (){
                                      if(_formKey.currentState!.validate()){
                                       addressModel.landmark != null && addressModel.flatNo != null && addressModel.name != null ?
                                           editAddress(context: context,location: _address,address_type:selectedChip.value,name: recipientController.text,
                                           flat_no: flatNoController.text,landmark: cityController.text,
                                           address_id: addressModel.id.toString(), postalCode: postalCodeController.text, deliveryInstruction: deliveryInstructionController.text).then((value) {
                                             if(value.status == true){
                                               showToast('Address Edited Successfully');
                                              Get.back();
                                              Get.back();
                                               myAddressController.getData();
                                             }
                                           }) :
                                        addAddress(flat_no: flatNoController.text,landmark: cityController.text,name: recipientController.text,context: context,
                                            address_type: selectedChip.value,location: _address,note: deliveryInstructionController.text,pinCode: postalCodeController.text).then((value1) {
                                          if(value1.status == true){
                                            showToast(value1.message.toString());
                                            Get.back();
                                            Get.back();
                                            // Get.to(()=> const MyAddressScreen());
                                            myAddressController.getData();
                                          }
                                        });
                                      }
                                  },),

                                ],
                              ),
                            ),
                          ),
                          // Obx(() {
                          //   return SizedBox(
                          //     height: sizeBoxHeight.value,
                          //   );
                          // })
                        ],
                      ),
                    ),
                  ));
            }),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //checkGps();
    _getCurrentPosition();
    if (Get.arguments != null) {
      addressModel.value = Get.arguments[0];
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
    return WillPopScope(
      onWillPop: () async {
        mapController!.dispose();
        return true;
      },
      child: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Scaffold(
            appBar: backAppBar(
                title: _isValue.value == true
                    ? "Complete Address"
                    : "Choose Address",
                context: context,
                dispose: "dispose",
                disposeController: () {
                  mapController!.dispose();
                }),
            body: Stack(
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
                _isValue.value == true
                    ? const SizedBox()
                    : Positioned(
                  //search input bar
                    top: 10,
                    child: InkWell(
                        onTap: () async {
                          var place = await PlacesAutocomplete.show(
                              context: context,
                              apiKey: googleApikey,
                              mode: Mode.overlay,
                              types: [],
                              strictbounds: false,
                              // components: [
                              //   Component(Component.country, 'np')
                              // ],
                              onError: (err) {
                                log("error.....   ${err.errorMessage}");
                              });
                          if (place != null) {
                            setState(() {
                              _address = place.description.toString();
                            });
                            final plist = GoogleMapsPlaces(
                              apiKey: googleApikey,
                              apiHeaders:
                              await const GoogleApiHeaders().getHeaders(),
                            );
                            String placeid = place.placeId ?? "0";
                            final detail =
                            await plist.getDetailsByPlaceId(placeid);
                            final geometry = detail.result.geometry!;
                            final lat = geometry.location.lat;
                            final lang = geometry.location.lng;
                            var newlatlang = LatLng(lat, lang);
                            setState(() {
                              _address = place.description.toString();
                              _onAddMarkerButtonPressed(
                                  LatLng(lat, lang), place.description);
                            });
                            mapController?.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                                    target: newlatlang, zoom: 17)));
                            setState(() {});
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Card(
                            child: Container(
                                padding: const EdgeInsets.all(0),
                                width: MediaQuery.of(context).size.width - 40,
                                child: ListTile(
                                  leading: Image.asset(
                                    AppAssets.drawer_location,
                                    width: AddSize.size15,
                                  ),
                                  title: Text(
                                    _address.toString(),
                                    style:
                                    TextStyle(fontSize: AddSize.font14),
                                  ),
                                  trailing: const Icon(Icons.search),
                                  dense: true,
                                )),
                          ),
                        ))),
                Positioned(
                    bottom: 0,
                    child: Container(
                      height: AddSize.size200,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: AppTheme.backgroundcolor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AddSize.padding16,
                          vertical: AddSize.padding10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: AppTheme.primaryColor,
                                        size: AddSize.size25,
                                      ),
                                      SizedBox(
                                        width: AddSize.size12,
                                      ),
                                      Expanded(
                                        child: Text(
                                          _address.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: AddSize.font16),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: AddSize.size30,
                            ),
                            CommonButton1(
                                title: 'Enter complete address',
                              onPressed: () {
                                setState(() {
                                  _isValue.value = !_isValue.value;
                                  selectedChip.value = "Home";
                                });
                                // FocusManager.instance.primaryFocus!.unfocus();
                                showChangeAddressSheet(addressModel.value);
                                // Get.toNamed(MyRouter.chooseAddressScreen);
                              },
                            ),

                          ],
                        ),
                      ),
                    ))
              ],
            )),
      ),
    );
  }

  chipList(
      title,
      ) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() {
      return Column(
        children: [
          ChoiceChip(
            padding: EdgeInsets.symmetric(
                horizontal: width * .01, vertical: height * .01),
            backgroundColor: AppTheme.backgroundcolor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                    color: title != selectedChip.value
                        ? Colors.grey.shade300
                        : const Color(0xff7ED957))),
            label: Text("$title",
                style: TextStyle(
                    color: title != selectedChip.value
                        ? Colors.grey.shade600
                        : const Color(0xff7ED957),
                    fontSize: AddSize.font14,
                    fontWeight: FontWeight.w500)),
            selected: title == selectedChip.value,
            selectedColor: const Color(0xff7ED957).withOpacity(.13),
            onSelected: (value) {
              selectedChip.value = title;
              if (title == "Other") {
                customTip.value = true;
                otherController.text = "";
              } else {
                customTip.value = false;
                otherController.text = title;
              }
              setState(() {});
            },
          )
        ],
      );
    });
  }
}