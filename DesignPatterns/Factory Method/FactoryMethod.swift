import Foundation

protocol Projector {

    /// Abstract projector interface

    var currentPage: Int { get }

    func present(info: String)

    func sync(with projector: Projector)

    func update(with page: Int)
}

extension Projector {

    /// Base implementation of Projector methods

    func sync(with projector: Projector) {
        projector.update(with: currentPage)
    }
}

protocol ProjectorFactory {

    func createProjector() -> Projector

    func syncedProjector(with projector: Projector) -> Projector
}

extension ProjectorFactory {

    /// Base implementation of ProjectorFactory

    func syncedProjector(with projector: Projector) -> Projector {

        /// Every instance creates an own projector
        let newProjector = createProjector()

        /// sync projectors
        newProjector.sync(with: projector)

        return newProjector
    }
}

class WifiFactory: ProjectorFactory {

    func createProjector() -> Projector {
        return WifiProjector()
    }
}

class BluetoothFactory: ProjectorFactory {

    func createProjector() -> Projector {
        return BluetoothProjector()
    }
}

class WifiProjector: Projector {

    var currentPage = 0

    func present(info: String) {
        print("Info is presented over Wifi: \(info)")
    }

    func update(with page: Int) {
        currentPage = page
    }
}

class BluetoothProjector: Projector {

    var currentPage = 0

    func present(info: String) {
        print("Info is presented over Bluetooth: \(info)")
    }

    func update(with page: Int) {
        currentPage = page
    }
}

class ClientCode {

    var currentProjector: Projector?

    func present(info: String, with factory: ProjectorFactory) {

        guard let projector = currentProjector else {
            let projector = factory.createProjector()
            projector.present(info: info)
            self.currentProjector = projector
            return
        }
        self.currentProjector = factory.syncedProjector(with: projector)
        self.currentProjector?.present(info: info)
    }
}
