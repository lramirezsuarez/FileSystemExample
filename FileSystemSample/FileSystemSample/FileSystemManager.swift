//
//  FileSystemManager.swift
//  FileSystemSample
//
//  Created by Luis Alejandro Ramirez Suarez on 14/01/25.
//


import Foundation

class FileSystemManager {
    
    // Shared instance for singleton usage (optional)
    static let shared = FileSystemManager()
    
    private init() {}
    
    // MARK: - File Operations
    
    // Write data to a file in Documents directory
    func writeToFile(fileName: String, content: String) {
        let fileManager = FileManager.default
        
        if let documentsDirectory = getDocumentsDirectory() {
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            do {
                try content.write(to: fileURL, atomically: true, encoding: .utf8)
                print("File written successfully.")
            } catch {
                print("Error writing file: \(error.localizedDescription)")
            }
        }
    }
    
    // Read data from a file in Documents directory
    func readFromFile(fileName: String) -> String? {
        let fileManager = FileManager.default
        
        if let documentsDirectory = getDocumentsDirectory() {
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            do {
                let fileContent = try String(contentsOf: fileURL, encoding: .utf8)
                return fileContent
            } catch {
                print("Error reading file: \(error.localizedDescription)")
                return nil
            }
        }
        return nil
    }
    
    // List all files in the Documents directory
    func listFilesInDocuments() -> [String] {
        let fileManager = FileManager.default
        var fileNames: [String] = []
        
        if let documentsDirectory = getDocumentsDirectory() {
            do {
                let files = try fileManager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
                fileNames = files.map { $0.lastPathComponent }
            } catch {
                print("Error listing files: \(error.localizedDescription)")
            }
        }
        return fileNames
    }
    
    // Delete a file from the Documents directory
    func deleteFile(fileName: String) {
        let fileManager = FileManager.default
        
        if let documentsDirectory = getDocumentsDirectory() {
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            do {
                try fileManager.removeItem(at: fileURL)
                print("File deleted successfully.")
            } catch {
                print("Error deleting file: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Directory Management
    
    // Get the URL for the Documents directory
    private func getDocumentsDirectory() -> URL? {
        let fileManager = FileManager.default
        do {
            let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
            return urls.first
        } catch {
            print("Error getting Documents directory: \(error.localizedDescription)")
            return nil
        }
    }
    
    // Optionally: Methods to handle Caches and tmp directories
    
    // Get the URL for the Caches directory
    func getCachesDirectory() -> URL? {
        let fileManager = FileManager.default
        do {
            let urls = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
            return urls.first
        } catch {
            print("Error getting Caches directory: \(error.localizedDescription)")
            return nil
        }
    }
    
    // Get the URL for the tmp directory
    func getTemporaryDirectory() -> URL {
        return FileManager.default.temporaryDirectory
    }
}
