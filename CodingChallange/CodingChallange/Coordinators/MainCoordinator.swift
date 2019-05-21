//
//  MainCoordinator.swift
//  CodingChallange
//
//  Created by Mounir Bittar on 5/20/19.
//  Copyright © 2019 Mounir Bittar. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = RepositoryController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openRepositoryDetails(_ repository: RepositoryViewModel) {
        let vc = RepositoryDetailsController.instantiate()
        vc.repositoryViewModel = repository
        navigationController.pushViewController(vc, animated: true)
    }
}
