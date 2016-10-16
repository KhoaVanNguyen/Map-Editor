//
//  TileItemView.swift
//  LoadCollection
//
//  Created by Khoa on 10/16/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Cocoa

class TileItemView: NSView {

    @IBOutlet weak var tileImage: NSImageView!
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    func loadImage(str : String){
        tileImage.image = NSImage(named: str)
    }
}
