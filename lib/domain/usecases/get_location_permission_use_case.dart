import 'package:geolocator/geolocator.dart';
import 'package:weather/domain/models/location_permission_model.dart';
import 'package:weather/foundation/use_case/use_case.dart';

const String serviceDisabledError = 'Location services are disabled. Please enable the services';
const String locationPermissionDeniedError = 'Location permissions are denied';
const String locationPermissionPermanentlyDeniedError = 'Location permission are permanently denied, we cannot request permissions';

class GetLocationPermissionUseCase extends UseCase<LocationPermissionModel, void> {
  @override
  Future<LocationPermissionModel> call({void params}) async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return LocationPermissionModel(false, errorText: serviceDisabledError);
      }

      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return LocationPermissionModel(false, errorText: locationPermissionDeniedError);
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return LocationPermissionModel(false, errorText: locationPermissionPermanentlyDeniedError);
      }
      return LocationPermissionModel(true);
    } catch (e) {
      print('ERROR Providing permission $e');
      return LocationPermissionModel(false, errorText: e.toString());
    }
  }
}
