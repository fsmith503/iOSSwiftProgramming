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
    var toggleBuildingSwitch = UISwitch()
    var toggleCompassSwitch = UISwitch()
    var compassButton = MKCompassButton()
    var showBuildinglabel = UILabel()
    var showCompasslabel = UILabel()
    var showTrafficSwitch = UISwitch()
    var showTrafficlabel = UILabel()
    
    
    
    override func loadView(){
        // creating a map view
        mapView = MKMapView()
        
        //set it as *the* view of this view controller
        view = mapView
        
        // MARK: Segmented Control
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.systemBackground
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        // MARK: Show Building Label
        showBuildinglabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        showBuildinglabel.center = CGPoint(x: 120, y: 110)
        showBuildinglabel.text = "Show Buildings"
        showBuildinglabel.textColor = UIColor.systemBlue
        self.view.addSubview(showBuildinglabel)
        let showBuildinglabelTopConstraint = showBuildinglabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15)
        let showBuildinglabelLeadingConstraint = showBuildinglabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let showBuildinglabelTrailingConstraint = showBuildinglabel.leadingAnchor.constraint(equalTo: margins.trailingAnchor)
        showBuildinglabelTopConstraint.isActive = true
        showBuildinglabelLeadingConstraint.isActive = true
        showBuildinglabelTrailingConstraint.isActive = true
        showBuildinglabel.isHidden = false
        
        // MARK: Show Building Switch
        toggleBuildingSwitch.center = CGPoint(x: 180, y: 110)
        toggleBuildingSwitch.tintColor = UIColor.systemBlue
        self.view.addSubview(toggleBuildingSwitch)
        toggleBuildingSwitch.addTarget(self, action: #selector(toggleBuildingSwitchChanged), for: .touchUpInside)
        
        // MARK: Show Compass Label
        showCompasslabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        showCompasslabel.center = CGPoint(x: 120, y: 150)
        showCompasslabel.text = "Show Compass"
        showCompasslabel.textColor = UIColor.systemBlue
        self.view.addSubview(showCompasslabel)
        let showCompasslabelTopConstraint = showCompasslabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15)
        let showCompasslabelLeadingingConstraint = showCompasslabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let showCompasslabelTrailingConstraint = showCompasslabel.leadingAnchor.constraint(equalTo: margins.trailingAnchor)
        showCompasslabelTopConstraint.isActive = true
        showCompasslabelTrailingConstraint.isActive = true
        showCompasslabelLeadingingConstraint.isActive = true
        showCompasslabel.isHidden = false
        
        // MARK: Adding compass to view
//        var compassButton = MKCompassButton(mapView: mapView)   // Make a new compass
//        //compassButton.compassVisibility = .visible    // Make it visible
//        mapView.addSubview(compassButton) // Add it to the view
//        // Position it as required
//        compassButton.translatesAutoresizingMaskIntoConstraints = false
//        compassButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -12).isActive = true
//        compassButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 100).isActive = true
        //self.view.addSubview(compassButton)
    
        // MARK: Show Compass Switch
        toggleCompassSwitch.center = CGPoint(x: 180, y: 150)
        toggleCompassSwitch.tintColor = UIColor.systemBlue
        self.view.addSubview(toggleCompassSwitch)
        toggleCompassSwitch.addTarget(self, action: #selector(toggleCompassSwitchChanged), for: .touchUpInside)
        
        // MARK: Show traffic label
        showTrafficlabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        showTrafficlabel.center = CGPoint(x: 120, y: 190)
        showTrafficlabel.text = "Show Traffic"
        showTrafficlabel.textColor = UIColor.systemBlue
        self.view.addSubview(showTrafficlabel)
        let showTrafficlabelTopConstraint = showTrafficlabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15)
        let showTrafficlabelLeadingingConstraint = showTrafficlabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let showTrafficlabelTrailingConstraint = showTrafficlabel.leadingAnchor.constraint(equalTo: margins.trailingAnchor)
        showTrafficlabelTopConstraint.isActive = true
        showTrafficlabelTrailingConstraint.isActive = true
        showTrafficlabelLeadingingConstraint.isActive = true
        showTrafficlabel.isHidden = false
        
        // MARK: Show traffic Switch
        showTrafficSwitch.center = CGPoint(x: 180, y: 190)
        showTrafficSwitch.tintColor = UIColor.systemBlue
        self.view.addSubview(showTrafficSwitch)
        showTrafficSwitch.addTarget(self, action: #selector(toggleTrafficSwitchChanged), for: .touchUpInside)
        
    }

    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
            self.showBuildinglabel.textColor = UIColor.systemBlue
            self.showCompasslabel.textColor = UIColor.systemBlue
            self.showTrafficlabel.textColor = UIColor.systemBlue
        case 1:
            mapView.mapType = .hybrid
            self.showBuildinglabel.textColor = UIColor.red
            self.showCompasslabel.textColor = UIColor.red
            self.showTrafficlabel.textColor = UIColor.red
        case 2:
            mapView.mapType = .satellite
            self.showBuildinglabel.textColor = UIColor.purple
            self.showCompasslabel.textColor = UIColor.purple
            self.showTrafficlabel.textColor = UIColor.purple
        default:
            break
        }
    }
    
    @objc func toggleBuildingSwitchChanged(){
        if toggleBuildingSwitch.isOn{
            mapView.showsBuildings = true
        } else{
            mapView.showsBuildings = false
        }
    }
    
    @objc func toggleCompassSwitchChanged(){
        var compassButton = MKCompassButton(mapView: mapView)   // Make a new compass
        //compassButton.compassVisibility = .visible    // Make it visible
        mapView.addSubview(compassButton) // Add it to the view
        // Position it as required
        compassButton.translatesAutoresizingMaskIntoConstraints = false
        compassButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -12).isActive = true
        compassButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 100).isActive = true
        if toggleCompassSwitch.isOn{
            compassButton.compassVisibility = .visible
            //mapView.showsCompass = true
        }
        if toggleCompassSwitch.isOn == false {
            compassButton.compassVisibility = .hidden
            print("hitting compass switch false case")
        }
    }
    
    @objc func toggleTrafficSwitchChanged(){
        if showTrafficSwitch.isOn{
            mapView.showsTraffic = true
        }
        else{
            mapView.showsTraffic = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("Map VC loaded it's view")
    }
    
}
