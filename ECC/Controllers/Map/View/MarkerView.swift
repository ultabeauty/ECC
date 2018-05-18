//
//  MarkerView.swift
//  ECC
//
//  Created by Nicholas Eby on 3/27/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import MapKit

class MarkerView: MKMarkerAnnotationView
{
    override var annotation: MKAnnotation?
    {
        willSet
        {
            if let marker = newValue as? Marker
            {
                clusteringIdentifier = "marker"
                animatesWhenAdded = true
                displayPriority = .defaultLow
                titleVisibility = MKFeatureVisibility.visible
                subtitleVisibility = MKFeatureVisibility.visible

                if marker.type == .ulta
                {
                    glyphText = "Ulta"
                    markerTintColor = UIColor(named: "Primary_Color")
                    canShowCallout = true
                    rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                }
                else if(marker.type == .lakeview)
                {
                    glyphText = "LVHS"
                    markerTintColor = UIColor(named: "Lake_View")
                }
                else
                {
                    glyphText = "MCHS"
                    markerTintColor = UIColor(named: "Michele_Clark")
                }
            }
        }
    }
}

