import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:template/features/vistor/gates_maps/models/Place.dart';
import 'package:template/shared/generic_cubit/generic_cubit.dart';
import 'package:template/shared/resources.dart';
import 'dart:ui' as ui;

class GateMapsViewModel {
  GenericCubit<Set<Marker>> markers = GenericCubit(Set<Marker>()); // Initialize with an empty set

  List<Place> places = [
    Place("باب الملك فهد", 21.4212925, 39.8241821),
    Place("باب الفتح", 21.4240207, 39.8265113),
    Place("باب الملك عبدالعزيز", 21.4211391,39.8258813),
    Place("باب العمرة", 21.4227791,39.8247309),
    Place("باب السلام", 21.4225965,39.8277311),
  ];

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }


  // Add markers based on a list of locations
  void loadMarkers(List<Map<String, dynamic>> locations) async {
    try{
      final BitmapDescriptor markerIcon = BitmapDescriptor.fromBytes(await getBytesFromAsset(
          Resources.gate, 100));
      Set<Marker> markerSet = locations.map((location) {
        return Marker(
          markerId: MarkerId(location['name']),
          position: LatLng(location['lat'], location['lng']),
          infoWindow: InfoWindow(title: location['name']),
          icon: markerIcon, // Set the custom icon here
        );
      }).toSet();

      markers.onUpdateData(markerSet); // Emit the set of markers
    } catch (e){
      print("load markers Error $e");
      markers.onUpdateData([const Marker(markerId: MarkerId(""))].toSet());
    }
  }
}