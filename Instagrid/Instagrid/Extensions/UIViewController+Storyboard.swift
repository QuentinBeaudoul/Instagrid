//
//  UIViewController+Identifier.swift
//  Instagrid
//
//  Created by Quentin Beaudoul on 26/10/2021.
//

import Foundation
import UIKit
extension UIViewController {
    
    class func makeFromStoryboard(_ storyboardName: String? = nil) -> UIViewController {
        return UIStoryboard(name: storyboardName ?? String(describing: self).replacingOccurrences(of: "ViewController", with: ""), bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: self))
    }
}
