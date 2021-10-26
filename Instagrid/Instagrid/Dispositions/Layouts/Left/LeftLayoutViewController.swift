//
//  LeftLayoutViewController.swift
//  Instagrid
//
//  Created by Quentin Beaudoul on 26/10/2021.
//

import UIKit

class LeftLayoutViewController: UIViewController {

    
    @IBOutlet var pictureViews: [UIView]!
    
    let viewModel = LayoutViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gestureEvents()
    }
    
    private func gestureEvents() {
        for pictureView in pictureViews {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
            pictureView.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc private func tapHandler(_ sender: UITapGestureRecognizer? = nil) {
        
        guard let tag = sender?.view?.tag else { print("unroconized"); return }
        
        print("vue \(tag) clicked !")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
