import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:homemady/controller/user_profile_controller.dart';
import '../repository/update_location_repo.dart';

class LocationController extends GetxController {
  final profileController = Get.put(UserProfileController());
  RxBool servicestatus = false.obs;
  RxBool haspermission = false.obs;
  late LocationPermission permission;
  late Position position;
  RxString long = "".obs;
      RxString  lat = "".obs;
  var locality = 'No location set'.obs;
  var country = 'Getting Country..'.obs;
  late StreamSubscription<Position> positionStream;

  checkGps(context) async {
    servicestatus.value = await Geolocator.isLocationServiceEnabled();
    if (servicestatus.value) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.denied) {
          haspermission.value = true;
        }
      } else {
        haspermission.value = true;
      }

      if (haspermission.value) {
        getLocation();
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              "Location",
            ),
            content: const Text(
              "Please turn on GPS location service to narrow down the nearest Cooks.",
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await Geolocator.openLocationSettings();
                  servicestatus.value =
                  await Geolocator.isLocationServiceEnabled();
                  if (servicestatus.value) {
                    permission = await Geolocator.checkPermission();

                    if (permission == LocationPermission.denied) {
                      permission = await Geolocator.requestPermission();
                      if (permission == LocationPermission.denied) {
                      } else if (permission ==
                          LocationPermission.deniedForever) {
                      } else {
                        haspermission.value = true;
                      }
                    } else {
                      haspermission.value = true;
                    }

                    if (haspermission.value) {
                      getLocation();
                    }
                  }
                },
              ),
            ],
          ));
    }
  }

  Future getLocation() async {
    log("Getting user location.........");
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    long.value = position.longitude.toString();
    lat.value = position.latitude.toString();
    await placemarkFromCoordinates(
        double.parse(lat.value), double.parse(long.value))
        .then((value) async {
      locality.value = value.last.locality!;
      country.value = 'Country : ${value.last.country}';
      print("fffffffff"+long.value.toString());

      if(profileController.model.value.data!.longitude == null && profileController.model.value.data!.longitude == null){
        await updateLocation(
          latitude: lat.toString(),
          longitude: long.toString(),
        );
      }
      print("aaaaaaaaaa"+long.value.toString());
    });
  }

  // getApiLocation() async {
  //   log("Getting user location.........");
  //   await placemarkFromCoordinates(
  //       double.parse(lat.value == '' ? "0" : lat.value),
  //       double.parse(long.value == '' ? "0" : long.value))
  //       .then((value) {
  //     locality.value = 'Locality: ${value.first.locality}';
  //     country.value = 'Country : ${value.last.country}';
  //     log(value.map((e) => e.locality).toList().toString());
  //     log(locality.value);
  //     log(country.value);
  //   });
  // }



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    profileController.getData();
    checkGps(Get.context);
  }
}
