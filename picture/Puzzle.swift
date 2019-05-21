//
//  Puzzle.swift
//  picture
//
//  Created by switch on 2019/4/25.
//  Copyright © 2019年 switch. All rights reserved.
//
import UIKit

public enum Direction {
    case Up
    case Down
    case Left
    case Right
}

class Puzzle: NSObject {
    
    var  col : Int!
    var  row : Int!
    var  index : Int!
    var  tog : Int!
    private(set) var  image : UIImage!
    
    init(image: UIImage, withCol col: Int, withRow row: Int, index: Int, tog: Int){
        super.init()
        self.col = col
        self.row = row
        self.image = image
        self.index = index
        self.tog = tog
    }
    
    func move(direction : Direction) {
        
        switch direction {
        case .Up:
            row = row - 1
            tog = tog - 3
            break
        case .Down:
            row = row + 1
            tog = tog + 3
            break
        case .Left:
            col = col - 1
            tog = tog - 1
            break
        case .Right:
            col = col + 1
            tog = tog + 1
            break
        }
    }
    func check()->Bool{
        var succe = false
        if self.index == self.tog{
            succe = true
        }
        return succe
    }
}
