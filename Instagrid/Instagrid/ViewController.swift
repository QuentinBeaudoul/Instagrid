//
//  ViewController.swift
//  Instagrid
//
//  Created by Quentin on 21/10/2021.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet var selectedViews: [UIImageView]!
    @IBOutlet weak var compositionView: UIView!
    @IBOutlet var viewLayouts: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gesturesEvents()
    }
    
    private func gesturesEvents(){
        for (_, viewLayout) in viewLayouts.enumerated() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(layoutChoiceTap(_:)))
            viewLayout.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc private func layoutChoiceTap(_ sender: UITapGestureRecognizer? = nil){
        
        guard let tag = sender?.view?.tag else { print("unroconized"); return }
        
        hideAllSelected()
        selectedViews[tag].isHidden = false
        
        switch tag {
            // left layout
        case 0 :
            print("view 1 selected")
            // center layout
        case 1 :
            selectedViews[tag].isHidden = false
            print("view 2 selected")
            // right layout
        case 2 :
            print("view 3 selected")
        default:
            print("default")
        }
    }
    
    private func hideAllSelected(){
        for selectedView in selectedViews {
            selectedView.isHidden = true
        }
    }
}

