//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by franklin smith on 12/13/20.
//

//import Foundation

import UIKit
import MapKit
class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    
    
    override func loadView(){
        // creating a map view
        mapView = MKMapView()
        
        //set it as *the* view of this view controller
        view = mapView
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.systemBackground
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        //let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.topAnchor)
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        //let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        //let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        //var label = UILabel()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 120, y: 110)
        //label.textAlignment = .center
        label.text = "Points of interest"
        label.textColor = UIColor.systemBlue
        self.view.addSubview(label)
        
        var toggleSwitch = UISwitch()
        toggleSwitch.center = CGPoint(x: 180, y: 110)
        toggleSwitch.tintColor = UIColor.systemBlue
        self.view.addSubview(toggleSwitch)
        
        let labelTopConstraint = label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15)
        let labelLeadingConstraint = label.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let labelTrailingConstraint = label.leadingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        labelTopConstraint.isActive = true
        labelLeadingConstraint.isActive = true
        labelTrailingConstraint.isActive = true
        label.isHidden = false
        //view.addSubview(label)
        
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("Map VC loaded it's view")
    }
    
}
