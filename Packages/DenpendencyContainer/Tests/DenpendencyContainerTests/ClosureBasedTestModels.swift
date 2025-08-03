//
//  ClosureBasedTestModels.swift
//  DenpendencyContainer
//
//  Created by Diego Fernando on 03/08/25.
//

import Foundation

protocol ClosureBasedProtocol {
    func sampleMethod()
}

struct ClosureBasedImplementation: ClosureBasedProtocol {
    func sampleMethod() {
        // left blank intentionally
    }
}

protocol AnotherDenpendencyProtocol {
    func anotherSampleMethod()
}

struct AnotherDenpendencyImplementation: AnotherDenpendencyProtocol {
    
    private let service: ClosureBasedProtocol
    
    init(service: ClosureBasedProtocol) {
        self.service = service
    }
    
    func anotherSampleMethod() {
        // left blank intentiinally
    }
}
