//
//  Argument.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/24/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

/// appng 执行的参数
struct Argument {
    
    /// 设置循环次数
    static let numberOfLoops = "-l"
    
    /// 跳过第一帧
    static let skipFirstFrame = "-f"
    
    
    static let enablePalette = "-kp"
    
    
    static let enableColorType = "-kc"
    
    /// 压缩使用zlib
    static let enableZlib = "-z0"
    
    /// 压缩使用7zip
    static let enable7zip = "-z1"
    
    /// 压缩使用zop file
    static let enableZopfli = "-z2"
    
    
    static let iteration = "-i"
    
    
    static let horizontalStrip = "-hs"
    
    
    static let verticalStrip = "-vs"
}
