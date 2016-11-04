//
//  Constant.swift
//  MapEditor
//
//  Created by Khoa on 10/16/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Foundation
import Cocoa
import AppKit


var quadTreeName = ""
var quadTreeUrl = ""
var listObjectStr = ""
var quadTreeStr  = ""
var globalTiles = [Tile]()


var ROWS = 10
var COLUMNS = 48


var SCREEN_WIDTH = ROWS * 32
var SCREEN_HEIGHT =  COLUMNS * 32
var TILE_SIZE = 32

func convertToStringFrom(_ indexPath : Set<IndexPath>) -> Int{
    var s =  String(describing: indexPath)
    s.characters.removeLast(2)
    s.characters.removeFirst(5)
    
    let value = Int(s)
    return value!

}

func resizeTo(image: NSImage, w: Int, h: Int) -> NSImage {
    let destSize = NSMakeSize(CGFloat(w), CGFloat(h))
    let newImage = NSImage(size: destSize)
    newImage.lockFocus()
    
    let destRect = NSRect(x: 0, y: 0, width: destSize.width, height: destSize.height)
    let fromRect = NSRect(x: 0, y: 0, width:  image.size.width , height: image.size.height)
    image.draw(in: destRect, from: fromRect, operation: .sourceOver, fraction: 1.0)
    
    newImage.unlockFocus()
    newImage.size = destSize
    return NSImage(data: newImage.tiffRepresentation! )!
}



func createOutputImage( ) -> CGImage{
    
    // output image size
    let rect = CGRect(x: 0, y: 0, width: 1538, height: 320)
    
    //  let inputImg = NSImage(named: "47")
    
    let wallImg = NSImage(named: "47")
    
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
    
    let context = CGContext(
        data: nil,
        width: Int(rect.width),
        height: Int(rect.height),
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: bitmapInfo.rawValue)
    
    context?.translateBy(x: 0, y: 288)
    //                          y = Width - tileH
    
    // drawFunc(context: context)
    let temp = CGRect(x: 0, y: 0, width: 32, height: 32)
    
    
    let imageRef  = wallImg?.cgImage(forProposedRect: nil, context: nil, hints: nil)
    
    
    
    context?.draw(imageRef!, in: temp)
    let image = context!.makeImage()
    
    
    return image!
}

func convert2DArrayFrom( arr : [Int], row : Int, column : Int ) -> [[Int]]{
    var outputArr : [[Int]] = [[ row , column  ]]
    var count = 0
    for i in 0..<row{
        
        for j in 0..<column{
//
                outputArr[i][j] = arr[ j*i + j]
          
        }
    }
    return outputArr
}




func createSimpleOutputImage( arr : [Int]) -> CGImage{
    
    // output image size
    let rect = CGRect(x: 0, y: 0, width: 1568, height: 32)
    
    //  let inputImg = NSImage(named: "47")
    
    
    
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
    
    let context = CGContext(
        data: nil,
        width: Int(rect.width),
        height: Int(rect.height),
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: bitmapInfo.rawValue)
    
    context?.translateBy(x: 0, y: 0)
    //                          y = Width - tileH
    
    // drawFunc(context: context)
    
    for i in 0..<arr.count{
        let temp = CGRect(x: i*32, y: 0, width: 32, height: 32)
        let wallImg = NSImage(named: "\(arr[i])")
        let imageRef  = wallImg?.cgImage(forProposedRect: nil, context: nil, hints: nil)
        context?.draw(imageRef!, in: temp)
     //   context?.saveGState()
    
    
    }


    
    
    let image = context!.makeImage()
    
    
    return image!
}



func writeToFile(content: String, fileName: String , url : String) {
    
    let contentToAppend = content+"\n"
    let filePath = String(describing: url)
    
    
//    do {
//        let fileHandle = try FileHandle(forWritingTo: url)
//        fileHandle.seekToEndOfFile()
//        fileHandle.write(contentToAppend.data(using: String.Encoding.utf8)!)
//    catch{
//        
//    }
    
    //Check if file exists
    if let fileHandle = FileHandle(forWritingAtPath: filePath) {
        //Append to file
        fileHandle.seekToEndOfFile()
        fileHandle.write(contentToAppend.data(using: String.Encoding.utf8)!)
    }
    else {
        //Create new file
        do {
            try contentToAppend.write(toFile: filePath, atomically: true, encoding: String.Encoding.ascii)
        } catch {
            print("Error creating \(filePath)")
        }
    }
}




