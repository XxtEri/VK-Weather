import Foundation

final class WeatherService: BaseService, WeatherServiceProtocol {
	// MARK: - Public
	
	func getWeather(latitude: Double, longitude: Double) async throws -> WeatherResponse {
		guard let url = URL(string: URLFactory.Weather.getWeather(latitude: latitude, longitude: longitude)) else {
			throw WeatherServiceError.unowned
		}

		return try await withCheckedThrowingContinuation { continuation in
			get(url: url) { result in
				switch result {
					case let .success(responseData):
						do {
							let decoder = JSONDecoder()
							let model = try decoder.decode(WeatherResponse.self, from: responseData)
							continuation.resume(returning: model)
						} catch {
							continuation.resume(throwing: error)
						}
					case let .failure(error):
						continuation.resume(throwing: error)
				}
			}
		}
	}
	
	func getNextWeathers(latitude: Double, longitude: Double) async throws -> WeathersResponse {
		guard let url = URL(string: URLFactory.Weather.getWeathers(latitude: latitude, longitude: longitude)) else {
			throw WeatherServiceError.unowned
		}
		
		return try await withCheckedThrowingContinuation { continuation in
			get(url: url) { result in
				switch result {
					case let .success(responseData):
						do {
							let decoder = JSONDecoder()
							let model = try decoder.decode(WeathersResponse.self, from: responseData)
							continuation.resume(returning: model)
						} catch {
							print(error)
							continuation.resume(throwing: error)
						}
					case let .failure(error):
						continuation.resume(throwing: error)
				}
			}
		}
	}
	
	// MARK: - Private
	
	private func get(url: URL, completion: @escaping (Result<Data, WeatherServiceError>) -> Void) {
		let request = URLRequest(url: url)
		let task = session.dataTask(with: request) { data, response, error in
			if error != nil {
				completion(.failure(.unowned))
				return
			}
			
			guard let httpResponse = response as? HTTPURLResponse else {
				completion(.failure(.unowned))
				return
			}
			
			guard (200...299).contains(httpResponse.statusCode) else {
				completion(.failure(.unowned))
				print(httpResponse.statusCode)
				return
			}
			
			guard let responseData = data else {
				completion(.failure(.unowned))
				return
			}
			
			completion(.success(responseData))
		}
		
		task.resume()
	}
}
