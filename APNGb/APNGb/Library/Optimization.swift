//
//  Optimization.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/14/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

/// 优化参数
final class Optimization: NSObject, CommandArgumentable {
    
    var enablePalette = true
    var enableColorType = true
    
    // MARK: - CommandArgumentable
    
    func havePassedValidation() -> Bool {
        return true
    }
    
    func commandArguments() -> ([String], Any?) {
        var arguments: [String] = []
        
        if enablePalette == true {
            arguments.append(Argument.enablePalette)
        }
        
        if enableColorType == true {
            arguments.append(Argument.enableColorType)
        }
        
        return (arguments, nil)
    }
    
}
