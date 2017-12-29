//
//  ViewController.swift
//  TestMenuBar
//
//  Created by Pesok on 12/28/17.
//  Copyright © 2017 Owluzions. All rights reserved.
//

import UIKit

class MenuBarToViewSegue: UIStoryboardSegue {
    
    override func perform() {
        let viewControllerWithMenuBar = self.source as! ViewControllerWithMenuBar
        //viewControllerWithMenuBar.menuViewControllers.append(self.destination)
        viewControllerWithMenuBar.present(viewController: self.destination)
    }
    
}

protocol ViewControllerWithMenuBarDelegate {
    func mainAreaViewFrame () -> CGRect
}

class ViewControllerWithMenuBar: UIViewController, UIGestureRecognizerDelegate {

    var delegate: ViewControllerWithMenuBarDelegate?
    
    @IBAction func menuBarItemClicked(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let currentVC = self.childViewControllers.first {
            currentVC.view.frame = mainAreaViewFrame()
        }
    }
    
    func mainAreaViewFrame() -> CGRect {
        if let delegate = self.delegate {
            return delegate.mainAreaViewFrame()
        }
        return self.view.frame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func removeCurrentViewController () {
        if let currentVC = self.childViewControllers.first {
            currentVC.willMove(toParentViewController: nil)
            currentVC.view.removeFromSuperview()
            currentVC.removeFromParentViewController()
        }
    }

    func present (viewController: UIViewController) {
        
        let withAnimation = false
        
        if (withAnimation) {
            if let currentVC = self.childViewControllers.first {
                presentWithAnimation(fromViewController: currentVC, toViewController: viewController)
            }
        } else {// Without Anumation
            removeCurrentViewController()
            self.addChildViewController(viewController)
            viewController.view.frame = mainAreaViewFrame()
            self.view.addSubview(viewController.view)
            viewController.didMove(toParentViewController: self)
        }
    }
    
    func presentWithAnimation (fromViewController: UIViewController, toViewController: UIViewController) {
        fromViewController.willMove(toParentViewController: nil)
        self.addChildViewController(toViewController)
        
        let toViewStartFrame = mainAreaViewFrame().offsetBy(dx: -self.view.frame.width, dy: 0)
        let toViewEndFrame = mainAreaViewFrame()
        let fromViewEndFrame = self.mainAreaViewFrame().offsetBy(dx: +self.view.frame.width, dy: 0)
        
        toViewController.view.frame = toViewStartFrame
        self.view.addSubview(toViewController.view)

        self.transition(from: fromViewController, to: toViewController, duration: 0.25, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
            //fromViewController.view.removeFromSuperview()
            fromViewController.view.frame = fromViewEndFrame
            toViewController.view.frame = toViewEndFrame
            
        }) { (finished) in
            fromViewController.view.removeFromSuperview()
            fromViewController.removeFromParentViewController()
            toViewController.didMove(toParentViewController: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
}

