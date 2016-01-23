//
//  OverallResultViewController.swift
//  ForecastWeather
//
//  Created by ZhangChi on 12/9/15.
//  Copyright © 2015 ZhangChi. All rights reserved.
//

import UIKit
import SwiftyJSON
import FBSDKCoreKit
import FBSDKShareKit





class OverallResultViewController: UIViewController, FBSDKSharingDelegate {

    var City:String?
    var State:String?
    var SearchResult:JSON?
    var unit:String?
    var CurrentWeather:JSON?
    let weatherparameternames=["Precipition","ChanceofRain","WindSpeed","DewPoint","Humidity","Visibility","Sunrise","Sunset"]
    let weatherparametertitlenames=["Precipitation","Chance of Rain","Wind Speed","Dew Point","Humidity","Visibility","Sunrise","Sunset"]
    
    
    @IBOutlet weak var CurrentScrollView: UIScrollView!
    @IBOutlet weak var degreesymbol: UILabel!
    @IBOutlet weak var weatherimg: UIImageView!
    @IBOutlet weak var HLtemperature: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weathersummary: UILabel!
    @IBOutlet weak var Precipitation: UILabel!

    @IBOutlet weak var WindSpeed: UILabel!
    @IBOutlet weak var DewPoint: UILabel!

    @IBOutlet weak var Sunset: UILabel!
    @IBOutlet weak var Sunrise: UILabel!
    @IBOutlet weak var Visibility: UILabel!
    @IBOutlet weak var Humidity: UILabel!
    @IBOutlet weak var ChanceofRain: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        CurrentScrollView.contentSize.height=800
        if SearchResult != nil{
            print(SearchResult!)
            // get the currentweather json data and the degree
            self.CurrentWeather = SearchResult!["CurrentWeather"]
            self.unit = SearchResult!["units"]["units"].string
            
            if let url = NSURL(string: CurrentWeather!["IconUrl"].string!) {
                if let data = NSData(contentsOfURL: url) {
                    weatherimg.image = UIImage(data: data)
                }        
            }
            weathersummary?.text = self.CurrentWeather!["WeatherCondition"].string!+" in "+self.City!+","+self.State!
            
            temperature?.text = String(self.CurrentWeather!["Temperature"].number!)
            
            if self.unit! == "us" {
                degreesymbol?.text = "\u{00B0}F"
            }
            else{
                degreesymbol?.text = "\u{00B0}C"
            }
            
            HLtemperature?.text="L:"+String(self.CurrentWeather!["temperaturemin"].number!)+"\u{00B0}|H:"+String(self.CurrentWeather!["temperaturemax"].number!)+"\u{00B0}"
            Precipitation?.text=self.CurrentWeather!["Precipition"].string!
            ChanceofRain?.text=self.CurrentWeather!["ChanceofRain"].string!
            WindSpeed?.text=self.CurrentWeather!["WindSpeed"].string!
            DewPoint?.text=self.CurrentWeather!["DewPoint"].string!+(degreesymbol?.text)!
            Humidity?.text=self.CurrentWeather!["Humidity"].string!
            Visibility?.text=self.CurrentWeather!["Visibility"].string!
            Sunrise?.text=self.CurrentWeather!["Sunrise"].string!
            Sunset?.text=self.CurrentWeather!["Sunset"].string!

        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MoreDetailsSegue"{
            let nextmoredetailsview = segue.destinationViewController as! MoreDetailsViewController
            nextmoredetailsview.City = self.City!
            nextmoredetailsview.State = self.State!
            nextmoredetailsview.Next24Hours = self.SearchResult!["hourly"]
            nextmoredetailsview.Next7Days = self.SearchResult!["daily"]
            nextmoredetailsview.unit = degreesymbol.text
        }
        else if segue.identifier == "MapSegue"{
            let mapview = segue.destinationViewController as! MapViewController
            mapview.lon = Double(self.CurrentWeather!["long"]["0"].string!)!
            mapview.lat = Double(self.CurrentWeather!["lat"]["0"].string!)!

            
        }
    }
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject: AnyObject]) {
        if results.count > 0 {
            let alert = UIAlertController(title: " ", message: "Successfully Post", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: " ", message: "Post Cancled", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }

        
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!) {
        let alert2 = UIAlertController(title: " ", message: "Post Falied", preferredStyle: UIAlertControllerStyle.Alert)
        alert2.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert2, animated: true, completion: nil)
    
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) {
        let alert3 = UIAlertController(title: " ", message: "Post Cancled", preferredStyle: UIAlertControllerStyle.Alert)
        alert3.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert3, animated: true, completion: nil)
        print("cancled")
    }
    
    @IBAction func FBShare(sender: AnyObject) {
        
        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = NSURL(string: "http://forecast.io")
        content.contentTitle = "Current Weather in"+self.City!+","+self.State!
        content.contentDescription = self.CurrentWeather!["WeatherCondition"].string!+","+(self.temperature?.text)!+(self.degreesymbol?.text)!
        content.imageURL = NSURL(string: self.CurrentWeather!["IconUrl"].string!)
        
        FBSDKShareDialog.showFromViewController(self, withContent: content, delegate: self)

        
    }
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.weatherparameternames.count
//    }
//
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell: UITableViewCell = self.CurrentWeatherTableView.dequeueReusableCellWithIdentifier("currentweathercell")! as UITableViewCell
//        let name=self.weatherparameternames[indexPath.row]
//        cell.textLabel?.text=self.weatherparametertitlenames[indexPath.row]
//        cell.detailTextLabel?.text=self.CurrentWeather![name].string
//        return cell
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
