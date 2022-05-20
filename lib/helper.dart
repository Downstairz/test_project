import 'dart:math' as math;

class GeoLocation {
  ///https://github.com/kapilmhr/sorting_nearest_location
  static double getDistanceFromLatLonInKm(lat1,lon1,lat2,lon2) {
    final R = 6371; // Radius of the earth in km
    final dLat = deg2rad(lat2-lat1);  // deg2rad below
    final dLon = deg2rad(lon2-lon1);
    final a =
        math.sin(dLat/2) * math.sin(dLat/2) +
            math.cos(deg2rad(lat1)) * math.cos(deg2rad(lat2)) *
                math.sin(dLon/2) * math.sin(dLon/2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1-a));
    final d = R * c; // Distance in km
    return d;
  }

  static double deg2rad(deg) {
    return deg * (math.pi/180);
  }
}