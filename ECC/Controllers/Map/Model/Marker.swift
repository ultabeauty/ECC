//
//  Marker.swift
//  ECC
//
//  Created by Nicholas Eby on 3/27/18.
//  Copyright © 2018 Nicholas Eby. All rights reserved.
//

import MapKit
import Contacts

class Marker: MKPointAnnotation
{
    enum PinType: Int {
        case ulta
        case lakeview
        case micheleclark
    }
    
    var type: PinType = .ulta
    
    class func markers(lat:Double, lng:Double, title:String, subtitle:String, type:Int) -> Marker
    {
        let marker = Marker()
        marker.title = title
        marker.subtitle = subtitle
        marker.coordinate = CLLocationCoordinate2DMake(lat, lng)
        marker.type = PinType(rawValue: type)!
        return marker
    }
    
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
}
