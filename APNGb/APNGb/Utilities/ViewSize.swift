//
//  ViewSize.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/10/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

/// 保留应用程序中所有视图的尺寸值。
struct ViewSize {
    
    static let windowHeight: CGFloat = 475.0
    static let windowWidth: CGFloat = 695.0
    static let splitViewSeparatorWidth: CGFloat = 1.0
}

extension ViewSize {
    
    /// 存储侧栏视图尺寸属性。
    struct SideBar {
        
        static let width: CGFloat = 50.0
    }
}

extension ViewSize {
    
    /// 存储子容器视图维度属性。
    struct ChildContainer {
        
        static let width: CGFloat = 425.0
    }
}

extension ViewSize {
    
    /// 存储首选项视图维度属性。
    struct Preferences {
        
        static let width: CGFloat = 200.0
    }
}
