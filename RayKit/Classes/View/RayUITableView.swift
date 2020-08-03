//
//  RayUITableView.swift
//  RayKit
//
//  Created by admin on 2020/7/21.
//

import UIKit
import MJRefresh

public class RayUITableView: UITableView {
    
    typealias MyBlock = () -> Void
    var headBlock: MyBlock?
    var footBlock: MyBlock?

    override public init(frame: CGRect, style: UITableView.Style) {

        super.init(frame: frame, style: style)
        self.estimatedRowHeight = 44
        self.rowHeight = UITableView.automaticDimension
        self.backgroundColor = RayBackGroudColor
        self.separatorStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 头部刷新
    public func addHeadView(block: @escaping () -> Void) -> RayUITableView{
        // 下拉刷新
        let header = MJRefreshNormalHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        self.mj_header = header
        self.headBlock = block
        return self
    }
     
    // 脚部刷新
    public func addFootView(block: @escaping () -> Void) -> RayUITableView{
        // 下拉刷新
        let footer = MJRefreshAutoNormalFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        self.mj_footer = footer
        self.footBlock = block
        return self
    }
    
    // 没有数据
    public func showNODataView() {
        // 下拉刷新
        self.showErrorStatus(type: .noData, location: .center) {
            
        }
    }
    // 隐藏
    public func missNODataView() {
        
        self.dismissErrorView()
    }
    
    // 头部刷新
    @objc func headerRefresh() {
       
        if let block = self.headBlock {
            
            block()
        }
    }
    
    // 脚部刷新
    @objc func footerRefresh() {
        
        if let block = self.footBlock {
            
            block()
        }
    }
}
