//
//  CustomView.swift
//  LoadCollection
//
//  Created by Khoa on 10/15/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Cocoa
import AppKit
class MapItemView: NSView {
    @IBOutlet weak var tileImg: NSImageView!

    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        

        // Drawing code here.
    }
    
    func changeTileImg(){
        tileImg.image = NSImage(named: "heart_icon_round")
        
    }
}
