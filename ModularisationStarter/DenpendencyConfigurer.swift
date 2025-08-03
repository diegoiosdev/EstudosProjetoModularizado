//
//  DenpendencyConfigurer.swift
//  ModularisationStarter
//
//  Created by Diego Fernando on 03/08/25.
//
import Analytics
import AnalyticsInterface
import DenpendencyContainer
import Foundation

enum AppDenpendencyConfigurer {
    @MainActor
    static func configure() {
        let analyticsTracker = AnalyticsEventTracker()
        DC.shared.register(type: .singleInstance(analyticsTracker), for: AnalyticsEventTracking.self)
    }
}
