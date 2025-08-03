import Foundation

public typealias DC = DependencyContainer

public final class DependencyContainer {
    
    @MainActor public static let shared = DependencyContainer()
    
    private var singleInstanceDependencies: [ObjectIdentifier: AnyObject] = [:]
    private var clouseBaseDenpendencies: [ObjectIdentifier: () -> Any] = [:]
    
    private let dependencyAccessQueue = DispatchQueue(
        label: "com.modularisation.dependency.container.access.queue",
        attributes: .concurrent
    )
    
    private init () {
        
    }
    
    public func register(type: DependencyContainerRegistrationType, for interface: Any.Type) {
        dependencyAccessQueue.sync(flags: .barrier) {
            let objetcIdentifier = ObjectIdentifier(interface)
            switch type {
            case .singleInstance(let instance):
                singleInstanceDependencies[objetcIdentifier] = instance
            case .closureBased(let clouse):
                clouseBaseDenpendencies[objetcIdentifier] = clouse
            }
        }
    }
 
    public func resolve<Value>(type: DenpendencyContainerResolvingType, for insterface: Value.Type) -> Value {
        var value: Value!
        dependencyAccessQueue.sync {
            let objectIdentifier = ObjectIdentifier(insterface)
            switch type {
            case .singleIntstance:
                guard let singleInstanceDependencies = singleInstanceDependencies[objectIdentifier] as? Value else {
                    fatalError("Could not retrieve a dependency for the given type: \(insterface)")
                    //Não foi possível recuperar uma dependência para o tipo fornecido:
                }
                value = singleInstanceDependencies
            case .closureBased:
                guard let closure = clouseBaseDenpendencies[objectIdentifier],
                      let clouseBaseDenpendencies = closure() as? Value else {
                    fatalError("Could not retrieve a dependency for the given type: \(insterface)")
                }
                value = clouseBaseDenpendencies
            }
        }
        return value
    }
}
