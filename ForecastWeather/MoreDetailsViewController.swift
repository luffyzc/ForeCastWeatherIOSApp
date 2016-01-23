//
//  MoreDetailsViewController.swift
//  ForecastWeather
//
//  Created by ZhangChi on 12/10/15.
//  Copyright © 2015 ZhangChi. All rights reserved.
//

import UIKit
import SwiftyJSON

class MoreDetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var btnnext7days: UIButton!
    @IBOutlet weak var btnnext24hours: UIButton!
    @IBOutlet weak var Next24HoursCellTemp: UILabel!
    @IBOutlet weak var Next24HoursCellImg: UIImageView!
    @IBOutlet weak var Next24HoursCellTime: UILabel!
    @IBOutlet weak var DetailsTitle: UILabel!

    @IBOutlet weak var DetailsTableView: UITableView!
    var City:String?
    var State:String?
   // var SearchResult:JSON?
    var unit:String?
    var Next24Hours:JSON?
    var Next7Days:JSON?
    var IsNext24Hours:Bool = true
    var IsNext7Days:Bool = false
    var IsShowAll24Hours:Bool = false
    let backgroundcolor = [UIColor.greenColor(),UIColor.blueColor(),UIColor.brownColor(),UIColor.yellowColor(),UIColor.purpleColor(),UIColor.orangeColor(),UIColor.redColor()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnnext24hours.backgroundColor = UIColor.grayColor()
        
        DetailsTitle?.text = "More Details for "+self.City!+","+self.State!
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ShowAll24Hours(sender: AnyObject) {
        self.IsShowAll24Hours = true
        self.DetailsTableView.reloadData()
        
    }
    
    @IBAction func ShowNext24Hours(sender: AnyObject) {

        self.IsNext24Hours = true
        self.IsNext7Days = false
        self.IsShowAll24Hours = false
        self.DetailsTableView.reloadData()
        btnnext24hours.backgroundColor = UIColor.grayColor()
        btnnext7days.backgroundColor = UIColor.whiteColor()
        
    }

    @IBAction func ShowNext7Days(sender: AnyObject) {
        self.IsNext24Hours = false
        self.IsNext7Days = true
        self.IsShowAll24Hours = false
        self.DetailsTableView.reloadData()
        btnnext24hours.backgroundColor = UIColor.whiteColor()
        btnnext7days.backgroundColor = UIColor.grayColor()
    }
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if self.IsNext24Hours{
                if self.IsShowAll24Hours{
                     return 25
                }
               else
                {
                    return 11
                }
            }
            else
            {
                return 7
            }
            
        }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if self.IsNext24Hours{
            return 44
        }
        else{
            return 150
        }
    }
    
    
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            if self.IsNext24Hours{
                if indexPath.row == 0{
                    let Next24HoursHeader: Next24HoursHeaderCell = self.DetailsTableView.dequeueReusableCellWithIdentifier("Next24HoursHeaderCell") as! Next24HoursHeaderCell
                    Next24HoursHeader.Temp?.text = "Temp("+self.unit!+")"
                    return Next24HoursHeader
                }
                else
                {
                    
                    if !self.IsShowAll24Hours && indexPath.row == 10 {
                        let Next24HoursAdd: UITableViewCell = self.DetailsTableView.dequeueReusableCellWithIdentifier("Next24HoursAdd")!as UITableViewCell
                        return Next24HoursAdd
                    }
                    else
                    {
                        let Next24HoursCustom: Next24HoursCustomCell = self.DetailsTableView.dequeueReusableCellWithIdentifier("Next24HoursCustomCell") as! Next24HoursCustomCell
                        Next24HoursCustom.Time?.text = self.Next24Hours![indexPath.row-1]["time"].string
                        Next24HoursCustom.temp?.text = String(self.Next24Hours![indexPath.row-1]["temperature"].number!)
                        if let url = NSURL(string: self.Next24Hours![indexPath.row-1]["summary"].string!) {
                            if let data = NSData(contentsOfURL: url) {
                                Next24HoursCustom.weatherimg.image = UIImage(data: data)
                            }
                        }
//                        if indexPath.row%2 == 1{
//                            Next24HoursCustom.backgroundColor = UIColor.grayColor()
//                        }
                        return Next24HoursCustom
                    }
    

                }
            }
            else
            {
                let daykey = String(indexPath.row+1)
                let Next7DaysCustomCell : Next7DaysCell = self.DetailsTableView.dequeueReusableCellWithIdentifier("Next7DaysCell") as! Next7DaysCell
                Next7DaysCustomCell.date?.text = self.Next7Days![daykey]["Day"].string!+","+self.Next7Days![daykey]["Month"].string!
                Next7DaysCustomCell.hltemp?.text = "Min:"+String(self.Next7Days![daykey]["tempmin"].number!)+self.unit!+"|Max:"+String(self.Next7Days![daykey]["tempmax"].number!)+self.unit!
                
                if let url = NSURL(string: self.Next7Days![daykey]["Icon"].string!) {
                    if let data = NSData(contentsOfURL: url) {
                        Next7DaysCustomCell.weatherimg.image = UIImage(data: data)
                    }
                }
                
                Next7DaysCustomCell.backgroundColor = self.backgroundcolor[indexPath.row]
                return Next7DaysCustomCell
                
            }

        }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
