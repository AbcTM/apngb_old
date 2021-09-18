//
//  Command.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/9/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

/// 使类型将其值重置为初始值。
protocol Reseatable {
    
    func reset()
}

/// 存储 UNIX 可执行文件名称。
enum CommandExecutable: String {
    case none = ""
    /// 生成apng
    case assembly = "apngasm"
    /// 分解apng
    case disassembly = "apngdis"
}

protocol CommandExecutableProtocol {
    
    /// 标识命令关联的可执行文件名称。
    ///
    /// - Returns: UNIX executable name.
    func commandExecutable() -> CommandExecutable
}

/// 指定命令实例的客户端使用的一组方法
/// 获取有关它们的参数或信息。
protocol CommandArgumentable {
    
    /// 检查参数是否已通过验证。
    ///
    /// - Returns: `true` if arguments passed validation, else returns `false`.
    func havePassedValidation() -> Bool
    
    /// 提供命令的参数和附加数据。
    ///
    /// - Returns: Tuple containing a list of arguments and additional data instance.
    func commandArguments() -> ([String], Any?)
}

/// 描述终端命令。
class Command: NSObject {
    
    var name: String
    var arguments: [String]?
    
    /// Custom initializer.
    ///
    /// - Parameter name: Name of UNIX executable.
    init(withExecutable executable: CommandExecutable) {
        self.name = executable.rawValue
    }
}
