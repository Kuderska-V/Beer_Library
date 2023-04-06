//
//  Allert.swift
//  Beer_Library
//
//  Created by Vitalina Nazaruk on 27.03.2023.
//

import UIKit

extension UIViewController {
    
    func showAlertMessage(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

