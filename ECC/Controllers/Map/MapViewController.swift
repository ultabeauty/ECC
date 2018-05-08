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
    @IBOutlet weak var mapView: MKMapView!
    var firstLoad : Bool = true

    override func viewDidLoad()
    {
        super.viewDidLoad()

        registerAnnotationViewClasses()
        preloadMap()
    }

    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        loadDataForMapRegionAndBikes()
    }
    
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView)
    {
        print("mapViewDidFinishLoadingMap")
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool)
    {
        print("mapViewDidFinishRenderingMap")

    }
    
    
    
    
    func preloadMap()
    {
        let center = CLLocationCoordinate2D(latitude: 41.888181845932714, longitude: -87.637026469456373)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.149, longitudeDelta: 0.109))
        
        mapView.setRegion(region, animated: false)
    }
    
    @IBAction func log(_ sender: Any)
    {
        print(mapView.region, mapView)
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
                let annotation = Marker.markers(lat: 41.95466, lng: -87.66905, title: "Lake View", subtitle: "120 S. Riverside Plaza\nChicago, IL 60606", type: 1)
                mapView.addAnnotation(annotation)

            }
            else
            {
                let annotation = Marker.markers(lat: 41.87297, lng: -87.75199, title: "Michele Clark", subtitle: "120 S. Riverside Plaza\nChicago, IL 60606", type: 2)
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
        self.mapView.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsetsMake(50, 50, 50, 50), animated: true)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
