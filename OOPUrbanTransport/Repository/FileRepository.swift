//
//  FileRepository.swift
//  OOPUrbanTransport
//
//  Created by Nikola Gerdzhikov on 22.05.19.
//  Copyright © 2019 Nikola Gerdzhikov. All rights reserved.
//

import Cocoa
import RealmSwift

class FileRepository: NSObject {
    
    private static var instance: FileRepository = {
        let networkManager = FileRepository()
        
        return networkManager
    }()

    private override init() {
        super.init()
    }
    
    class func shared() -> FileRepository {
        return instance
    }
    
    func writeToFile(fileName: String) {
        let realm = try! Realm()
        let cars = realm.objects(Car.self)
        let routes = realm.objects(Route.self)
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        try? FileManager.default.removeItem(at: url)
        for car in cars {
            do {
                try car.description.appendLineToURL(fileURL: url as URL)
                
            }
            catch {
                print("Could not write to file")
            }
        }
        
        try? "\n".appendLineToURL(fileURL: url as URL)
        for route in routes {
            do {
                try route.description.appendLineToURL(fileURL: url as URL)
            }
            catch {
                print("Could not write to file")
            }
        }
        
    }
    
    func readFromFile(fileName: String) {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        do {
            let result = try String(contentsOf: url as URL, encoding: String.Encoding.utf8)
            print(result)
        } catch {
            print(error)
        }
    }
    
}

extension String {
    func appendLineToURL(fileURL: URL) throws {
        try (self + "\n").appendToURL(fileURL: fileURL)
    }
    
    func appendToURL(fileURL: URL) throws {
        let data = self.data(using: String.Encoding.utf8)!
        try data.append(fileURL: fileURL)
    }
}

extension Data {
    func append(fileURL: URL) throws {
        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        }
        else {
            try write(to: fileURL, options: .atomic)
        }
    }
}

