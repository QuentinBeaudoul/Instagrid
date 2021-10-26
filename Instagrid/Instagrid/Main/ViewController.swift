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
        compositionView.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        
        print("translation x: \(translation.x)")
        
        if UIDevice.current.orientation.isPortrait || UIDevice.current.orientation.isFlat {
            if translation.y <= -200 {
                share()
            }
        }else {
            if translation.x <= -200 {
                share()
            }
        }
    }
    
    //TODO: Implementer la logique de l'app
    private func share(){
        // text to share
        let text = "This is some text that I want to share."
        
        // set up activity view controller
        //let imagesToShare = viewModel.images
        let imagesToShare = [text]
        let activityViewController = UIActivityViewController(activityItems: imagesToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
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
        switch layoutId {
        case 0:
            guard let viewController = LeftLayoutViewController.makeFromStoryboard("Layouts") as? LeftLayoutViewController else { return }
            bindingView(with: viewController)
        case 1:
            guard let viewController = CenterLayoutViewController.makeFromStoryboard("Layouts") as? CenterLayoutViewController else { return }
            bindingView(with: viewController)
        case 2:
            guard let viewController = RightLayoutViewController.makeFromStoryboard("Layouts") as? RightLayoutViewController else { return }
            bindingView(with: viewController)
        default:
            print("error")
        }
    }
    
    private func bindingView(with viewController: UIViewController) {
        
        if let viewControllerToRemove = viewModel.currentLayoutViewController {
            viewControllerToRemove.view.removeFromSuperview()
            viewControllerToRemove.removeFromParent()
        }
        
        let childView: UIView! = viewController.view
        childView.translatesAutoresizingMaskIntoConstraints = false
        
        viewModel.currentLayoutViewController = viewController
        compositionView.addSubview(childView)
        
        NSLayoutConstraint.activate([childView.leadingAnchor.constraint(equalTo: compositionView.leadingAnchor),
                                     childView.trailingAnchor.constraint(equalTo: compositionView.trailingAnchor),
                                     childView.topAnchor.constraint(equalTo: compositionView.topAnchor),
                                     childView.bottomAnchor.constraint(equalTo: compositionView.bottomAnchor)])
        addChild(viewController)
    }
}

