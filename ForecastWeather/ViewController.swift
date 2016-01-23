//
//  ViewController.swift
//  ForecastWeather
//
//  Created by ZhangChi on 12/8/15.
//  Copyright © 2015 ZhangChi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate{
    
    @IBOutlet weak var Errormessage: UILabel!
    @IBOutlet weak var StatePicker: UIPickerView!
    @IBOutlet weak var Streetinput: UITextField!
    @IBOutlet weak var DegreePicker: UIPickerView!
    @IBOutlet weak var Cityinput: UITextField!
    
    let linkURL=NSURL(string: "http://forecast.io")
    let Degreedatasource=["Fahrenheit","Celsius"]
    let Statetitledatasource=["Select","Alabama", "Alaska", "Arizona", "Akansas", "California", "Colorado", "Connecticut", "Delaware", "District of Columbia", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
    let StateValuedatasource=["AL", "Ak", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
    var State:String?
    var Degree:String?
    var SearchResultJson:JSON?
    @IBAction func ForecastIOURL(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(linkURL!)
    }
    @IBAction func ResetAll(sender: AnyObject) {
        Streetinput.text=""
        Cityinput.text=""
        StatePicker.selectRow(0, inComponent: 0, animated: false)
        DegreePicker.selectRow(0, inComponent: 0, animated: false)
        Errormessage.text=""
    }
    @IBAction func Searchweather(sender: AnyObject) {
        if Streetinput.text == "" {
            Errormessage.text="Please input Street!"
            return
        }
        
        
        
        if Cityinput.text == ""{
            Errormessage.text="Please input City!"
            return
        }
        
        
        if State == "Select" {
            Errormessage.text="Please select State!"
            return
        }
        else{
            Errormessage.text=""
        }
        
        let parameter=["mystreet": Streetinput.text!,"mycity":Cityinput.text!,"State":State!,"Degree":Degree!]
        
        Alamofire.request(.GET, "http://MyWeatherForecast.elasticbeanstalk.com/", parameters:parameter )
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        self.SearchResultJson = JSON(value)
//                        print(response.request)
//                        print("JSON: \(self.SearchResultJson!)")
//                        print("current:\(self.SearchResultJson!["CurrentWeather"])")
                        let nextview = self.storyboard?.instantiateViewControllerWithIdentifier("OverallResultViewController") as! OverallResultViewController
                        nextview.SearchResult=self.SearchResultJson
                        nextview.City=self.Cityinput.text!
                        nextview.State=self.State!
                        self.navigationController?.pushViewController(nextview, animated: true)
                    }
                case .Failure(let error):
                    print(error)
                }

        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.DegreePicker.dataSource=self
        self.DegreePicker.delegate=self
        self.StatePicker.dataSource=self
        self.StatePicker.delegate=self
        Errormessage.text=""
        Degree="Fahrenheit"
        State="Select"
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView==self.DegreePicker
        {
            return Degreedatasource.count
            
        }
        else // pickerView==self.StatePicker
        {
            return Statetitledatasource.count
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView==self.DegreePicker
        {
            return Degreedatasource[row]
            
        }
        else // pickerView==self.StatePicker
        {
            return Statetitledatasource[row]
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView==self.DegreePicker
        {
            Degree=Degreedatasource[row]
        }
        else //pickerView==self.StatePicker
        {
            State=Statetitledatasource[row]
        }
        
        //        if Streetinput.text==nil {print("ffff")}
        // print(Streetinput.text,Cityinput.text)
    }
    
    
}

