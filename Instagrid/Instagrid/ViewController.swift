//
//  ViewController.swift
//  Instagrid
//
//  Created by Quentin on 21/10/2021.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet var selectedViews: [UIImageView]!
    @IBOutlet var compositionViews: [UIView]!
    @IBOutlet var viewLayouts: [UIView]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gesturesEvents()
    }
    
    private func gesturesEvents(){
        for (_, viewLayout) in viewLayouts.enumerated() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            viewLayout.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer? = nil){
        
        guard let tag = sender?.view?.tag else { print("unroconized"); return }
        
        hideAllSelected()
        hideAllCompositionViews()
        selectedViews[tag].isHidden = false
        compositionViews[tag].isHidden = false
        /*switch tag {
        case 0 :
            hideAllSelected()
            selectedViews[tag].isHidden = false
            print("view 1 selected")
        case 1 :
            selectedViews[tag].isHidden = false
            print("view 2 selected")
        case 2 :
            print("view 3 selected")
        default:
            print("default")
        }*/
    }
    
    private func hideAllSelected(){
        for selectedView in selectedViews {
            selectedView.isHidden = true
        }
    }
    private func hideAllCompositionViews(){
        for compositionView in compositionViews {
            compositionView.isHidden = true
        }
    }


}

