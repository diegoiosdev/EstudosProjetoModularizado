import XCTest
@testable import DenpendencyContainer

final class DenpendencyContainerTests: XCTestCase {
    
    @MainActor
    func test_single_instance_registration_and_resolving() {
        let instance = SingleInstanceImplementation()
        DC.shared.register(type: .singleInstance(instance), for: SingleInstanceProtocol.self)

        let resolvedInstance = DC.shared.resolve(type: .singleIntstance, for:  SingleInstanceProtocol.self)
        XCTAssert(instance === resolvedInstance)
    }
    
    @MainActor
     func test_closure_based_registration_and_resolving() {
        let closure: () -> ClosureBasedProtocol = {
            ClosureBasedImplementation()
        }
        DC.shared.register(type: .closureBased(closure), for: ClosureBasedProtocol.self)
        
        let resolved = DC.shared.resolve(type: .closureBased, for: ClosureBasedProtocol.self)
        XCTAssert(resolved is ClosureBasedImplementation)
    }
    
    @MainActor
     func test_closure_based_dependency_that_depends_on_another() {
        let closure: () -> ClosureBasedProtocol = {
            ClosureBasedImplementation()
        }
        DC.shared.register(type: .closureBased(closure), for: ClosureBasedProtocol.self)
        
         let anotherDenpendencyClosure: () -> AnotherDenpendencyProtocol = {
             let service = DC.shared.resolve(type: .closureBased, for: ClosureBasedProtocol.self)
             let anotherDenpendency = AnotherDenpendencyImplementation(service: service)
             return anotherDenpendency
         }
         DC.shared.register(type: .closureBased(anotherDenpendencyClosure), for: AnotherDenpendencyProtocol.self)
         
         let resolvedAnotherDenpendecy = DC.shared.resolve(type: .closureBased, for: AnotherDenpendencyProtocol.self)
    }
}
