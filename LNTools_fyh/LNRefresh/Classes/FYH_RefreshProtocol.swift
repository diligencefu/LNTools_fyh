//
//  FYH_RefreshProtocol.swift
//  TestForScrollView
//
//  Created by 付耀辉 on 2020/3/9.
//  Copyright © 2020 信泰集团. All rights reserved.
//

import UIKit
import MJRefresh

public enum FYHRefresh {
    
    public static func addRefreshHeader<T:FYH_RefreshProtocol>(obj:T) {
        weak var obj = obj

        obj?.mainTableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            obj?.pageIndex = 1
            obj?.YHRequestData(with:( obj?.pageIndex ?? 1)) {[weak obj] (datas, allPage) in
                
                obj?.datas = datas
                obj?.mainTableView.mj_footer?.endRefreshing()
                obj?.mainTableView.mj_header?.endRefreshing()
                if allPage <= (obj?.pageIndex ?? 1) {
                    obj?.mainTableView.mj_footer?.endRefreshingWithNoMoreData()
                }else{
                    obj?.mainTableView.mj_footer?.resetNoMoreData()
                }
                
                obj?.mainTableView.reloadData()
            }
        })
        obj?.mainTableView.mj_header?.beginRefreshing()
    }
    
    
    public static func addRefreshFooter<T:FYH_RefreshProtocol>(obj:T) {
        
        weak var obj = obj
        obj?.mainTableView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            obj?.pageIndex += 1
            obj?.YHRequestData(with: (obj?.pageIndex ?? 1)) {(datas, allPage) in
                
                for data in datas {
                    obj?.datas.append(data)
                }
                
                obj?.mainTableView.mj_footer?.endRefreshing()
                obj?.mainTableView.mj_header?.endRefreshing()
                if allPage <= (obj?.pageIndex ?? 1) {
                    obj?.mainTableView.mj_footer?.endRefreshingWithNoMoreData()
                }else{
                    obj?.mainTableView.mj_footer?.resetNoMoreData()
                }
                obj?.mainTableView.reloadData()
            }
        })
    }
    
}



public protocol FYH_RefreshProtocol : NSObject{
    
    associatedtype T
    
    var mainTableView : UITableView {get set}
    var datas:[T] {get set}
    var pageSize : Int {get}
    var pageIndex : Int {get set}

    func YHRequestData(with currentPage:Int,  callBack:@escaping(_ contacts:[T], _ totalPage:Int) -> Void)
}
