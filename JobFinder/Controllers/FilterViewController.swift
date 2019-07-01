//
//  FilterViewController.swift
//  JobFinder
//
//  Created by Morus Tech on 29/06/2019.
//  Copyright © 2019 Nfonics. All rights reserved.
//

import UIKit
import GooglePlaces

//Protocol for done press with filter details
protocol FilterViewDelegate {
    func didCompleteWith(provider: Provider, position: Position, location: JLocation)
}
typealias JLocation = (location: String, lat: Double, lon: Double) //Universal Tuple for location details
class FilterViewController: UIViewController {
    typealias Providers = (title: String, provider: Provider) //Tuple for Provider
    typealias Positions = (title: String, position: Position) //Tuple for Posistion
    let providers:[Providers] = [Providers("All", Provider.all), Providers("GitHub", Provider.git), Providers("Government", Provider.gov)]
    let positions:[Positions] = [Positions("All", Position.all), Positions("Full time", Position.fulltime), Positions("Part time", Position.parttime)]
    var selectedType = ""
    var location: JLocation?
    @IBOutlet weak var positionPickerView: UIPickerView!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var providerPickerView: UIPickerView!
    var typePicker: UIPickerView?
    var delegate: FilterViewDelegate?
//    var selectedProvider: Provider?
    var isAll: Bool = true
    var postion: Position?
    var selectedPosition: Position?
    var selectedProvider: Provider?
    var isallPositions: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Filters"
        
        if selectedProvider == nil{
            selectedProvider = Provider.all
        }
        if postion == nil{
            postion = Position.all
        }
        self.textField.text = location?.location
        setupPicker()

    }

    func setupPicker(){
        //Setup picker view with default values 
        switch selectedProvider{
            case .all?:
            self.providerPickerView.selectRow(0, inComponent: 0, animated: false)
        case .git?:
            self.providerPickerView.selectRow(1, inComponent: 0, animated: false)
            break
        case .gov?:
            self.providerPickerView.selectRow(2, inComponent: 0, animated: false)
        case .none:
            break
        }
        
        switch selectedPosition{
        case .all?:
            self.positionPickerView.selectRow(0, inComponent: 0, animated: false)
        case .fulltime?:
            self.positionPickerView.selectRow(1, inComponent: 0, animated: false)
            break
        case .parttime?:
            self.positionPickerView.selectRow(2, inComponent: 0, animated: false)
        case .none:
            break
        }
    }
    
    @IBAction func didPressDone(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        //Delegate
        delegate?.didCompleteWith(provider: selectedProvider!, position: selectedPosition!, location: location!)
    }
    
    @IBAction func didPressCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func textFieldDidTap(_ sender: Any) {
        //Open GSM autocomplete location seach field
        textField.resignFirstResponder()
        let gsmVC = GMSAutocompleteViewController()
        gsmVC.delegate = self
        present(gsmVC, animated: true, completion: nil)
    }
}

extension FilterViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag{
        case 100:
            return positions.count
        case 101:
            return providers.count
        default:
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag{
        case 100:
            return positions[row].title
        case 101:
            return providers[row].title
        default:
            return ""
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView.tag{
        case 100:
            selectedPosition = positions[row].position
        case 101:
            selectedProvider = providers[row].provider
        default:
            break
        }
    }
}

extension FilterViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        // Get the place name from 'GMSAutocompleteViewController'
        // Then display the name in textField
        textField.text = place.name
        location = (place.name, place.coordinate.latitude, place.coordinate.longitude) as? JLocation
        // Dismiss the GMSAutocompleteViewController when something is selected
        dismiss(animated: true, completion: nil)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // Handle the error
        print("Error: ", error.localizedDescription)
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        // Dismiss when the user canceled the action
        dismiss(animated: true, completion: nil)
    }
}
