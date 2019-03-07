//
//  PopUpAddRequestViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 30/04/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit

class PopUpAddRequestViewController: UIViewController {
   
    
    
    
    @IBOutlet weak var view_popup: UIView!
    
    @IBOutlet weak var pickerTextField: UITextField!
    let salutations = ["Mr.", "Ms.", "Mrs."]
    
    var button=dropDownBtn()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor=UIColor.black.withAlphaComponent(0.8)
        view_popup.layer.cornerRadius=20
        
        //---code for picker-------
      /*  let pickerView=UIPickerView()
        pickerView.delegate=self
        pickerTextField.inputView=pickerView*/
        
        
        button=dropDownBtn.init(frame: CGRect(x:0,y:0,width:150,height:0))
        button.setTitle("Colors", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints=false
        self.view.addSubview(button)
        
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        button.centerYAnchor.constraint(equalTo:self.view.centerYAnchor).isActive=true
        
       
        
        button.widthAnchor.constraint(equalToConstant: 150).isActive=true
        button.heightAnchor.constraint(equalToConstant: 40).isActive=true
        
        button.dropView.dropDownOptions=["Hello","b"]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Sets number of columns in picker view
 /*   func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Sets the number of rows in the picker view
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return salutations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return salutations.count
    }
    // This function sets the text of the picker view to the content of the "salutations" array
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return salutations[row]
    }
    
    // When user selects an option, this function will set the text of the text field to reflect
    // the selected option.
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = salutations[row]
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    

}

protocol dropDownProtocol{
    func dropDownPressed(string : String)
}



//------------testing for dropdown---------
class dropDownBtn: UIButton, dropDownProtocol{
    
    var dropView=dropDownView()
    
    var height=NSLayoutConstraint()
    
    func dropDownPressed(string: String) {
         self.setTitle(string, for: .normal)
        self.dismissDropDown()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor.darkGray
        
        dropView=dropDownView.init(frame: CGRect.init(x:0, y:0, width:0, height:0))
        dropView.delegate=self
        dropView.translatesAutoresizingMaskIntoConstraints=false
       
        
    }
    
    override func didMoveToSuperview() {
        self.superview?.addSubview(dropView)
        self.superview?.bringSubview(toFront: dropView)
        dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive=true
        dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive=true
        dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive=true
        height=dropView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    var isOpen = false
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen == false{
            isOpen=true
            NSLayoutConstraint.deactivate([self.height])
            NSLayoutConstraint.activate([self.height])
            if self.dropView.tableView.contentSize.height > 150 {
                self.height.constant=150
            }else{
                self.height.constant=self.dropView.tableView.contentSize.height
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping:0.5, initialSpringVelocity:0.5, options: .curveEaseInOut, animations: {
                self.dropView.layoutIfNeeded()
                self.dropView.center.y += self.dropView.frame.height/2
            }, completion: nil)
        }else{
            isOpen=false
           NSLayoutConstraint.deactivate([self.height])
            self.height.constant=0
            NSLayoutConstraint.activate([self.height])
            UIView.animate(withDuration: 0.5, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations:{
                           self.dropView.center.y -= self.dropView.frame.height / 2
                            self.dropView.layoutIfNeeded()
            },completion: nil)
        }
    }
        func dismissDropDown(){
            isOpen=false
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant=0
            NSLayoutConstraint.activate([self.height])
            UIView.animate(withDuration: 0.5, delay:0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations:{
                self.dropView.center.y -= self.dropView.frame.height / 2
                self.dropView.layoutIfNeeded()
            },completion: nil)
        }
    
    
required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class dropDownView:UIView,UITableViewDelegate, UITableViewDataSource{
    var dropDownOptions=[String]()
    var tableView=UITableView()
    
    var delegate : dropDownProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.backgroundColor=UIColor.darkGray
        self.backgroundColor=UIColor.darkGray
        
        tableView.delegate=self
        tableView.dataSource=self
        
        tableView.translatesAutoresizingMaskIntoConstraints=false
        
        self.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive=true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive=true
         tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive=true
         tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive=true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell=UITableViewCell()
        cell.textLabel?.text=dropDownOptions[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.dropDownPressed(string: dropDownOptions[indexPath.row])
        print(dropDownOptions[indexPath.row])
    }
    
}




