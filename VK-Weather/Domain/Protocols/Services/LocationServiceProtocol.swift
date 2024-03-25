import CoreLocation

protocol LocationServiceProtocol {
	var onDidLoadLocality: ((String) -> Void)? { get set }
	var onDidLoadCoordinateLocation: ((LocationCoordinates) -> Void)? { get set }
	var onDidReceiveError: ((LocationServiceError) -> Void)? { get set }
	
	func determineLocation()
	func checkPermission() -> Bool
}
