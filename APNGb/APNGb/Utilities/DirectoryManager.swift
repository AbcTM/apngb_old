//
//  DirectoryManager.swift
//  APNGb
//
//  Created by Stefan Godoroja on 12/21/16.
//  Copyright © 2016 Godoroja Stefan. All rights reserved.
//

import Cocoa

/// 文件夹管理器
class DirectoryManager {
    
    static let shared = DirectoryManager()
    
    private init() {}
    
    /// 清理这个工作文件夹
    func cleanupWorkingDirectory(forCommandExecutable executable: CommandExecutable) {
        let directoryUrl = self.workingDirectoryUrl(forCommandExecutable: executable)
        
        if let directoryUrl = directoryUrl {
            _ = FileManager.default.removeItemIfExists(atPath: directoryUrl.path)
        }
    }
    
    /// 移动文件夹
    func moveFiles(forCommandExecutable executable: CommandExecutable,
                   toPath destinationUrl: URL,
                   withNames fileNames: [String],
                   toIgnore ignore: Bool) {
        
        let directoryUrl = self.workingDirectoryUrl(forCommandExecutable: executable)
        
        do {
            let files = try FileManager.default.contentsOfDirectory(at: directoryUrl!,
                                                                    includingPropertiesForKeys: nil,
                                                                    options: .skipsHiddenFiles)
            for fileUrl in files {
                let fileName = fileUrl.lastPathComponent
                let fileExtension = fileUrl.pathExtension
                
                if fileNames.contains(fileName) == ignore && fileExtension != FileExtension.txt {
                    let updatedDestinationUrl = destinationUrl.appendingPathComponent(fileName)
                    try _ = FileManager.default.replaceItemAt(updatedDestinationUrl,
                                                              withItemAt: fileUrl)
                }
            }
            
        } catch let error {
            NSLog("\(#function): \(error)")
        }
    }
    
    /// 拷贝文件夹到工作目录
    func copyFilesInWorkingDirectory(forCommandExecutable executable: CommandExecutable, atPaths sourceUrls: [URL], toPath destinationUrls: [URL]) {
        let bound = sourceUrls.count
        
        for index in stride(from: 0, to: bound, by: 1) {
            copyFile(atPath: sourceUrls[index],
                     toPath: destinationUrls[index])
        }
    }
    
    /// 跟进文件名字创建url
    func createUrlForFile(withName name: String, forCommandExecutable executable: CommandExecutable) -> URL? {
        let workingDirectoryUrl = self.workingDirectoryUrl(forCommandExecutable: executable)
        return workingDirectoryUrl?.appendingPathComponent(name)
    }
    
    /// 工作目录的url
    func workingDirectoryUrl(forCommandExecutable executable: CommandExecutable) -> URL? {
        let temporaryDirectoryUrl = NSURL(fileURLWithPath: NSTemporaryDirectory())
        let mainDirectoryUrl = temporaryDirectoryUrl.appendingPathComponent(Resource.Directory.main)
        var destinationDirectoryUrl: URL? = nil
        
        switch executable {
        case .assembly:
            destinationDirectoryUrl = mainDirectoryUrl?.appendingPathComponent(Resource.Directory.assembly)
        case .disassembly:
            destinationDirectoryUrl = mainDirectoryUrl?.appendingPathComponent(Resource.Directory.disassembly)
        default:
            destinationDirectoryUrl = nil
        }
        
        return destinationDirectoryUrl
    }
    
    /// 创建工作文件夹
    func createWorkingDirectory(forCommandExecutable executable: CommandExecutable) {
        let directoryUrl = self.workingDirectoryUrl(forCommandExecutable: executable)
        
        if let directoryUrl = directoryUrl {
            let directoryWasRemoved = FileManager.default.removeItemIfExists(atPath: directoryUrl.path)
            
            if directoryWasRemoved {
                do {
                    try FileManager.default.createDirectory(at: directoryUrl,
                                                            withIntermediateDirectories: true,
                                                            attributes: nil)
                    #if DEBUG
                        NSWorkspace.shared.open(directoryUrl)
                    #endif
                } catch let error {
                    NSLog("\(#function): \(error)")
                }
            }
        }
    }
    
    // MARK: Private
    /// 拷贝文件到目标路径
    private func copyFile(atPath sourcePath: URL, toPath destinationPath: URL) {
        
        do {
            try FileManager.default.copyItem(atPath: sourcePath.path,
                                             toPath: destinationPath.path)
            
        } catch let error {
            NSLog("\(#function): \(error)")
        }
    }
}
