//
//  MapViewController.swift
//  ForecastWeather
//
//  Created by ZhangChi on 12/10/15.
//  Copyright © 2015 ZhangChi. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
 
    var lon:Double?
    var lat:Double?
 //   var weathermap:AWFWeatherMap?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initialLocation = CLLocation(latitude: self.lat!, longitude: self.lon!)
        
        centerMapOnLocation(initialLocation)

        // Do any additional setup after loading the view.
//        self.weathermap = AWFWeatherMap(mapType: AWFWeatherMapType.Apple)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let regionRadius: CLLocationDistance = 1000
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
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
