//
//  RayCheckBtnViewController.swift
//  Alamofire
//
//  Created by admin on 2020/5/20.
//

import UIKit

public class RayCheckBtnViewController: UIViewController, UIScrollViewDelegate{
    
    var titleSize: CGFloat = 15
    var index: Int = 0
    var nameArr: Array<String> = []
    var vcArr: Array<UIViewController> = []
    var btnArr: NSMutableArray = []
    
    lazy var rootScrollView: UIScrollView = {
        
        let scrolV = UIScrollView.init(frame: CGRect.init(x: 0, y: 44, width: RayScreenWidth, height: self.view.frame.size.height))
        scrolV.isPagingEnabled = true
        scrolV.delegate = self
        scrolV.backgroundColor = UIColor.white;
        return scrolV
    }()
    
    lazy var btnView: UIView = {
        
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width:RayScreenWidth , height: 44))
        view.backgroundColor = UIColor.white
        return view
    }()

    lazy var lineView: UIView = {
        
        let view = UIView.init(frame: CGRect.init(x: 0, y: 42, width: 80, height: 2))
        view.backgroundColor = RayMainColor
        return view
    }()
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    public func initData(_ nameArr: Array<String>, _ vcArr: Array<UIViewController>, _ index: Int) {

        self.nameArr = nameArr
        self.vcArr = vcArr
        self.index = index
        self.initView()
    }
    
    func initView(){
        
        self.view.backgroundColor = UIColor.red
        self.initBtnView()
        self.view.addSubview(self.rootScrollView)
        self.chengeViewWithPage(self.index)
    }
    
    func initBtnView() {

        self.view.addSubview(self.btnView)
        let w = RayScreenWidth / CGFloat(self.nameArr.count)
        for idx in 0...(self.nameArr.count - 1) {
            
            let obj = self.nameArr[idx]
            let btn = UIButton.init(frame: CGRect.init(x: w * CGFloat(idx), y: 0, width: w, height: 43))
            btn.setTitle(obj, for: .normal)
            btn.setTitleColor(RayMainColor, for: .selected)
            btn.setTitleColor(RayBlackTextColor999, for: .normal)
            btn.titleLabel?.font = UIFont.RaySystemFont(ofSize: self.titleSize)
            btn.tag = idx;
            if (idx == 0){
                
                btn.isSelected = true;
            }
            btn.addTarget(self, action: #selector(selectMethod), for: .touchUpInside)
            self.btnView.addSubview(btn)
            self.btnArr.add(btn)
        }
        
        self.lineView.center.x = w / 2
        self.btnView.addSubview(self.lineView)
    }
    
    @objc func selectMethod(_ btn: UIButton){
        
        let index = btn.tag
        self.chengeViewWithPage(index)
    }
    
    func chengeViewWithPage(_ index: Int){
        
        for obj in self.btnArr {
            
            let btn: UIButton = obj as! UIButton
            btn.isSelected = false
        }

        let seleBtn: UIButton = self.btnArr[index] as! UIButton
        seleBtn.isSelected = true
        let w = RayScreenWidth / CGFloat(self.nameArr.count)
        UIView.animate(withDuration: 0.2) {
            
            self.lineView.center.x = w * CGFloat(index) + w/2;
        }
        self.rootScrollView.setContentOffset(CGPoint.init(x: Int(RayScreenWidth) * index, y: 0), animated: true)
        
        let vc: UIViewController = self.vcArr[index]
        
//        if (_HTHCBSelectM) {
//
//            _HTHCBSelectM(page);
//        }
        
        if(vc.view.tag == 100 + index) {
            
            return
        }
        
        vc.view.frame = CGRect.init(x: RayScreenWidth * CGFloat(index), y: 0, width: self.rootScrollView.frame.size.width, height: self.rootScrollView.frame.size.height)
        vc.view.tag = 100 + index
        self.addChild(vc)
        self.rootScrollView.addSubview(vc.view)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let index = scrollView.contentOffset.x / RayScreenWidth
        self.chengeViewWithPage(Int(index))
    }
}
