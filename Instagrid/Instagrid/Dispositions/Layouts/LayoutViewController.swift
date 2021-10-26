//
//  LayoutViewController.swift
//  Instagrid
//
//  Created by Quentin Beaudoul on 26/10/2021.
//

import UIKit
import PhotosUI

class LayoutViewController: UIViewController, PHPickerViewControllerDelegate {
    
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
        viewModel.currentView = sender?.view
        print("vue \(tag) clicked !")
        
        showImagePicker()
    }

    
    
    private func showImagePicker() {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.filter = .any(of: [.images])
        configuration.preferredAssetRepresentationMode = .current
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    //MARK: Delegate
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        guard results.first != nil else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        
        picker.dismiss(animated: true) {
            let provider = results.first?.itemProvider
            provider?.loadObject(ofClass: UIImage.self) { (pickedImage, error) in
                if let image = pickedImage as? UIImage {
                    print("c'est bien une image: \(image.description)")
                    
                }
            }
        }
    }
    
}
