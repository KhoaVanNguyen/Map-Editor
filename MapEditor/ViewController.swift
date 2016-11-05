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
class ViewController: NSViewController, NSCollectionViewDataSource , NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout{

    @IBOutlet weak var currentImg: NSButton!
    @IBOutlet weak var backgroundScrollView: NSScrollView!
    
    @IBOutlet weak var gameObjectSrollView: NSScrollView!
    @IBOutlet weak var objectCollectionView: NSCollectionView!
    @IBOutlet weak var columnLbl: NSTextField!
    @IBOutlet weak var rowLbl: NSTextField!
    @IBOutlet weak var mapCollectionView: NSCollectionView!
    
    @IBOutlet weak var tileCollectionView: NSCollectionView!
   
    
    var isDrawBG = true
    
    var currentTileID = 0;

    var pickingImg = "black"
    var exportedImage = NSImage()
    
    var listTiles = [Tile]()
    var listGameObject = [Tile]()
    
    var cursor = NSCursor()
    
    
    let tileSet = [0,1,2,3,4,5,6,7,8,9,10,11,12,12,14,15,16,17,18,19,20,
                   21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,
                   40,41,42,43,44,45,46,47,48]
    
    let gameSet = ["game_0","game_1","game_2","game_3","game_4","game_5","game_6",                   "game_7","game_8","game_9","game_10","game_11","game_12",                   "game_13","game_14","game_15","game_16","game_17","game_18",
        "game_19","game_20","game_21","game_22","game_23","game_24",
        "game_25","game_26","game_27"]
    
    var trackBackground = [Int]()
    var trackGameObject = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapCollectionView(rows: 10, columns: 48)
        configureTileCollectionView(collectionView: tileCollectionView)
        configureTileCollectionView(collectionView: objectCollectionView)
        initTrackBackground()
        
        self.view.layer?.backgroundColor = CGColor(red: 24, green: 122, blue: 12, alpha: 1)
        
        mapCollectionView.delegate = self
        mapCollectionView.dataSource = self
        
        tileCollectionView.delegate = self
        tileCollectionView.dataSource = self
        
        objectCollectionView.delegate = self
        objectCollectionView.dataSource = self
        
