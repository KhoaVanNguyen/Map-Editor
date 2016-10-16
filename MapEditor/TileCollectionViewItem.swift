//
//  TileCollectionViewItem.swift
//  MapEditor
//
//  Created by Khoa on 10/16/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Cocoa

class TileCollectionViewItem: NSCollectionViewItem {
    @IBOutlet weak var tileImage: NSImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
 
    func loadTile(imgUrl : String){
        tileImage.image = NSImage(named: imgUrl)
    }
}
