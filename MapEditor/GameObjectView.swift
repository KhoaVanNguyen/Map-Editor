//
//  GameObjectView.swift
//  MapEditor
//
//  Created by Khoa on 11/10/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Cocoa

class GameObjectView: NSView {

    
    override func awakeFromNib() {
        
        
        
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        layer?.backgroundColor = CGColor(red: 22/255, green: 67/255, blue: 169/255, alpha: 1.0)
    }
    
}
