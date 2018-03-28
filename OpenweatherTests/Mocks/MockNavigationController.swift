//
//  MockNavigationController.swift
//  OpenweatherTests
//
//  Created by Raviraju Vysyaraju  on 28/03/18.
//  Copyright © 2018 Raviraju Vysyaraju. All rights reserved.
//

import Foundation
import UIKit

class MockNavigationController: UINavigationController {
    var viewPresented: UIViewController?
    var viewControllerPushed: UIViewController?

    override func present(_ viewControllerToPresent: UIViewController,
                          animated flag: Bool,
                          completion: (() -> Void)? = nil) {
        viewPresented = viewControllerToPresent
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewControllerPushed = viewController
    }
}
