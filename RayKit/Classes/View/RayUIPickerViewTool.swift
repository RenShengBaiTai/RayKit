//
//  RayUIPickerView.swift
//  RayKit
//
//  Created by admin on 2020/7/30.
//

import UIKit

public class RayUIPickerViewTool: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {

    private var dataArr: Array<Any> = []
    private var seleRow: Int = 0
    
    typealias MyBlock = (_ row: Int) -> Void
    var blockBlock: MyBlock?
    
    public static let manager = RayUIPickerViewTool()
    private override init() {}
    
    var keyWindow = UIApplication.shared.keyWindow
    
    // rootView
    var rootView: UIView?
    var pickRootView: UIView?
    lazy var canBtn: UIButton = {
        
        let btn = UIButton()
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(RayBlackTextColor666, for: .normal)
        btn.addTarget(self, action: #selector(canS), for: .touchUpInside)
        return btn
    }()
    
    lazy var conBtn: UIButton = {
        
        let btn = UIButton()
        btn.setTitle("确定", for: .normal)
        btn.setTitleColor(RayMainColor, for: .normal)
        btn.addTarget(self, action: #selector(conS), for: .touchUpInside)
        return btn
    }()
    
    public func showView(data: Array<Any>, clickClosure: @escaping (_ row: Int) -> Void) {
        
        removeRootView()
        self.dataArr = data
        self.blockBlock = clickClosure
        self.seleRow = 0
        
        let PRview = UIView.init(frame: CGRect.init(x: 0, y: RayScreenHeight, width: RayScreenWidth, height: RayScreenHeight/3))
        PRview.backgroundColor = RayBackGroudColor
        
        PRview.addSubview(self.canBtn)
        self.canBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview()
            make.height.width.equalTo(44)
        }
        
        PRview.addSubview(self.conBtn)
        self.conBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview()
            make.height.width.equalTo(44)
        }
        
        let pickV = UIPickerView()
        pickV.dataSource = self
        pickV.delegate = self
        PRview.addSubview(pickV)
        pickV.snp.makeConstraints { (make) in
            make.top.equalTo(self.conBtn.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        self.showOneAndTwoAlertView(alertView: PRview)
        UIView.animate(withDuration: 0.5) {
            PRview.frame = CGRect.init(x: 0, y: RayScreenHeight/3*2 - RayTabBarBottomHeight(), width: RayScreenWidth, height: RayScreenHeight/3)
        }
        self.pickRootView = PRview
    }
    
    // 显示alertview
    private func showOneAndTwoAlertView(alertView: UIView) {
        
        rootView = UIView()
        
        rootView!.backgroundColor = UIColor.clear
        rootView!.frame = UIScreen.main.bounds
        
        //半透明背景
        let bgBlackView = UIView()
        bgBlackView.backgroundColor = UIColor.black
        bgBlackView.alpha = 0.5
        rootView!.addSubview(bgBlackView)
        
        bgBlackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        rootView!.addSubview(alertView)
        rootView!.bringSubviewToFront(alertView)
        
        keyWindow?.addSubview(rootView!)
        keyWindow?.bringSubviewToFront(rootView!)
    }

    // 删除
    @objc func canS() {
        
        self.removeRootView()
    }
    
    // 确定
    @objc func conS() {
        
        if let block = self.blockBlock {
            
            block(self.seleRow)
        }
        self.removeRootView()
    }
    
    //移除toast
    @objc func removeRootView() {
        
        if rootView == nil {
            return
        }
        
        UIView.animate(withDuration: 0.5, animations: {

            self.pickRootView?.frame = CGRect.init(x: 0, y: RayScreenHeight, width: RayScreenWidth, height: RayScreenHeight/3)
        }) { (is) in
            
            self.rootView?.removeFromSuperview()
            self.rootView = nil
        }
    }
    
    
    // 设置选择框的总列数
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    // 设置选择框的总行数
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.dataArr.count
    }
    
    // 设置选项框各选项的内容
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.dataArr[row] as? String ?? ""
    }
    
    // 选择控件的事件选择
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        seleRow = row
    }

    // 设置每行选项的高度
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 45.0
    }
    
    //修改PickerView选项
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        //修改字体，大小，颜色
        var pickerLabel = view as? UILabel
        if pickerLabel == nil{
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont.RaySystemFont(ofSize: 14)
            pickerLabel?.textAlignment = .center
            pickerLabel?.textColor = RayBlackTextColor333
        }
        pickerLabel?.text = self.dataArr[row] as? String ?? ""
        return pickerLabel ?? UILabel()
    }
}
