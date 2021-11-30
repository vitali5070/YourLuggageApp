import Foundation
import YourLuggageCore

typealias SessionProtocol = UserRepositoryHolderProtocol &
                            TripRepositoryHolderProtocol &
                            ConfigRepositoryHolderProtocol

struct Session: SessionProtocol {
    var userRepository: UserRepositoryProtocol
    let tripRepository: TripRepositoryProtocol
    let configRepository: ConfigRepositoryProtocol

    static func configuredSession() -> SessionProtocol {
        let storage = Storage()
        let apiClient = APIClient()
        let keychain = Keychain()
        
        let tripRepository = TripRepository(
            storage: storage,
            tripAPI: apiClient
        )
        
        let userRepository = UserRepository(
            api: apiClient,
            secureUserStorage: keychain,
            userStorage: storage
        )

        let configRepository = ConfigRepository()

        // Session
        let session = Session(
            userRepository: userRepository,
            tripRepository: tripRepository,
            configRepository: configRepository
        )
        
        return session
    }
}

struct SessionMock: SessionProtocol {
    var userRepository: UserRepositoryProtocol
    var tripRepository: TripRepositoryProtocol
    var configRepository: ConfigRepositoryProtocol

    init(
        userRepository: UserRepositoryProtocol = UserRepositoryMock(),
        tripRepository: TripRepositoryProtocol = TripRepositoryMock(),
        configRepository: ConfigRepositoryProtocol = ConfigRepositoryMock()
    ) {
        self.tripRepository = tripRepository
        self.userRepository = userRepository
        self.configRepository = configRepository
    }
}
