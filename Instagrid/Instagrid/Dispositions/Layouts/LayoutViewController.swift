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
    
    @IBOutlet var imageViews: [UIImageView]!
    
    let viewModel = ViewModelManager.viewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gestureEvents()
        restoreFromViewModel()
    }
    
    private func restoreFromViewModel(){
        for (index, view) in imageViews.enumerated() {
            view.image = viewModel.images[index]
        }
    }
    
    private func gestureEvents() {
        for pictureView in pictureViews {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
            pictureView.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc private func tapHandler(_ sender: UITapGestureRecognizer? = nil) {
        
        guard let tag = sender?.view?.tag else { print("unroconized"); return }
        viewModel.currentViewTag = tag
        print("vue \(tag) clicked !")
        
        showImagePicker()
    }

    private func showImagePicker() {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.filter = .images
        configuration.preferredAssetRepresentationMode = .current
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    private func loadInsideView(withImage image: UIImage, atPosition position: Int) {
        imageViews[position].image = image
    }
    
    //MARK: PHPicker Delegate
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        guard results.first != nil else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        
        let provider = results.first?.itemProvider
        provider?.loadObject(ofClass: UIImage.self) { (pickedImage, error) in
            if let image = pickedImage as? UIImage {
                print("c'est bien une image: \(image.description)")
                DispatchQueue.main.async {
                    if let imagePosition = self.viewModel.currentViewTag {
                        self.loadInsideView(withImage: image, atPosition: imagePosition)
                        self.viewModel.images[imagePosition] = image
                    }
                }
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
