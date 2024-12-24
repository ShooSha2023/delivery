import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // تحقق من تمكين خدمة الموقع
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('خدمة الموقع معطلة. يرجى تمكينها.');
  }

  // تحقق من أذونات الموقع
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('تم رفض إذن الوصول للموقع.');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception('تم رفض إذن الوصول للموقع بشكل دائم. لا يمكننا طلب الإذن.');
  }

  // احصل على الموقع الحالي
  return await Geolocator.getCurrentPosition();
}

Future<String> getAddressFromCoordinates(double lat, double lng) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    Placemark place = placemarks[0];
    return '${place.street}, ${place.locality}, ${place.country}';
  } catch (e) {
    return 'لا يمكن العثور على العنوان.';
  }
}
