//
//  UIAlertController+Extensions.swift
//  JobsityiOSChallenge
//
//  Created by Antonio Carlos on 04/03/22.
//

import UIKit

extension UIAlertController {
    static func createErrorAlert(with message: String, action: @escaping (() -> Void)) -> UIAlertController {
        let alert = UIAlertController(title: "Ops..", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: { _ in
            action()
        }))
        return alert
    }
}
