//
//  ViewController.swift
//  learnUIKit_1
//
//  Created by Евгений Тарасов on 23/09/2019.
//  Copyright © 2019 Евгений Тарасов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var mySlider: UISlider!
    @IBOutlet var textField: UITextField!
    @IBOutlet var buttonDone: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var switchHide: UISwitch!
    @IBOutlet var switchLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    
    @IBAction func segmentedControlAction() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            mainLabel.text = "The first segment is selected"
            mainLabel.textColor = .red
        case 1:
            mainLabel.text = "The second segment is selected"
            mainLabel.textColor = .green
        case 2:
            mainLabel.text = "The third segment is yellow"
            mainLabel.textColor = .yellow
        default:
            break
        }
    }
    
    // Ранее мы создавали оутлет, который можно было бы использовать вместо sender. Т.е. параметр sender получает значение из слайдера, и уже его можно использовать в реализации функции (метода)
    
    @IBAction func sliderAction(_ sender: UISlider) {
        mainLabel.text = String(sender.value)
        
        // меняем цвет viewController
        let backgroundColor = view.backgroundColor
        view.backgroundColor = backgroundColor?.withAlphaComponent(CGFloat(mySlider.value))
    }
    
    
    @IBAction func donePressed() {
        guard let inputText = textField.text, !inputText.isEmpty else { return }
        
        
        if let _ = Double(inputText) {
            showAlert(title: "Wrong format", message: "Pleas enter correct format, don't numbers.")
        } else {
            mainLabel.text = textField.text
            textField.text = nil
        }
    }
    
    
    @IBAction func changeDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        let currentDate = dateFormatter.string(from: datePicker.date)
        mainLabel.text = currentDate
        
    }
    
    
    @IBAction func switchAction() {
        segmentedControl.isHidden.toggle()
        mainLabel.isHidden.toggle()
        mySlider.isHidden.toggle()
        textField.isHidden.toggle()
        buttonDone.isHidden.toggle()
        datePicker.isHidden.toggle()

        switchLabel.text = switchHide.isOn ? "Show all elements" : "Hide all elements"
        
    }
    
    
    
}



extension ViewController {
    private func setupView() {
        
        
        mainLabel.font = mainLabel.font.withSize(35)
        mainLabel.textAlignment = .center
        mainLabel.numberOfLines = 2
//        mainLabel.isHidden = true
        
        
        // в сегментед контроле в методе insertSegmented в последнем параметре лучше поставить false, потому как этим мы указываем анимацию, которая должна сработать в методе, который только только загрузился в память, и только вконце отобразит данные на экране. соответственно, пользователь не увидит анимации
        segmentedControl.insertSegment(withTitle: "Third", at: 2, animated: false)
        
        
        mySlider.value = 1
        mySlider.minimumValue = 0
        mySlider.maximumValue = 1
        mySlider.minimumTrackTintColor = .green
        mySlider.maximumTrackTintColor = .red
        mySlider.thumbTintColor = .white
        
        
        // данную строку ставим последней, потому как изначально в нее летят значения из сториборда, а сейчас будут значения после наших манипуляций
        mainLabel.text = String(mySlider.value)
        
        // Русифицируем datePicker
        datePicker.locale = Locale(identifier: "ru_RU")
            // Локализация под язык текущей операционки устройства
            // datePicker.locale = Locale.current
        
        switchLabel.text = "Hide all elements"
        switchHide.onTintColor = .purple
        
    }
    
    private func showAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            self.textField.text = nil
        }
        
        ac.addAction(okAction)
        present(ac, animated: true)
    }

}

