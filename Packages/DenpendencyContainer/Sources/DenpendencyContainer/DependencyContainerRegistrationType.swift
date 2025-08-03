//
//  DependencyContainerRegistrationType.swift
//  DenpendencyContainer
//
//  Created by Diego Fernando on 02/08/25.
//

import Foundation

public enum DependencyContainerRegistrationType {
    case singleInstance(AnyObject)
    case closureBased(() -> Any)
}
