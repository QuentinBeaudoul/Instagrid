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
    
    let viewModel = MainViewModel()
    var currentLayoutViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        gesturesEvents()
        initFirstController()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragCompositionView(_:)))
        compositionView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func dragCompositionView(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            swipeCompositionViewToShare(gesture: sender)
        case .ended, .cancelled:
            compositionView.transform = .identity
        default:
            break
        }
    }
    
    private func swipeCompositionViewToShare(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: compositionView)
        
        print("translation y: \(translation.y)")
        
        if UIDevice.current.orientation.isPortrait || UIDevice.current.orientation.isFlat {
            compositionView.transform = CGAffineTransform(translationX: 0, y: translation.y)
            if translation.y <= -200 {
                share()
            }
        }else {
            compositionView.transform = CGAffineTransform(translationX: translation.x, y: 0)
            if translation.x <= -200 {
                share()
            }
        }
    }
    
    private func share(){
        // image to share
        let image = generateImagetoShare()
        
        // set up activity view controller
        let imagesToShare = [image]
        let activityViewController = UIActivityViewController(activityItems: imagesToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    private func generateImagetoShare() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: compositionView.bounds.size)
        return renderer.image { ctx in
            compositionView.drawHierarchy(in: compositionView.bounds, afterScreenUpdates: true)
        }
    }
    
    private func initFirstController(){
        guard let viewController = CenterLayoutViewController.makeFromStoryboard("Layouts") as? CenterLayoutViewController else { return }
        bindingView(with: viewController)
    }
    
    private func gesturesEvents(){
        for viewLayout in viewLayouts {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(layoutChoiceTap(_:)))
            viewLayout.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc private func layoutChoiceTap(_ sender: UITapGestureRecognizer? = nil){
        
        guard let tag = sender?.view?.tag else { print("unroconized"); return }
        
        hideAllSelected()
        selectedViews[tag].isHidden = false
        changeLayout(layoutIdentifier: tag)
        
    }
    
    private func hideAllSelected(){
        for selectedView in selectedViews {
            selectedView.isHidden = true
        }
    }
    
    private func changeLayout(layoutIdentifier layoutId: Int){
        var viewController: UIViewController?
        
        switch layoutId {
        case 0:
            viewController = LeftLayoutViewController.makeFromStoryboard("Layouts")
        case 1:
            viewController = CenterLayoutViewController.makeFromStoryboard("Layouts")
        case 2:
            viewController = RightLayoutViewController.makeFromStoryboard("Layouts")
        default:
            print("error")
        }
        
        guard let layoutViewController = viewController else {
            print("error");
            return;
        }
        
        bindingView(with: layoutViewController)
    }
    
    private func bindingView(with viewController: UIViewController) {
        
        if let viewControllerToRemove = currentLayoutViewController {
            viewControllerToRemove.view.removeFromSuperview()
            viewControllerToRemove.removeFromParent()
        }
        
        let childView: UIView! = viewController.view
        childView.translatesAutoresizingMaskIntoConstraints = false
        
        currentLayoutViewController = viewController
        compositionView.addSubview(childView)
        
        NSLayoutConstraint.activate([childView.leadingAnchor.constraint(equalTo: compositionView.leadingAnchor),
                                     childView.trailingAnchor.constraint(equalTo: compositionView.trailingAnchor),
                                     childView.topAnchor.constraint(equalTo: compositionView.topAnchor),
                                     childView.bottomAnchor.constraint(equalTo: compositionView.bottomAnchor)])
        addChild(viewController)
    }
}

