//
//  UITavleView+Extension.swift
//  weiboSwift1.0
//
//  Created by xuNick on 16/4/23.
//  Copyright © 2016年 NN. All rights reserved.
//

import UIKit

let KPDHeight:CGFloat = 60

let KPDContentOffsetY = "contentOffset"

let KPDtag:Int = 521

extension UITableView {
    
    var PDControl:PDControlView {
        return self.viewWithTag(KPDtag) as! PDControlView
    }
    
    
    
    
    
    
    //MARK: -  对外接口
    /**
    *  UITableView 以及 其子类 使用该方法添加一个具有下拉刷新功能的PDControl 到自己的顶部
    *  下拉后自动开启刷新指示器
    */
    public func PD_addPDControll(action:() -> ()){
        
        let PDView = PDControlView(frame: CGRect(x: 0, y: -KPDHeight, width: self.frame.width, height: KPDHeight))
        
        PDView.tag = KPDtag
        PDView.action = action
        PDView.backgroundColor = UIColor.cyanColor()
        self.addSubview(PDView)
        
        //kvo PDControl监听自己的contentOffSize
        self.addObserver(self.PDControl, forKeyPath: KPDContentOffsetY, options: [.New], context: nil)
    }
    /**
    *  手动关闭刷新指示器方法
    */
    func PD_endRefreshing(){
        if !self.PDControl.activeView.isAnimating(){
            return
        }
        self.PDControl.activeView.stopAnimating()
        self.contentInset.top -= KPDHeight
    }
    /**
    *  更改下拉动画
    */
     //TODO:
    /**
    *  更改提示文字
    */
     //TODO:
    /**
    *  更改下拉显示的图片
    */
    //TODO: 
    
    
        
    
}