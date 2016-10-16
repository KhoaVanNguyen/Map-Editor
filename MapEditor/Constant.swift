//
//  Constant.swift
//  MapEditor
//
//  Created by Khoa on 10/16/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Foundation


func convertToStringFrom(indexPath : Set<IndexPath>) -> Int{
    var s =  String(describing: indexPath)
    s.characters.removeLast(2)
    s.characters.removeFirst(5)
    
    let value = Int(s)
    return value!

}
