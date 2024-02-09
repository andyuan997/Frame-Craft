//
//  ContentView.swift
//  Frame Craft
//
//  Created by 袁維謙 on 2024/2/9.
//


import SwiftUI
import AppKit

struct ContentView: View {
    @State private var combinedImage: NSImage?
    @State private var isImageDropped = false
    var selectedOption1080x2340: String
    var selectedOption1125x2436: String
    var selectedOption1170x2532: String
    var selectedOption1179x2556: String
    var selectedOption1242x2688: String
    var selectedOption1284x2778: String
    var selectedOption1290x2796: String

    var body: some View {
        VStack {
            Text("Drag and drop an image here.")
                .font(.headline)
            
            if let combinedImage = combinedImage {
                Image(nsImage: combinedImage)
                    .resizable()
                    .scaledToFit()
            } else {
                Text(isImageDropped ? "Image Processing..." : "Wait for the picture to drag and drop here...")
            }
        }
        .frame(width: 400, height: 300)
        //.border(Color.gray, width: 1)
        .onDrop(of: ["public.file-url"], isTargeted: nil) { providers in
            isImageDropped = true // Immediately acknowledge the drop
            loadDroppedImage(from: providers.first)
            return true
        }
    }

    private func loadDroppedImage(from provider: NSItemProvider?) {
        // 使用 _ 故意忽略返回的 NSProgress 對象
        _ = provider?.loadObject(ofClass: URL.self) { url, error in
            // 錯誤處理
            if let error = error {
                print("Error loading file: \(error.localizedDescription)")
                return
            }
            guard let imageUrl = url else {
                print("Invalid URL for dropped item.")
                return
            }
            guard let userImage = NSImage(contentsOf: imageUrl) else {
                print("Unable to create NSImage from URL: \(imageUrl)")
                return
            }
            
            
            
            DispatchQueue.main.async {
                // 假如以設置 Assets.xcassets 且有圖片
                
                var screenshotframe = ""
                switch userImage.size {
                case CGSize(width: 1080, height: 2340), CGSize(width: 2340, height: 1080):
                    screenshotframe = self.selectedOption1080x2340
                case CGSize(width: 1125, height: 2436), CGSize(width: 2436, height: 1125):
                    screenshotframe = self.selectedOption1125x2436
                case CGSize(width: 1170, height: 2532), CGSize(width: 2532, height: 1170):
                    screenshotframe = self.selectedOption1170x2532
                case CGSize(width: 1179, height: 2556), CGSize(width: 2556, height: 1179):
                    screenshotframe = self.selectedOption1179x2556
                case CGSize(width: 1242, height: 2688), CGSize(width: 2688, height: 1242):
                    screenshotframe = self.selectedOption1242x2688
                case CGSize(width: 1284, height: 2778), CGSize(width: 2778, height: 1284):
                    screenshotframe = self.selectedOption1284x2778
                case CGSize(width: 1290, height: 2796), CGSize(width: 2796, height: 1290):
                    screenshotframe = self.selectedOption1290x2796
                default:
                    let alert = NSAlert()
                    alert.messageText = "Size Error"
                    alert.informativeText = "The size of the image is not supported."
                    alert.alertStyle = .warning
                    alert.addButton(withTitle: "OK")
                    alert.runModal()
                    return
                }
                
                
                guard let frameImage = userImage.size.width < userImage.size.height ? NSImage(named: "\(screenshotframe) - Portrait") : NSImage(named: "\(screenshotframe) - Landscape") else {
                    print("Failed to load iPhone frame image.")
                    return
                }
                self.combinedImage = combineImages(frame: frameImage, screenshot: userImage)
                
                //以日期命名
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyyMMddHHmmss"
                let dateString = dateFormatter.string(from: Date())
                let fileName = "FrameShot_\(dateString).png"
                
                saveImage(self.combinedImage!, to: "SavedImages", with: fileName)
            }
        }
    }

    private func combineImages(frame: NSImage, screenshot: NSImage) -> NSImage {
        guard let frameCGImage = frame.cgImage(forProposedRect: nil, context: nil, hints: nil),
              let screenshotCGImage = screenshot.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
            print("Unable to convert NSImage to CGImage.")
            return NSImage()
        }
        
        let frameSize = CGSize(width: frameCGImage.width, height: frameCGImage.height)
        print("iphone frame size：",frameSize)
        let screenshotSize = CGSize(width: screenshotCGImage.width, height: screenshotCGImage.height)
        print("input image size：",screenshotSize)
        
        let newImage = NSImage(size: frameSize)
        newImage.lockFocus()
        
        
        // 繪製iphone框架(作為圖像大小)
        NSGraphicsContext.current?.cgContext.draw(frameCGImage, in: CGRect(origin: .zero, size: frameSize))
        
        // 計算置中
        let targetX = (frameSize.width - screenshotSize.width) / 2
        let targetY = (frameSize.height - screenshotSize.height) / 2
        
        // 輸入圖切圓角
        let screenshotRect = CGRect(x: targetX, y: targetY, width: CGFloat(screenshotCGImage.width), height: CGFloat(screenshotCGImage.height))
        let cornerRadius: CGFloat = 100 // 圓角半徑
        let screenshotPath = CGPath(roundedRect: screenshotRect, cornerWidth: cornerRadius, cornerHeight: cornerRadius, transform: nil)
        
        // 圓角
        NSGraphicsContext.current?.cgContext.addPath(screenshotPath)
        NSGraphicsContext.current?.cgContext.clip()
            
        NSGraphicsContext.current?.cgContext.draw(screenshotCGImage, in: screenshotRect)
        
        // 繪製iphone框架(蓋上)
        NSGraphicsContext.current?.cgContext.draw(frameCGImage, in: CGRect(origin: .zero, size: frameSize))

        newImage.unlockFocus()
        return newImage
    }


    
    func saveImage(_ image: NSImage, to directory: String, with name: String) {
        guard let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
            print("Failed to get CGImage from NSImage.")
            return
        }
        
        let bitmapRep = NSBitmapImageRep(cgImage: cgImage)
        guard let pngData = bitmapRep.representation(using: .png, properties: [:]) else {
            print("Failed to get PNG representation of NSImage.")
            return
        }
        
        let fileManager = FileManager.default
        guard let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Failed to find the documents directory.")
            return
        }
        
        let fileURL = directoryURL
            .appendingPathComponent(directory, isDirectory: true)
            .appendingPathComponent(name)
        
        do {
            try fileManager.createDirectory(at: fileURL.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
            try pngData.write(to: fileURL)
            print("Image was saved successfully to: \(fileURL.path)")
            
            // 打開finder 選中文件
            NSWorkspace.shared.selectFile(fileURL.path, inFileViewerRootedAtPath: directoryURL.path)
        } catch {
            print("Failed to save image to disk: \(error)")
        }
    }


}


