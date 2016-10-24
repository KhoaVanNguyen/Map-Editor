//
//  ViewController.swift
//  LoadCollection
//
//  Created by Khoa on 10/15/16.
//  Copyright © 2016 Khoa. All rights reserved.
//

import Cocoa
import ImageIO
import AppKit
class ViewController: NSViewController, NSCollectionViewDataSource , NSCollectionViewDelegate{
    
    @IBOutlet weak var mapCollectionView: NSCollectionView!
    
    @IBOutlet weak var tileCollectionView: NSCollectionView!
   
    var currentTileID = 0;

    var exportedImage = NSImage()
    
    var listTiles = [Tile]()
    var cursor = NSCursor()
    let tileSet = [0,1,2,3,4,5,6,7,8,9,10,11,12,12,14,15,16,17,18,19,20,
                      21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,
                     40,41,42,43,44,45,46,47,48]
    var trackArray = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMapCollectionView()
        configureTileCollectionView()
        
        initTrackArray()
        
        
        
        mapCollectionView.delegate = self
        mapCollectionView.dataSource = self
        
        tileCollectionView.delegate = self
        tileCollectionView.dataSource = self
        
        changeCursorImge(index: "\(currentTileID)")
       
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
   

    // MARK: NSCOLLECTION SETTINGS
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        if collectionView == self.mapCollectionView{
            return 1
        }
        else{
            return 1
        
        }
    }
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.mapCollectionView{
            return 480
        }
        else{
            return tileSet.count
        }
    }
    

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
       
        if ( collectionView == self.mapCollectionView  ){
        let item = collectionView.makeItem(withIdentifier: "CollectionViewItem", for: indexPath) as! CollectionViewItem
        return item
        }
        else {
            let item = collectionView.makeItem(withIdentifier: "TileCollectionViewItem", for: indexPath) as! TileCollectionViewItem
           item.loadTile("\(tileSet[indexPath.item])")
            
            print("\(tileSet[indexPath.item])")
            return item
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        if collectionView == self.mapCollectionView{
            let index = convertToStringFrom(indexPaths)
            let item = collectionView.item(at: index) as! CollectionViewItem
            item.changeImage("\(currentTileID)")
            
            // track 
            
            trackArray[index] = currentTileID
            let row = index / 48 // 48 == col
            let col = index - (row * 48)
            print(" index = \(index) at: [\(row),\(col)] ")
            
            
            // Add to tile list
            let x = col * 32
            let y = row * 32
            let tile = Tile(url:  "\(currentTileID)", index: index, id: currentTileID, x: x, y: y, width: 32, height: 32)
            listTiles[index] = tile
           // changeCursorImge(index: "\(currentTileID)")
        }
        else{
            
            let index = convertToStringFrom(indexPaths)
            currentTileID = index
            
            changeCursorImge(index: "\(index)")
           
        }
    }
    
    // MARK: CONFIGURE COLLECTIONS
    private func configureMapCollectionView() {
        
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 32.0, height: 32.0)
        // flowLayout.sectionInset = EdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.minimumLineSpacing = 1
        mapCollectionView.collectionViewLayout = flowLayout
        
        view.wantsLayer = true
        
        mapCollectionView.layer?.backgroundColor = NSColor.black.cgColor
        mapCollectionView.isSelectable = true
    }
    private func configureTileCollectionView() {
        
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 32.0, height: 32.0)
        // flowLayout.sectionInset = EdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.minimumLineSpacing = 1
        mapCollectionView.collectionViewLayout = flowLayout
        
        view.wantsLayer = true
        
        tileCollectionView.layer?.backgroundColor = NSColor.black.cgColor
        tileCollectionView.isSelectable = true
    }
    
    // MARK: CONFIGURE COLLECTIONS
    func initTrackArray(){
        var i = 0
        while ( i <= 479){
            trackArray.append(0)
            
            
            let row = i / 48 // 48 == col
            let col = i - (row * 48)
            let x = col * 32
            let y = row * 32
            
            let tile = Tile(url: "-1", index: i, id: -1, x: x, y: y, width: 32, height: 32)
            listTiles.append(tile)
            i += 1
        }
    }
 
    // MARK: MOUSE
    override func mouseEntered(with event: NSEvent) {
     
            changeCursorImge(index: "\(currentTileID)")
    }
    
    func changeCursorImge(index : String){
        let img = NSImage(named: "\(index)")
        let resizeImg = resizeTo(image: img!, w: 32, h: 32)
        let point = NSPoint(x: 10, y: 10)
        cursor = NSCursor(image: resizeImg, hotSpot: point)
        cursor.set()
    }
    
    
    func exportImage(){
     
        
    }
    // MARK: BUTTONS
    @IBAction func exportImageBtn(_ sender: Any) {
        exportImage()
        
      
        

        let cgImg = createSimpleOutputImage(arr: tileSet)
        
        
        
    
//        let cgImgRef = image.cgImage(forProposedRect: nil, context: nil, hints: nil)
        let bmpImgRef = NSBitmapImageRep(cgImage: cgImg)
        
    
        let pngData = bmpImgRef.representation(using: .PNG, properties: [:])
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
             let file = "image.png"
            
            let path = dir.appendingPathComponent(file)
            
            //writing
            do {
               try  pngData?.write(to: path)
            }
            catch {/* error handling here */}
            
            
        }

    }
    @IBAction func saveBtn(_ sender: Any) {
        
        let tree = Tree(left: 0, top: 1536, size: 1536, tiles: listTiles, screen: 200, bitmapHeight: 384)
        tree.Build(node: tree.treeNode!)
        tree.Save(node: tree.treeNode!)
        
        saveQuadTreeFile()
        
        let file = "file.txt"
        
        var countRow = 1;
        
        let row = 10;
        let column = 48;
        
        var outputText = ""
        outputText += "\(row) \(column)\n"
        for i in 0..<trackArray.count{
            if ( i == 47 * countRow ){
                outputText += "\n"
                countRow += 1
            }
            outputText += "\(trackArray[i]) "
        }
        
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(file)
            
            //writing
            do {
                try outputText.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
            
            
        }
    }

    // MARK: SAVE QUADTREE FILE
    
    func saveQuadTreeFile(){
        
        var final = ""
        createListObject()
        
        final += listObjectStr + "\n" + quadTreeStr
        writeToFile(content: final, fileName: "quadtree.txt")
    }
    
    // MARK: Create List Objects String
    
    func createListObject(){
        listObjectStr += "\(tileSet.count)" + "\n"
        listObjectStr += "\(trackArray.count) \(1536) \(384)" + "\n"
        
        for i in 0..<listTiles.count{
            listObjectStr += "\(listTiles[i].index) \(listTiles[i].id) \(listTiles[i].x) \(listTiles[i].y)" + "\n"
        }
        
    }
    
}



