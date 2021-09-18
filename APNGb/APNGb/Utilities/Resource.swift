//
//  Resource.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/20/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

struct Resource {
    /// 文字提示
    struct String {
        static let dropAnimatedImageHere = "Drop animated image here"
        static let dropFramesHere = "Drop frames here"
        static let selectFolderToSaveFrames = "Select directory where animated frames will be saved"
        static let selectFolderToSaveAnimatedImage = "Select directory where animated image will be saved"
        static let defaultToolbarLoggingMessage = "Idle..."
        static let size = "Size"
        static let delay = "Delay"
    }
    
    /// 文件名
    struct Directory {
        static let main = "APNGb"
        static let assembly = "Assembly"
        static let disassembly = "Disassembly"
    }
    
}
