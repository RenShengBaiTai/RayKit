//
//  RayNavigationViewController.swift
//  Pods
//
//  Created by admin on 2020/5/18.
//

import UIKit

class RayNavigationViewController: UINavigationController, UINavigationControllerDelegate{

    func setNavBar() {
        let navBar: UINavigationBar = UINavigationBar.appearance()
        navBar.isTranslucent = false
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.RaySystemFont(ofSize: 18)]
        navBar.barTintColor = RayMainColor
        navBar.shadowImage = UIImage()
        navBar.tintColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavBar()
        delegate = self
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
       if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true;
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backIcon"), style: .plain, target: self, action: #selector(navigationBack))
       }
       super.pushViewController(viewController, animated: true)
   }
   
   @objc func navigationBack() {
       
       popViewController(animated: true)
   }
       
}
