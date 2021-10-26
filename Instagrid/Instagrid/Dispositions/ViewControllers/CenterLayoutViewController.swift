//
//  CenterLayoutViewController.swift
//  Instagrid
//
//  Created by Quentin Beaudoul on 26/10/2021.
//

import UIKit

class CenterLayoutViewController: UIViewController {

    
    @IBOutlet var pictureViews: [UIView]!
    
    let viewModel = CenterLayoutViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
