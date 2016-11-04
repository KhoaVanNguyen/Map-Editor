//
//  QuadTreeFile.swift
//  MapEditor
//
//  Created by Khoa on 11/4/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Foundation


class QuadTreeFile{
    
    var firstLine : String // ex: 9 1536 320
    var listTile : [Tile]
    var quadTreeStr : String
    
    
    init(firstLine : String, listTile : [Tile], quadTreeStr : String) {
        self.firstLine = firstLine
        self.listTile = listTile
        self.quadTreeStr = quadTreeStr
    }
}
