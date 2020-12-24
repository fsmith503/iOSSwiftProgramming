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
    var pointOfInterestSwitch = UISwitch()
    var pointOfInterestLabel = UILabel()
    var showZClabel = UILabel()
    var showZCSwitch = UISwitch()
    
    
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
        
        // MARK: Point of interest label
        pointOfInterestLabel = UILabel(frame: CGRect(x:0, y:0, width: 200, height: 21))
        pointOfInterestLabel.center = CGPoint(x: 120, y: 230)
        pointOfInterestLabel.text = "Points Of Interest"
        pointOfInterestLabel.textColor = UIColor.systemBlue
        self.view.addSubview(pointOfInterestLabel)
        let POIlabelTopConstraint = pointOfInterestLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15)
        let POIlabelLeadingConstraint = pointOfInterestLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let POIlabelTrailingConstraint = pointOfInterestLabel.leadingAnchor.constraint(equalTo: margins.trailingAnchor)
        POIlabelLeadingConstraint.isActive = true
        POIlabelTopConstraint.isActive = true
        POIlabelTrailingConstraint.isActive = true
        pointOfInterestLabel.isHidden = false
        
        // MARK: Point of interest switch
        pointOfInterestSwitch.center = CGPoint(x: 180, y: 230)
        pointOfInterestSwitch.tintColor = UIColor.systemBlue
        self.view.addSubview(pointOfInterestSwitch)
        pointOfInterestSwitch.addTarget(self, action: #selector(togglePOISwitchChanged), for: .touchUpInside)
        
        // MARK: Show zc label
        showZClabel = UILabel(frame: CGRect(x:0, y:0, width: 200, height: 21))
        showZClabel.center = CGPoint(x: 120, y: 270)
        showZClabel.text = "Shows Scale"
        showZClabel.textColor = UIColor.systemBlue
        self.view.addSubview(showZClabel)
        let zclabelTopConstraint = showZClabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15)
        let zclabelLeadingConstraint = showZClabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let zclabelTrailingConstraint = showZClabel.leadingAnchor.constraint(equalTo: margins.trailingAnchor)
        zclabelTopConstraint.isActive = true
        zclabelLeadingConstraint.isActive = true
        zclabelTrailingConstraint.isActive = true
        showZClabel.isHidden = false
        
        // MARK: Show ZC switch
        showZCSwitch.center = CGPoint(x: 180, y: 270)
        showZCSwitch.tintColor = UIColor.systemBlue
        self.view.addSubview(showZCSwitch)
        showZCSwitch.addTarget(self, action: #selector(zcSwitchChanged), for: .touchUpInside)
        
    }

    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
            self.showBuildinglabel.textColor = UIColor.systemBlue
            self.showCompasslabel.textColor = UIColor.systemBlue
            self.showTrafficlabel.textColor = UIColor.systemBlue
            self.pointOfInterestLabel.textColor = UIColor.systemBlue
            self.showZClabel.textColor = UIColor.systemBlue
        case 1:
            mapView.mapType = .hybrid
            self.showBuildinglabel.textColor = UIColor.red
            self.showCompasslabel.textColor = UIColor.red
            self.showTrafficlabel.textColor = UIColor.red
            self.pointOfInterestLabel.textColor = UIColor.red
            self.showZClabel.textColor = UIColor.systemBlue
        case 2:
            mapView.mapType = .satellite
            self.showBuildinglabel.textColor = UIColor.purple
            self.showCompasslabel.textColor = UIColor.purple
            self.showTrafficlabel.textColor = UIColor.purple
            self.pointOfInterestLabel.textColor = UIColor.purple
            self.showZClabel.textColor = UIColor.purple
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
        let compassButton = MKCompassButton(mapView: mapView)   // Make a new compass
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
    
    @objc func togglePOISwitchChanged(){
        if pointOfInterestSwitch.isOn{
            mapView.pointOfInterestFilter?.includes(MKPointOfInterestCategory.airport)
            mapView.pointOfInterestFilter?.includes(MKPointOfInterestCategory.foodMarket)
            mapView.pointOfInterestFilter?.includes(MKPointOfInterestCategory.restaurant)
            mapView.pointOfInterestFilter?.includes(MKPointOfInterestCategory.cafe)
            mapView.pointOfInterestFilter?.includes(MKPointOfInterestCategory.park)
        }
        else {
            mapView.pointOfInterestFilter?.excludes(MKPointOfInterestCategory.airport)
            mapView.pointOfInterestFilter?.excludes(MKPointOfInterestCategory.foodMarket)
            mapView.pointOfInterestFilter?.excludes(MKPointOfInterestCategory.restaurant)
        }
    }
    
    @objc func zcSwitchChanged(){
        if showZCSwitch.isOn{
            mapView.showsScale = true
        }
        else{
            mapView.showsScale = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("Map VC loaded it's view")
    }
    
}
