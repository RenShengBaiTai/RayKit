//
//  RayAlertTool.swift
//  contract
//
//  Created by admin on 2020/5/18.
//  Copyright © 2020 hjdj. All rights reserved.
//

import UIKit
import SnapKit

public enum toastPlace {
    case toastTop
    case toastCenter
    case toastBottom
    
    var y: CGFloat {
        switch self {
        case .toastTop:
            return RayScreenHeight / 2
        case .toastCenter:
            return RayScreenHeight / 2
        case .toastBottom:
            return 3 * RayScreenHeight / 4
        }
    }
}

public class RayAlertTool: NSObject {

    public static let alertManager = RayAlertTool()
       
    private override init() {}
    
    var keyWindow = UIApplication.shared.keyWindow
    let rv = UIApplication.shared.keyWindow?.subviews.first as UIView?
    
    //toast
    var toastBottomView: UIView?
    
    //弹窗
    var alartBottomView: UIView?
    
    //toast
    public func showToast(content: String, place: toastPlace = .toastBottom, duration:CFTimeInterval=1.5) {
        
        removeToastBottomView()
        let attributes = [NSAttributedString.Key.font: UIFont.RaySystemFont(ofSize: 14)]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let contentLength = content.boundingRect(with: CGSize(width: 1000, height: 36), options: option, attributes: attributes, context: nil).size.width

        var frame = CGRect(x: 0, y: 0, width: RayScreenWidth - 20, height: 36)
        if contentLength + 30 < RayScreenWidth - 20 {
           frame = CGRect(x: 0, y: 0, width: contentLength + 30, height: 36)
        }

        let toastContainerView = UIView()
        toastContainerView.layer.cornerRadius = 10
        toastContainerView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.7)

        let toastContentView = UILabel(frame: frame)
        toastContentView.font = UIFont.RaySystemFont(ofSize: 13)
        toastContentView.textColor = UIColor.white
        toastContentView.text = content
        toastContentView.numberOfLines = 0
        toastContentView.textAlignment = .center
        toastContainerView.addSubview(toastContentView)

        toastBottomView = UIView()
        toastBottomView!.backgroundColor = UIColor.clear
        toastBottomView!.frame = frame
        toastContainerView.frame = frame
        toastBottomView?.center = CGPoint(x: rv?.center.x ?? RayScreenWidth / 2, y: place.y)

        toastBottomView!.addSubview(toastContainerView)
        keyWindow?.addSubview(toastBottomView!)
        keyWindow?.bringSubviewToFront(toastBottomView!)

        toastContainerView.layer.add(RayAlertViewAnimationTool.getToastAnimation(duration: duration), forKey: "animation")

        perform(#selector(removeToastBottomView), with: nil, afterDelay: duration)
    }
    
    // 普通的alert
    public func showAlertView(title: String, content: String, left: String?, right: String, clickClosure: @escaping (_ direction: Bool) -> Void) {
        
        self.showAlertView(title: title, content: NSAttributedString(string: content), left: left, right: right, clickClosure: clickClosure)
    }
    
    public func showAlertView(title: String, content: NSAttributedString, left: String?, right: String, clickClosure: @escaping (_ direction: Bool) -> Void) {
        
        self.removeBottomView()
        
        if left == nil || left?.count == 0{
            
            let alertView = PDLSingleAlertView.init(title: title, message: content, buttonText:right, clickClosure: { () in
                
                    self.removeBottomView()
                    clickClosure(true)
            })
            self.showOneAndTwoAlertView(alertView: alertView)
            alertView.show()
        }else{
            
            let type: PDLAlertType = content.string.count == 0 ? .oneType : .none
            let alertView = PDLAlertView.init(title: title, message: content, leftText: left ?? "取消", rightText: right, type: type, clickClosure: { (direction) in
                
                     self.removeBottomView()
                     clickClosure(direction)
             })
            
            self.showOneAndTwoAlertView(alertView: alertView)
            alertView.show()
        }
    }
    
    // 升级alert
    public func showUpAPPAlertView(content: String, right: String, isShowCancel: Bool, clickClosure: @escaping () -> Void) {
        
        self.removeBottomView()
        let alertView = RayUpAPPAlertView.init(message: content, rightText:right, isShowCancel: isShowCancel, clickClosure: { (direction) in
            
            if direction == false {
                clickClosure()
            }
            self.removeBottomView()
        })
        self.showOneAndTwoAlertView(alertView: alertView)
        alertView.show()
    }
    
    // 带有输入框的alert
    public func showTFAlertView(title: String, content: String, left: String, right: String, clickClosure: @escaping (_ direction: Bool, _ text: String) -> Void) {
        
        self.removeBottomView()
        
        let alertView = RayTFAlertView.init(title: title, message: content, leftText: left, rightText: right, clickClosure: { (isL, text) in
            
            self.removeBottomView()
            clickClosure(isL, text)
        })
        
        self.showOneAndTwoAlertView(alertView: alertView)
        alertView.show()
    }
    
    // copyalert
    public func showCopyAlertView(title: String, content: String, right: String, clickClosure: @escaping () -> Void) {
        
        self.removeBottomView()
        
        let alertView = RayCopyAlertView.init(title: title, message: content, rightText: right, clickClosure: { () in
            
            self.removeBottomView()
            clickClosure()
        })
        
        self.showOneAndTwoAlertView(alertView: alertView)
        alertView.show()
    }
    
    // 显示alertview
    private func showOneAndTwoAlertView(alertView: UIView) {
        
        alartBottomView = UIView()
        
        alartBottomView!.backgroundColor = UIColor.clear
        alartBottomView!.frame = UIScreen.main.bounds
        
        //半透明背景
        let bgBlackView = UIView()
        bgBlackView.backgroundColor = UIColor.black
        bgBlackView.alpha = 0.5
        alartBottomView!.addSubview(bgBlackView)
        
        bgBlackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        alartBottomView!.addSubview(alertView)
        alartBottomView!.bringSubviewToFront(alertView)
        
        keyWindow?.addSubview(alartBottomView!)
        keyWindow?.bringSubviewToFront(alartBottomView!)
    }
    
    //移除当前弹窗
    func removeBottomView() {
        alartBottomView?.removeFromSuperview()
        alartBottomView = nil
    }
    
    //移除toast
    @objc func removeToastBottomView() {
        toastBottomView?.removeFromSuperview()
        toastBottomView = nil
    }
}

