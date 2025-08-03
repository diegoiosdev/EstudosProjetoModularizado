//
//  SingleInstanceTestModels.swift
//  DenpendencyContainer
//
//  Created by Diego Fernando on 02/08/25.
//

import Foundation

protocol SingleInstanceProtocol: AnyObject {
    func sampleMethod()
}

final class SingleInstanceImplementation: SingleInstanceProtocol {
    func sampleMethod() {
        // left blank instentionally
    }
}
