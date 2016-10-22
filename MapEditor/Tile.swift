//
//  Tile.swift
//  LoadCollection
//
//  Created by Khoa on 10/15/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Foundation
import Cocoa
import AppKit

class Tile {
    var imageUrl : String
    var index : Int
    var id : Int
    var x : Int
    var y : Int
    var width : Int
    var height : Int
    
    init( url : String, index : Int, id : Int, x : Int, y : Int , width : Int, height : Int ) {
        self.imageUrl = url
        self.index = index
        self.id = id
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
}
