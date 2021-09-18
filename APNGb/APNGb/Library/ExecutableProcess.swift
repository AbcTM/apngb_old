//
//  ExecutableProcess.swift
//  APNGb
//
//  Created by Stefan Godoroja on 10/9/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

/// 可执行程序的抽象工厂
struct ExecutableProcessFactory {
    
    /// 创建一个可执行的进程
    /// - Parameters:
    ///   - executable: 类型
    ///   - command: 命令
    ///   - additionalData: 附加数据
    /// - Returns: 返回可执行的进程
    static func createProcess(identifiedBy executable: CommandExecutable,
                               and command: Command,
                               withData additionalData: Any?) -> ExecutableProcess? {
        switch executable {
        case .assembly:
            return AssemblyProcess(withCommand: command, andAdditionalData: additionalData)
        case .disassembly:
            return DisassemblyProcess(withCommand: command)
        default:
            return nil
        }
    }
}

/// 可执行的进程
class ExecutableProcess: NSObject {
    /// 初始化完成回调
    var initialHandler: VoidHandler?
    /// 执行进度回调
    var progressHandler: ((String) -> ())?
    /// 中断回调
    var terminationHandler: VoidHandler?
    /// 是否被取消
    var cancelled = false
    
    /// 文件处理
    private var fileHandle: FileHandle
    /// 创建一个任务进程
    private var task = Process()
    
    // MARK: -- init
    init(withCommand command: Command,
         andAdditionalData additionalData: Any? = nil)  {

        
        let outputPipe = Pipe()
        task.standardOutput = outputPipe
        fileHandle = outputPipe.fileHandleForReading
        fileHandle.waitForDataInBackgroundAndNotify()
        super.init()
        
        task.launchPath = Bundle.main.path(forResource: command.name, ofType: nil)
        task.arguments = command.arguments
        task.terminationHandler = { process in
            if let handler = self.terminationHandler {
                DispatchQueue.main.async(execute: {
                    handler()
                })
            }
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(receivedData(notification:)),
                                               name: NSNotification.Name.NSFileHandleDataAvailable,
                                               object: nil)
    }
    
    func start() {
        /// 若需要初始化完成回调，则回调
        if let handler = self.initialHandler {
            handler()
        }
        
        task.launch()
    }
    
    func stop() {
        task.terminate()
    }
    
    func cleanup() {
        assertionFailure("\(#function) must be implemented in subclass")
    }
    
    func didFinishedWithSuccess(success: Bool, url: URL?) {
        assertionFailure("\(#function) must be implemented in subclass")
    }
    
    // MARK: - Private
    
    @objc private func receivedData(notification : NSNotification) {
        let data = fileHandle.availableData
        
        if data.count > 0 {
            fileHandle.waitForDataInBackgroundAndNotify()
            let outputString = String(data: data,
                                      encoding: String.Encoding.ascii)
            
            if let outputString = outputString {
                self.progressHandler?(outputString)
            }
        }
    }
}

