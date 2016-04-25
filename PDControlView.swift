//
//  PDControlView.swift
//  weiboSwift1.0
//
//  Created by xuNick on 16/4/23.
//  Copyright © 2016年 NN. All rights reserved.
//

import UIKit

class PDControlView: UIControl {
    
    var action:(() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(activeView)
        self.addSubview(message)
        activeView.center = CGPoint(x: self.frame.width / 2 - activeView.frame.width, y: self.frame.height / 2)
        message.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override internal func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>)
    {
        let view = superview as! UIScrollView
        
        if !view.dragging && view.contentOffset.y < -64 - KPDHeight && !activeView.isAnimating(){
            if view.contentOffset.y < -64 - KPDHeight{
                activeView.startAnimating()
                action!()
                message.text = "正在加载"
                message.sizeToFit()
                view.contentInset.top += KPDHeight
            }
            
            
            
            
        }
        
        if view.dragging && !activeView.isAnimating(){
            if view.contentOffset.y < -64{
                
                if view.contentOffset.y < -64 - KPDHeight{
                    message.text = "松开加载更多"
                    message.sizeToFit()
                }
                if view.contentOffset.y >= -64 - KPDHeight{
                    message.text = "更多"
                    message.sizeToFit()
                }
                
            }
        }
        
    }
    
    lazy var activeView:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    lazy var message:UILabel = {
        let label = UILabel(textColor: UIColor.blackColor(), fontSize: 12)
        label.text = "更多"
        label.sizeToFit()
        return label
    }()
}
