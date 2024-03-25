import CoreLocation

final class LocationService: NSObject, LocationServiceProtocol {
	// MARK: - Init
	
	init(locationManager: CLLocationManager = CLLocationManager(), geocoder:  CLGeocoder = CLGeocoder()) {
		self.locationManager = locationManager
		self.geocoder = geocoder
		super.init()
		locationManager.delegate = self
	}
	
	// MARK: - Public
	
	var onDidLoadLocality: ((String) -> Void)?
	var onDidLoadCoordinateLocation: ((LocationCoordinates) -> Void)?
	var onDidReceiveError: ((LocationServiceError) -> Void)?
	
	func determineLocation() {
		if locationManager.authorizationStatus == .notDetermined {
			locationManager.requestWhenInUseAuthorization()
		}
	}
	
	func checkPermission() -> Bool {
		switch locationManager.authorizationStatus {
			case .authorizedAlways, .authorizedWhenInUse:
				return true
			default:
				return false
		}
	}
	
	// MARK: - Private
	
	private let locationManager: CLLocationManager
	private let geocoder: CLGeocoder
	
	private func determineCity(coordinates: CLLocation) {
		geocoder.reverseGeocodeLocation(coordinates) { placemark, error in
			if let error = error {
				print(error)
				self.onDidReceiveError?(LocationServiceError.unauthorized)
			}
			guard let placemark = placemark?.first else { return }
			
			if let locality = placemark.locality ?? placemark.subLocality {
				self.onDidLoadLocality?(locality)
			}
		}
	}
}

extension LocationService: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.last else { return }
		
		let latitude = location.coordinate.latitude.magnitude
		let longitude = location.coordinate.longitude.magnitude
		
		determineCity(coordinates: CLLocation(latitude: latitude, longitude: longitude))
		
		onDidLoadCoordinateLocation?(LocationCoordinates(latitude: latitude, longitude: longitude))
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print(error)
		onDidReceiveError?(LocationServiceError.unknowned)
	}
	
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		switch manager.authorizationStatus {
			case  .restricted:
				print("restricted")
			case .denied, .notDetermined:
				onDidReceiveError?(LocationServiceError.unauthorized)
			case .authorizedWhenInUse, .authorizedAlways:
				locationManager.requestLocation()
			default:
				()
		}
	}
}
	
	
