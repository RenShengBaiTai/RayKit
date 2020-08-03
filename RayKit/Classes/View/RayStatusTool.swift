//
//  RayStatusTool.swift
//  RayKit
//
//  Created by admin on 2020/7/23.
//

import UIKit

private var statusViewKey: String = "statusView"

public extension UIView{

    var statusView: UIView? {
        get {
            return (objc_getAssociatedObject(self, &statusViewKey) as? UIView)
        }
        set(newValue) {
            objc_setAssociatedObject(self, &statusViewKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    public func showErrorStatus(type: RayStatusViewType, location: RayStatusViewLocation, block: @escaping () -> Void) {
        
        if self.statusView == nil {
            
            let view = RayStatusView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), type: type, location: location) {
                
                block()
            }
            self.statusView = view
            self.addSubview(view)
            self.bringSubviewToFront(view)
        }
    }

    public func dismissErrorView (){
    
        self.statusView?.removeFromSuperview()
    }
}
