//
//  RayScanTool.swift
//  contract
//
//  Created by admin on 2020/7/30.
//  Copyright © 2020 hjdj. All rights reserved.
//
import UIKit

public class RayScanTool: LBXScanViewController {

    public typealias blockType = (_ str: String)->Void
    public var backBlock: blockType?
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "二维码/条码"
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.tintColor = UIColor.white
        
        //扫描动画：在github下载项目，复制CodeScan.bundle获取图片
        var style = LBXScanViewStyle()
        style.anmiationStyle = .NetGrid
        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_part_net")//引用bundle中的图片
        scanStyle = style
    }
    
    public override func handleCodeResult(arrayResult: [LBXScanResult]) {
        if let result = arrayResult.first {
            let msg = result.strScanned
            
            RayAlertTool.alertManager.showAlertView(title: "温馨提示", content: "扫描结果:" + msg!, left: nil, right: "确定") { [weak self] (b) in
             
                if let block = self?.backBlock {
                    
                    block(msg!)
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
}
