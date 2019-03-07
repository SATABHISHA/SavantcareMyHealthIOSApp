//
//  MoodAddDetailsViewController.swift
//  MyHealth
//
//  Created by Satabhisha on 30/07/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit

class MoodAddFeelingsViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tvDescription: UITextView!
    
    @IBAction func btnSelectFeelings(_ sender: Any) {
        self.performSegue(withIdentifier: "feelings", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //=========code for placeholder inside viewDidLoad() starts==========
        tvDescription.text = "Describe what’s going on that may be"
        tvDescription.textColor = UIColor.lightGray
        tvDescription.font = UIFont(name: "verdana", size: 13.0)
        tvDescription.returnKeyType = .done
        tvDescription.delegate = self
        //=========code for placeholder inside viewDidLoad() ends===========
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //=============code for placeholder code starts========
    func textViewDidBeginEditing(_ textView: UITextView) {
        if tvDescription.text == "Describe what’s going on that may be"{
            tvDescription.text = ""
            tvDescription.textColor = UIColor.black
            tvDescription.font = UIFont(name: "verdana", size: 18.0)
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            tvDescription.resignFirstResponder()
        }
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Describe what’s going on that may be"
            textView.textColor = UIColor.lightGray
            textView.font = UIFont(name: "verdana", size: 13.0)
        }
    }
    //============code for placeholder code ends===========

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
