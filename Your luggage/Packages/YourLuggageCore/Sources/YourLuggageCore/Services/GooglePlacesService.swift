import GooglePlaces
import CoreLocation
import UIKit

public struct Place {
    public let name: String
    public let identifier: String
}

public enum GooglePlacesServiceError: Error {
    case failedToFind
    case failedToGetCoordinates
    case failedToGetPhotos
}

public protocol GooglePlacesServiceProtocol {
    func findPlaces(
        query: String,
        complition: @escaping (Result<[Place], GooglePlacesServiceError>) -> Void
    )
    
    func getLocation(
        for place: Place,
        complition: @escaping (Result<CLLocationCoordinate2D, GooglePlacesServiceError>) -> Void
    )
    
    func getImage(
        for place: Place,
        complition: @escaping (Result<UIImage, GooglePlacesServiceError>) -> Void
    )
}

public final class GooglePlacesService: GooglePlacesServiceProtocol {
    
    private let client: GMSPlacesClient
    public init(client: GMSPlacesClient) {
        self.client = client
    }
    
    public func findPlaces(
        query: String,
        complition: @escaping (Result<[Place], GooglePlacesServiceError>) -> Void
    ) {
        let filter = GMSAutocompleteFilter()
        filter.type = .geocode
        
        client.findAutocompletePredictions(
            fromQuery: query,
            filter: filter,
            sessionToken: nil) { (results, error) in
            guard let results = results, error == nil else {
                complition(.failure(GooglePlacesServiceError.failedToFind))
                return
            }
            let places: [Place] = results.compactMap({
                Place(name: $0.attributedFullText.string, identifier: $0.placeID)
            })
            complition(.success(places))
        }
    }
    
    public func getLocation(
        for place: Place,
        complition: @escaping (Result<CLLocationCoordinate2D, GooglePlacesServiceError>) -> Void
    ) {
        client.fetchPlace(
            fromPlaceID: place.identifier,
            placeFields: .coordinate,
            sessionToken: nil) { (place, error) in
            guard let place = place, error == nil else {
                complition(.failure(GooglePlacesServiceError.failedToGetCoordinates))
                return
            }
            
            let coordinate = CLLocationCoordinate2D(
                latitude: place.coordinate.latitude,
                longitude: place.coordinate.longitude)
            complition(.success(coordinate))
        }
        
    }
    
    public func getImage(
        for place: Place,
        complition: @escaping (Result<UIImage, GooglePlacesServiceError>) -> Void
    ) {
        client.fetchPlace(
            fromPlaceID: place.identifier,
            placeFields: .photos,
            sessionToken: nil) { [weak self] (place, error) in
            guard let place = place, error == nil else {
                complition(.failure(GooglePlacesServiceError.failedToGetPhotos))
                return
            }
            guard let images = place.photos else {
                complition(.failure(GooglePlacesServiceError.failedToGetPhotos))
                return
            }
            self?.client.loadPlacePhoto(images.first!) { (image, error) in
                guard let image = image, error == nil else {
                    complition(.failure(GooglePlacesServiceError.failedToGetPhotos))
                    return
                }
                complition(.success(image))
            }
        }
    }
}
