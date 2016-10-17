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
