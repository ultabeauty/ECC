//
//  MapViewController.swift
//  ECC
//
//  Created by Nicholas Eby on 3/24/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate
{
    // MARK: - Properties
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationImageView: UIImageView!
    
    var firstLoad : Bool = true

    
    // MARK: - Lifecycle
    override func viewDidLoad()
    {
        super.viewDidLoad()

        //Defaults
        locationImageView?.layer.cornerRadius = locationImageView.frame.size.width / 2
        
        registerAnnotationViewClasses()
        preloadMap()
    }

    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        loadDataForMapRegionAndBikes()
    }
    

    
    
    
    
    func preloadMap()
    {
        let center = CLLocationCoordinate2D(latitude: 41.888181845932714, longitude: -87.637026469456373)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.149, longitudeDelta: 0.109))
        
        mapView.setRegion(region, animated: false)
    }
    

    
    func registerAnnotationViewClasses()
    {
        mapView.register(MarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
    
    
    func loadDataForMapRegionAndBikes()
    {
        mapView.removeAnnotations(mapView.annotations)
        
        let annotation = Marker.markers(lat: 41.8803211503044, lng: -87.6388910783805, title: "Ulta Beauty - 15th Floor", subtitle: "120 S. Riverside Plaza\nChicago, IL 60606", type: 0)
        mapView.addAnnotation(annotation)
        
        if(UserDefaults.standard.string(forKey: "kSchoolSelection") != nil)
        {
            let school = UserDefaults.standard.string(forKey: "kSchoolSelection")
            
            if(school == "LakeView")
            {
                let annotation = Marker.markers(lat: 41.95466, lng: -87.66905, title: "Lake View", subtitle: "4015 North Ashland Ave.\nChicago, IL 60613", type: 1)
                mapView.addAnnotation(annotation)

            }
            else if(school == "MicheleClark")
            {
                let annotation = Marker.markers(lat: 41.87297, lng: -87.75199, title: "Michele Clark", subtitle: "5101 West Harrison St.\nChicago, IL 60644", type: 2)
                mapView.addAnnotation(annotation)
            }
        }
        
        zoomMapaFitAnnotations()
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        guard let annotation = annotation as? Marker else { return nil }
        let identifier = "marker"
        var view: MarkerView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MarkerView
        {
            dequeuedView.annotation = annotation
            view = dequeuedView
        }
        else
        {
            view = MarkerView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        return view
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        let marker = view.annotation as! Marker
        showOptions(marker: marker)
    }
    
    
    func showOptions(marker:Marker)
    {
        let alert = UIAlertController(title: "Options", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Get Directions", style: .default, handler: { action in
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            marker.mapItem().openInMaps(launchOptions: launchOptions)
        }))
        
        self.present(alert, animated: true)
    }
    
    
    func zoomMapaFitAnnotations()
    {
        if(self.mapView.annotations.count > 1)
        {
            var zoomRect = MKMapRectNull
            for annotation in self.mapView.annotations
            {
                let annotationPoint = MKMapPointForCoordinate(annotation.coordinate)
                
                let pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0)
                
                if (MKMapRectIsNull(zoomRect))
                {
                    zoomRect = pointRect
                }
                else
                {
                    zoomRect = MKMapRectUnion(zoomRect, pointRect)
                }
            }
            self.mapView.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsetsMake(100, 50, 100, 50), animated: true)
        }
        else
        {
            let center = CLLocationCoordinate2D(latitude: 41.8803211503044, longitude: -87.6388910783805)
            let viewRegion = MKCoordinateRegionMakeWithDistance(center, 200, 200)
            mapView.setRegion(viewRegion, animated: false)
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
