//
//  ContentView.swift
//  FileSystemSample
//
//  Created by Luis Alejandro Ramirez Suarez on 14/01/25.
//

import SwiftUI

struct ContentView: View {
	
	// The filename to be used for our example file
	let fileName = "exampleFile.txt"
	
	@State private var fileContent: String = ""
	@State private var fileList: [String] = []
	
	var body: some View {
		VStack {
			Text("File System Example")
				.font(.largeTitle)
				.padding()
			
			Button(action: writeToFile) {
				Text("Write to File")
			}
			.padding()
			
			Button(action: readFromFile) {
				Text("Read from File")
			}
			.padding()
			
			Button(action: listFiles) {
				Text("List Files in Documents")
			}
			.padding()
			
			Button(action: deleteFile) {
				Text("Delete File")
			}
			.padding()
			
			// Display content from the file
			if !fileContent.isEmpty {
				Text("File Content: \(fileContent)")
					.padding()
			}
			
			// Display list of files
			if !fileList.isEmpty {
				VStack(alignment: .leading) {
					Text("Files in Documents:")
					ForEach(fileList, id: \.self) { file in
						Text(file)
					}
				}
				.padding()
			}
		}
		.padding()
	}
	
	func writeToFile() {
		let content = "Hello, this is a test file content!"
		FileSystemManager.shared.writeToFile(fileName: fileName, content: content)
	}
	
	func readFromFile() {
		if let content = FileSystemManager.shared.readFromFile(fileName: fileName) {
			fileContent = content
		}
	}
	
	func listFiles() {
		fileList = FileSystemManager.shared.listFilesInDocuments()
	}
	
	func deleteFile() {
		FileSystemManager.shared.deleteFile(fileName: fileName)
		fileContent = "" // Clear the file content from the UI
		fileList = FileSystemManager.shared.listFilesInDocuments() // Update file list
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}


#Preview {
    ContentView()
}
