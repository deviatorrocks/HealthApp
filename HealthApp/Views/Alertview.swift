//
//  Alertview.swift
//  HealthApp
//
//  Created by Mandar Kadam on 29/04/24.
//

import Foundation
import UIKit

struct AlertView {
    static func showAlert(title: String?, message: String?, viewController: UIViewController, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                completion?()
            }
            alertController.addAction(okAction)
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
}
