//
//  PersonRecord.swift
//  picture
//
//  Created by switch on 2019/4/27.
//  Copyright © 2019年 switch. All rights reserved.
//

import UIKit

class PersonRecord: UITableViewController {
    
    var datalist = SaveData.init()
    
    @IBAction func deleData(_ sender: Any) {
        let vcAlert = UIAlertController(title:"你确定删除全部记录？",message:"",preferredStyle: .alert)
        let cancelAction = UIAlertAction(title:"Cancel",style:.default,handler:nil)
        let okAction = UIAlertAction(title:"OK",style:.default){
            (okAction) in
            if self.datalist.deleData(){
                self.dismiss(animated: true, completion: nil)
                //关闭窗口
            }
        }
        vcAlert.addAction(cancelAction)
        vcAlert.addAction(okAction)
        self.present(vcAlert,animated: true,completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let len = datalist.findData()
        
        return len[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let len = datalist.findData()
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        
        // Configure the cell...
        //cell.textLabel?.text = foodList[indexPath.section][indexPath.row]
            let _labTitle = cell.contentView.subviews[0] as! UILabel
            _labTitle.text = len[1][indexPath.row]
            let labTitle = cell.contentView.subviews[1] as! UILabel
            labTitle.text = len[0][indexPath.row]
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