        changeCursorImge(index: pickingImg)
        

        
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
        }else if collectionView == self.objectCollectionView  {
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
        else if collectionView == self.objectCollectionView  {
            return gameSet.count
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
        else if collectionView == self.objectCollectionView  {
            let item = collectionView.makeItem(withIdentifier: "GameObjectViewItem", for: indexPath) as!
            GameObjectViewItem
            item.loadImage(imgUrl: gameSet[indexPath.item])
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
            //item.changeImage("\(currentTileID)")
            
            item.changeImage(pickingImg)
            
            let row = index / 48 // 48 == col
            let col = index - (row * 48)
            print(" index = \(index) at: [\(row),\(col)] ")
            // Add to tile list
            let x = col * 32
            let y = row * 32
            // track
            if ( isDrawBG ){
                trackBackground[index] = currentTileID
                
                let tile = Tile(url:  "\(currentTileID)", index: index, id:currentTileID, x: x, y: y, width: 32, height: 32)
                listTiles[index] = tile
            }else {
                let tile = Tile(url:  "\(currentTileID)", index: listGameObject.count, id:currentTileID, x: x, y: y, width: 32, height: 32)
                listGameObject.append(tile)
            }
           // changeCursorImge(index: "\(currentTileID)")
        }
        else if collectionView == self.objectCollectionView  {
            isDrawBG = false

            let index = convertToStringFrom(indexPaths)
            
            currentTileID = index
            
            // get the name of current tile
            pickingImg = gameSet[currentTileID]
            
            changeCursorImge(index: "\(gameSet[index])")
            currentImg.image = NSImage(named: "\(gameSet[index])")
        }
            
        else{
            isDrawBG = true
            let index = convertToStringFrom(indexPaths)
            currentTileID = index
            pickingImg = "\(index)"
            
            
            changeCursorImge(index: "\(index)")
            currentImg.image = NSImage(named: "\(index)")
        }
    }
    
    // MARK: CONFIGURE COLLECTIONS
    private func configureMapCollectionView(rows: Int, columns : Int) {

        let gridLayout = NSCollectionViewGridLayout()
        gridLayout.minimumItemSize = CGSize(width: TILE_SIZE, height: TILE_SIZE)
        
        gridLayout.maximumItemSize = CGSize(width: TILE_SIZE, height: TILE_SIZE)
        
        gridLayout.maximumNumberOfRows = rows
        gridLayout.maximumNumberOfColumns = columns
        
        gridLayout.minimumInteritemSpacing = 1
        gridLayout.minimumLineSpacing = 1
        
        
        mapCollectionView.collectionViewLayout = gridLayout
        
        view.wantsLayer = true
        mapCollectionView.isSelectable = true

    }
    private func configureTileCollectionView( collectionView : NSCollectionView  ) {
        
        let flowLayout = NSCollectionViewFlowLayout()
        flowLayout.itemSize = NSSize(width: 32.0, height: 32.0)
        // flowLayout.sectionInset = EdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.minimumLineSpacing = 1
        //mapCollectionView.collectionViewLayout = flowLayout
        
        
        collectionView.collectionViewLayout = flowLayout
        view.wantsLayer = true
        
       // tileCollectionView.layer?.backgroundColor = NSColor.black.cgColor
        //tileCollectionView.isSelectable = true
        collectionView.isSelectable = true
        
    }
    
    // MARK: CONFIGURE TRACKING ARRAYS
    func initTrackBackground(){
        var i = 0
        while ( i <= 479){
            trackBackground.append(0)
            
            
            let row = i / 48 // 48 == col
            let col = i - (row * 48)
            let x = col * 32
            let y = row * 32
            
            let tile = Tile(url: "-1", index: i, id: -1, x: x, y: y, width: 32, height: 32)
            listTiles.append(tile)
            i += 1
        }
    }
    func initTrackObjects(){
        var i = 0
        while ( i <= gameSet.count){
            trackGameObject.append(0)
            // HARD CODE COLUMN AND ROW , SIZE
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
    
    func exportTileSet(){
        let cgImg = createSimpleOutputImage(arr: tileSet)
        //let cgImgRef = image.cgImage(forProposedRect: nil, context: nil, hints: nil)
        let bmpImgRef = NSBitmapImageRep(cgImage: cgImg)
        let pngData = bmpImgRef.representation(using: .PNG, properties: [:])
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let file = "tileset.png"
            let path = dir.appendingPathComponent(file)
            //writing
            do {
                try  pngData?.write(to: path)
            }
            catch {/* error handling here */}
        }
    }
    
   // MARK: SHOW SAVE QUADTREE
    func showSaveQuadTree(gameObject :String, quadTree : String ){
        
        var finalStr = ""
        finalStr += gameObject + quadTree
        
        let savePanel = NSSavePanel()
        savePanel.setAccessibilityExpanded(true)
        savePanel.canCreateDirectories = true
        savePanel.title = "Save QuadTree Game Object"
        savePanel.allowedFileTypes = ["txt","docx"]
        savePanel.begin { (result) in
            
            if result == NSFileHandlingPanelOKButton {
                let savedUrl = savePanel.url
                quadTreeName = savePanel.nameFieldStringValue
                
                quadTreeUrl = (savedUrl?.path)!
                writeToFile(content: finalStr, fileName: quadTreeName, url : quadTreeUrl)
                
            }
        }
    }
    // MARK: CREATE LIST OBJECT STRING
    func createListObject(listObject : [Tile], isBackground : Bool ){
        if ( isBackground ){
            listObjectStr += "\(tileSet.count)" + "\n"
        }
        listObjectStr += "\(listObject.count) \(SCREEN_WIDTH) \(SCREEN_HEIGHT)" + "\n"
        if ( isBackground ){
            for i in 0..<listObject.count{
                listObjectStr += "\(listObject[i].index) \(listObject[i].id) \(listObject[i].x) \(listObject[i].y)" + "\n"
            }
        }
        else {
            for i in 0..<listObject.count{
                listObjectStr += "\(listObject[i].index) \(listObject[i].id) \(listObject[i].x) \(listObject[i].y) \(listObject[i].width) \(listObject[i].height)" + "\n"
            }

        }
        
    }

    // MARK: Control Interactions
    @IBAction func exportImageBtn(_ sender: Any) {
        exportTileSet()
    }
    @IBAction func saveBtn(_ sender: Any) {
        
        
        listObjectStr = ""
        quadTreeStr = ""
        let tree = Tree(left: 0, top: 1536, size: 1536, tiles: listTiles, screen: 200, bitmapHeight: 384)
        tree.Build(node: tree.treeNode!)
        tree.Save(node: tree.treeNode! )
        
        
        createListObject(listObject: listTiles, isBackground: true)
        showSaveQuadTree(gameObject: listObjectStr, quadTree: quadTreeStr)
        
        
        // save tile map
        let file = "tilemap.txt"
        
        var countRow = 1;
        
        let row = 10;
        let column = 48;
        
        var outputText = ""
        outputText += "\(row) \(column)\n"
        for i in 0..<trackBackground.count{
            if ( i == 47 * countRow ){
                outputText += "\n"
                countRow += 1
            }
            outputText += "\(trackBackground[i]) "
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
    @IBAction func rowStepper(_ sender: NSStepper) {
    
        rowLbl.stringValue = "\( sender.valueWraps )"
        
    }
    
    @IBAction func columnStepper(_ sender: NSStepper) {
    }
 
    @IBAction func rowTextChange(_ sender: NSTextField) {
        
        ROWS = Int(rowLbl.stringValue)!
        self.configureMapCollectionView(rows: ROWS, columns: COLUMNS)
        mapCollectionView.reloadData()
    }
    
    @IBAction func columnTextChange(_ sender: Any) {
        COLUMNS = Int(columnLbl.stringValue)!
        self.configureMapCollectionView(rows: ROWS, columns: COLUMNS)
        mapCollectionView.reloadData()
        
    }
    @IBAction func segmentCellchange(_ sender: NSSegmentedCell) {
        
        // game
        if ( sender.selectedSegment == 1 ){
            backgroundScrollView.isHidden = true
            backgroundScrollView.setAccessibilityEnabled(false)
            tileCollectionView.isSelectable = false
            
            gameObjectSrollView.isHidden = false
            gameObjectSrollView.setAccessibilityEnabled(true)
            objectCollectionView.isSelectable = true
         
        }else if ( sender.selectedSegment == 0 ){
            backgroundScrollView.isHidden = false
            backgroundScrollView.setAccessibilityEnabled(true)
            tileCollectionView.isSelectable = true
            
            gameObjectSrollView.isHidden = true
            gameObjectSrollView.setAccessibilityEnabled(false)
            objectCollectionView.isSelectable = false
        }
    }
    
    
    @IBAction func saveObjects(_ sender: Any) {
        listObjectStr = ""
        quadTreeStr = ""
        let gameObjectTree = Tree(left: 0, top: 1536, size: 1536, tiles: listGameObject, screen: 200, bitmapHeight: 384)
        
        gameObjectTree.Build(node: gameObjectTree.treeNode!)
        gameObjectTree.Save(node: gameObjectTree.treeNode!)
        createListObject(listObject: listGameObject, isBackground: false)
        showSaveQuadTree(gameObject: listObjectStr, quadTree: quadTreeStr)
    }
}



