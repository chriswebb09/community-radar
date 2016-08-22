//
//  MapKitViewController.swift
//  ProjectOvaltine
//
//  Created by Colin Walsh on 8/8/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//
// This makes the

import Foundation
import MapKit
import SwiftSpinner

class MapKitViewController: UIViewController, MKMapViewDelegate, UISearchControllerDelegate, UISearchBarDelegate {
    
    var window: UIWindow?
    
    //Data store instances
    let store = DataStore.sharedInstance
    let cityAPI = CitySDKAPIClient()
    let jobsAPI = USAJobsAPIClient.sharedInstance
    
    
    //Array of citySDK data
    var cityData: [CitySDKData] = []
    
    //Initialized mapView
    let mapView: MKMapView! = MKMapView()
    
    //Set zipLocation (used in GeoCoder function), region radius
    var zipLocation : CLLocation! = nil
    let regionRadius: CLLocationDistance = 1000
    
    //Initialize alert - used in GeoCoder function when user enters an invalid zipcode
    let alert = UIAlertController.init(title: "Invalid Entry", message: "You entered an invalid Zipcode", preferredStyle: .Alert)
    
    
    //Calculates a location from array of location data - will be deprecated eventually
    var initialLocation : CLLocation {
        let newLocation = CLLocation.init(latitude: 40.28683599971092, longitude: -75.26431999998206)
        return newLocation}
    
    //Necessary to convert point data to CLLocationCoordinate2D array
    var boundary: [CLLocationCoordinate2D] = []
    
    //Initialized array of MKOverlays
    var overlayArray: [MKOverlay] = []
    
    var polygon: MKPolygon!
    
    var anotation = MKPointAnnotation()
    
    //Init searchBar
    let searchController = UISearchBar.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawInMapView()
        self.searchBar()
        
        centerMapOnLocation(self.initialLocation)
        self.alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
    }
    
    override func viewDidAppear(animated: Bool) {
       
    }
    
    func drawInMapView(){
        mapView.frame = view.frame
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    func zoomToPolygon(map: MKPolygon, animated: Bool) {
        let insets = UIEdgeInsets.init(top: 5.0, left: 50.0, bottom: 5.0, right: 50.0)
        self.mapView.setVisibleMapRect(self.polygon.boundingMapRect, edgePadding: insets, animated: true)
        //self.mapView.setVisibleMapRect(self.polygon.boundingMapRect, animated: true)
    }
    
    //Delegate method from mapView in order to render the polyline
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let polygonRenderer = MKPolygonRenderer(overlay: overlay)
        
        polygonRenderer.lineWidth = 1
        polygonRenderer.fillColor = UIColor.cyanColor()
        polygonRenderer.alpha = 0.20
        return polygonRenderer
    }
    
    //Following two functions from: http://stackoverflow.com/questions/33123724/swift-adding-a-button-to-my-mkpointannotation
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationReuseId = "Place"
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(annotationReuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationReuseId)
        } else {
            anView!.annotation = annotation
        }
        
        anView?.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
        anView!.backgroundColor = UIColor.clearColor()
        anView!.canShowCallout = true
        let testImage = UIImage(named: "annotation_test")
        
        let scaledImage = UIImage.init(CGImage: (testImage?.CGImage)!, scale: 7, orientation: UIImageOrientation.Up)
        
        anView!.image = scaledImage
        return anView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        //I don't know how to convert this if condition to swift 1.2 but you can remove it since you don't have any other button in the annotation view
        if (control as? UIButton)?.buttonType == UIButtonType.DetailDisclosure {
            
            let detailVC = TabBarController()
            self.showViewController(detailVC, sender: nil)
            self.searchController.text?.removeAll()
        }
    }
    
    
    func populateCoordinateArray(completionHandler: (NSArray) -> ()){
        
        self.store.getCitySDKData({
            
            if let geo = self.store.cityDataPoints.first?.coordinates {
                completionHandler(geo)
            }
        })
        print(self.store.scoreData)
    }
    
    func convertArrayDataToPoints(array: [AnyObject]) {
        
        let longCoord = array[0] as! Double
        let latCoord = array[1] as! Double
        let point = CLLocationCoordinate2D(latitude: latCoord, longitude: longCoord)
        boundary.append(point)
        
    }
    
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  self.regionRadius * 2.0,
                                                                  self.regionRadius * 2.0)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        self.getLocationFromZipcode(self.searchController.text!)
        self.view.endEditing(true)
        
        
        
    }
    
    //Takes a string of numbers and gets a lat/long - Async
    func getLocationFromZipcode(zipcode: String){
        var placemark: CLPlacemark!
        
        if zipcode.characters.count == 5 {
        CLGeocoder().geocodeAddressString(zipcode, completionHandler: {[weak self] (placemarks, error) in
            if error != nil {
                self!.presentViewController(self!.alert, animated: true, completion: nil)
                print("\(error)")
                
            } else {
                
                placemark = (placemarks?.last)!
                
                CensusAPIClient().requestDataForLocation(placemark: placemark, completion: { (city, county, state, us) in
                    print("INSIDE REQUEST COMPLETION IN MAP KIT VIEW")
                    print("City name: \(city?.name!)")
                    print("County name: \(county?.name!)")
                    print("State abbreviation: \(state?.abbreviation)")
                    print("State cities count: \(state?.cities?.count)")
                    print("State counties count: \(state?.counties?.count)")
                    print("State dataSets count: \(state?.dataSets?.count)")
                    print("US: \(us?.name)")
                    print("US states count: \(us?.states?.count)")
                    print("US dataSets count: \(us?.dataSets?.count)")
                })
                
                self!.store.zipCode = (placemark.postalCode)!
                self!.populateCoordinateArray{[weak self] (someArray) in
                    self!.boundary.removeAll()
                    
                    for i in 0...someArray.count-1 {
                        self!.convertArrayDataToPoints(someArray[i] as! [AnyObject])
                    }
                    
                    
                    
                    self!.mapView.removeOverlays(self!.overlayArray)
                    if self!.overlayArray.count != 0 {
                        self!.overlayArray.removeAll()}
                    
                    
                    self!.polygon = MKPolygon(coordinates: &self!.boundary, count: self!.boundary.count)
                    
                    self!.polygon.title = "county_borders"
                    
                    self!.overlayArray.append(self!.polygon)
                    
                    self!.mapView.addOverlays(self!.overlayArray)
                    
                    self!.zoomToPolygon(self!.polygon, animated: true)
                    
                    self!.mapView.removeAnnotation(self!.anotation)
                    self!.anotation.coordinate = (placemark?.location?.coordinate)!
                    self!.anotation.title = placemark?.locality
                    self!.anotation.subtitle = "\(placemark!.subAdministrativeArea!) County"
                    self!.mapView.addAnnotation(self!.anotation)
                    self!.mapView.selectAnnotation(self!.anotation, animated: true)
                }
                
                self!.zipLocation = placemark?.location
                
                    SwiftSpinner.showWithDuration(0.9, title: "Ovaltine")
                SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 33.0))
            
            }
            
            
            })
        } else {
            self.presentViewController(self.alert, animated: true, completion: {self.mapView.addOverlays(self.overlayArray)})
        }
        
    }
    
    
    
    func searchBar() {
        self.searchController.placeholder = "Enter Zipcode"
        self.searchController.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 70)
        let topConstraint = NSLayoutConstraint(item: searchController, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        self.searchController.delegate = self
        self.view.addSubview(self.searchController)
        self.view.addConstraint(topConstraint)
        self.searchController.barTintColor = UIColor.blackColor()
        self.searchController.alpha = 0.8
    }
}

