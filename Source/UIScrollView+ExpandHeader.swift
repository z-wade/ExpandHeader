//
//  UIScrollView+ExpandHeader.swift
//  ExpandHeader
//
//  Created by cjz on 2018/11/29.
//  Copyright © 2018 CJZ. All rights reserved.
//

import UIKit

public extension UIScrollView {
    
    static var expandHeaderKey: String = "expandHeaderKey"
    static var expandHeaderHeightKey: String = "expandHeaderHeightKey"
    
    //MARK: - Var
    public var expandHeaderView: UIView? {
        set {
            if let view = newValue {
                add(expandView: view)
            } else {
                if let oldView = objc_getAssociatedObject(self, &UIScrollView.expandHeaderKey) as? UIView {
                    oldView.removeFromSuperview()
                }
            }
            objc_setAssociatedObject(self, &UIScrollView.expandHeaderKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(self, &UIScrollView.expandHeaderKey) as? UIView
        }
    }
    
    private var expandViewHeight: CGFloat {
        set {
            objc_setAssociatedObject(self, &UIScrollView.expandHeaderHeightKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            if let height = objc_getAssociatedObject(self, &UIScrollView.expandHeaderHeightKey) {
                return height as! CGFloat
            }
            return 0
        }
    }
    
    //MARK: - Public Method
    private func add(expandView: UIView) {
        expandViewHeight = expandView.frame.height
        contentInset = UIEdgeInsets(top: expandViewHeight, left: 0, bottom: 0, right: 0)
        setContentOffset(CGPoint(x: 0, y: -expandViewHeight), animated: true)
        
        expandView.frame = CGRect(x: 0, y: -expandViewHeight, width: frame.width, height: expandViewHeight)
        expandView.contentMode = .scaleAspectFill
        expandView.clipsToBounds = true
        insertSubview(expandView, at: 0)
        
        //自身添加监听不会retain对象，当对象release后，监听链也不存在了，所以不removeObserver也不会造成问题
        addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset" {
            if contentOffset.y < expandViewHeight * -1 {
                expandHeaderView?.frame = CGRect(x: 0, y: contentOffset.y, width:frame.width , height:-contentOffset.y)
            }
        }
    }
    
}
