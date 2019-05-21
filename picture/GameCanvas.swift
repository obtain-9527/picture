//
//  GameCanvas.swift
//  picture
//
//  Created by switch on 2019/4/25.
//  Copyright © 2019年 switch. All rights reserved.
//

import UIKit
import CoreData

class GameCanvas: UIViewController {
    var timer:Timer!
    var time = 0.0
    var container : UIView!
    let emptyPuzzle : Puzzle = Puzzle.init(image: UIImage.init(), withCol: 2, withRow: 2 ,index: 8, tog: 8)//
    var TF: [Bool] = [false,false,false,false,false,false,false,false]
    let width = UIScreen.main.bounds.width/3.0
    let height = UIScreen.main.bounds.width/3.0
    @IBOutlet weak var userTime: UITextField!
    @IBAction func restart(_ sender: Any) {
    time = 0.0
    startTime()
    }
    @IBAction func stop(_ sender: Any) {
       timer?.invalidate()
        timer = nil
    }
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startTime()
        
        container = UIView.init(frame:CGRect(x: 0, y:50, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
        container.backgroundColor = UIColor.lightGray
        self.view.addSubview(container)
        
        let orginImage = UIImage.init(named: "2.jpg")
        let arr: [Int] = [3,0,1,6,4,2,7,5]//控制图片的位置可以是0-7的随机数但每个数据不能重复。
        for i in 0..<8{
            let col = i % 3
            let row = i / 3
            let col1 = arr[i] % 3
            let row1 = arr[i] / 3
            let rect = CGRect(x:CGFloat(col) * width, y:CGFloat(row) * height, width: width, height: height)
            let rect1 = CGRect(x:CGFloat(col1) * width, y:CGFloat(row1) * height, width: width, height: height)
            let image = self.clipImageInRect(rect: rect, orginImage: orginImage!)
            
            let puzzle = Puzzle.init(image: image, withCol: col1, withRow: row1, index:i, tog: arr[i])
                TF[i] = puzzle.check()
            let puzzleView = PuzzleView.init(frame: rect1)
            puzzleView.puzzle = puzzle
            puzzleView.backgroundColor = UIColor.red
            container.addSubview(puzzleView)
        puzzleView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action:#selector(click)))
        }
        
    }
    //判断是否完成拼图
    func panduan(){
        var num = 0;
        for i in 0..<8{
            if TF[i]{
             num += 1
            }
            if(num == 8){
                print("succer")
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+DispatchTimeInterval.seconds(1), execute: {
                    self.timer?.invalidate()
                    self.timer = nil
                    self.alertView()
                })
            }
        }
    }
    //记录数据对话框
    func alertView(){
        let vcAlert = UIAlertController(title:"记分榜",message:"",preferredStyle: .alert)
        vcAlert.addTextField{(txtUser) in txtUser.placeholder = "请输入你的名字"; txtUser.clearButtonMode = .always
            
        }
        vcAlert.addTextField{(txtScore) in txtScore.text=self.userTime.text;txtScore.clearButtonMode = .always
        }
        let cancelAction = UIAlertAction(title:"Cancel",style:.default,handler:nil)
        let okAction = UIAlertAction(title:"OK",style:.default){
            (okAction) in
            let txtUser = vcAlert.textFields![0]
            let txtScore = vcAlert.textFields![1]
            let maxScore = SaveData.init()
            let res = maxScore.insertData(username: txtUser.text!, score: txtScore.text!)
            if res {
                let alert = Alert.init()
                alert.alertView(s: self)
            }
        }
        vcAlert.addAction(cancelAction)
        vcAlert.addAction(okAction)
        self.present(vcAlert,animated: true,completion: nil)
    }
   // 定时器同时刷新界面
    func startTime(){
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timeIndex), userInfo: nil, repeats: true)
    }
    //时间的控制加减
    @objc func timeIndex(){
        time += 0.1
        userTime.text = String(time) + "S"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //给每个图片控件添加点击事件
    @objc func click(tap: UITapGestureRecognizer) {
        let puzzleView = tap.view as! PuzzleView
        let puzzle = puzzleView.puzzle!
        
        let col = puzzle.col
        let row = puzzle.row
        if col == emptyPuzzle.col  {
            if row! - emptyPuzzle.row == 1 {
                puzzle.move(direction: .Up)
                puzzleView.frame.origin.y -= height
                emptyPuzzle.move(direction: .Down)
                TF[puzzle.index]=puzzle.check()
                panduan()
            }
            if row! - emptyPuzzle.row == -1 {
                puzzle.move(direction: .Down)
                puzzleView.frame.origin.y += height
                emptyPuzzle.move(direction: .Up)
                TF[puzzle.index]=puzzle.check()
                panduan()
            }
        }
        
        if row == emptyPuzzle.row  {
            if col! - emptyPuzzle.col == 1 {
                puzzle.move(direction: .Left)
                puzzleView.frame.origin.x -= width
                emptyPuzzle.move(direction: .Right)
                TF[puzzle.index]=puzzle.check()
                panduan()
            }
            if col! - emptyPuzzle.col == -1 {
                puzzle.move(direction: .Right)
                puzzleView.frame.origin.x += width
                emptyPuzzle.move(direction: .Left)
                TF[puzzle.index]=puzzle.check()
                panduan()
            }
            
        }
    }
//切割图片
    func clipImageInRect(rect: CGRect, orginImage: UIImage) -> UIImage{
        let imageRef = orginImage.cgImage!.cropping(to: rect);
        let thumbScale = UIImage.init(cgImage: imageRef!)
        return thumbScale;
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
    }

}
