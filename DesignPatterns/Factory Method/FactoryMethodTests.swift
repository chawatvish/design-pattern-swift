import XCTest
@testable import DesignPatterns

class FactoryMethodTests: XCTestCase {
    func testFactoryMethodRealWorld() {
           let info = "Very important info of the presentation"
           let clientCode = ClientCode()
           clientCode.present(info: info, with: WifiFactory())
           clientCode.present(info: info, with: BluetoothFactory())
       }
}
