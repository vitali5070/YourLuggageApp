import Foundation
import Firebase

public final class APIClient: TripAPI {
    public init () {
        FirebaseApp.configure()
    }
}
