//
//  SongDetailsCoordinator.swift
//  ModularisationStarter
//
//  Created by Emre Havan on 13.02.24.
//

import AnalyticsInterface
import CommonModels
import DenpendencyContainer
import SwiftUI

final class SongDetailsCoordinator {

    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    @MainActor
    func makeViewController(with song: Song) -> UIViewController {
        let analyticsTracker = DC.shared.resolve(type: .singleIntstance, for: AnalyticsEventTracking.self)
        let view = SongDetailsView(
            viewModel: .init(
                song: song,
                analyticsTracker: analyticsTracker,
                onGoToArtistTapped: pushArtistDetail(withIdentifier:)
            )
        )
        let hostingVC = UIHostingController(rootView: view)
        hostingVC.title = song.name
        return hostingVC
    }

    @MainActor
    private func pushArtistDetail(withIdentifier id: String) {
//        let coordinator = ArtistDetailsCoordinator(navigationController: navigationController)
//        let view = coordinator.makeViewController(artistIdentifier: id)
//        navigationController?.pushViewController(view, animated: true)
    }
}
