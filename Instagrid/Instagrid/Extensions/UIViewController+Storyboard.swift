//
//  UIViewController+Identifier.swift
//  Instagrid
//
//  Created by Quentin Beaudoul on 26/10/2021.
//

import Foundation
import UIKit
extension UIViewController {
    //TODO: R.swift ou swiftgen
    class func makeFromStoryboard(_ storyboardName: String? = nil) -> UIViewController {
        return UIStoryboard(name: storyboardName ?? String(describing: self).replacingOccurrences(of: "ViewController", with: ""), bundle: Bundle(identifier: "p5.qbeaudoul.Instagrid")).instantiateViewController(withIdentifier: String(describing: self))
    }
}
