//
//  TileCollectionViewItem.swift
//  LoadCollection
//
//  Created by Khoa on 10/16/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Cocoa

class TileCollectionViewItem: NSCollectionViewItem {
    @IBOutlet weak var nameLbl: NSTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        // Do view setup here.
    }
    
    func loadTile(urlImg : String){
        
    }
    func changeLbl(str : String){
            self.nameLbl.stringValue = str
    }
}
