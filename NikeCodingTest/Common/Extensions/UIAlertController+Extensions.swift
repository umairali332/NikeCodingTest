//
//  UIAlertController+Extensions.swift
//  HRTaxiApp
//
//  Created by Umair Ali on 20/01/2019.
//  Copyright © 2019 Umair Ali. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(with error: Error) {
        let controller = UIAlertController(title: "Error Message",
                                           message: error.localizedDescription,
                                           preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        controller.addAction(action)
        
        present(controller, animated: true, completion: nil)
    }
}
