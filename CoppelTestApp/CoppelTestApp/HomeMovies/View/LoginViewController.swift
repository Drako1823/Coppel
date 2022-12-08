//
//  LoginViewController.swift
//  coppelTestApp
//
//  Created by El Reymon . on 08/12/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var imgMovieDB: UIImageView!{
        didSet{
            imgMovieDB.contentMode = .redraw
            imgMovieDB.translatesAutoresizingMaskIntoConstraints = false
            imgMovieDB.layer.cornerRadius = 10
            imgMovieDB.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var txfUsername: UITextField!{
        didSet{
            txfUsername.delegate = self
        }
    }
    @IBOutlet weak var txfDrowssap: UITextField!{
        didSet{
            txfDrowssap.delegate = self
        }
    }
    @IBOutlet weak var btnDrowssap: UIButton!
    @IBOutlet weak var lblError: UILabel!{
        didSet{
            lblError.textColor = UIColor.rgb(red: 153, green: 0, blue: 0)
        }
    }
    
    lazy var enableEye = false
    lazy var vmToken = TokenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func loadSession() {
        self.vmToken.getSession(option: .sessionNew) { [weak self] error in
            guard let self = self else { return }
            if error.code.isSuccess{
                //                self.cllMovies.reloadData()
                self.present(AlertGeneric.simpleWith(message: "Todo chido en la session: \(error.code.description) "), animated: true, completion: nil)
                //                loadSession()
                
            }else{
                self.present(AlertGeneric.simpleWith(message: "Se genero un error: \(error.localizedDescription) "), animated: true, completion: nil)
            }
        }
    }
    
    func loadSessionLocal() {
        self.vmToken.loadSessionLocal(username: txfUsername.text ?? "", drowssap: txfDrowssap.text ?? "") { [weak self] error in
            guard let self = self else { return }
            if error.code.isSuccess{
                ProgressView.hideHUDAddedToWindow()
                self.lblError.text = ""
                UserDefaults.standard.setValue("\(self.txfUsername.text ?? "")", forKey: "userName")
                self.performSegue(withIdentifier: "SHOWHOMEMOVIESVC", sender: nil)
            }else{
                ProgressView.hideHUDAddedToWindow()
                self.lblError.text = error.localizedDescription
            }
        }
    }
    
    @IBAction func btnLogin(_ sender: UIButton) {
        
        if txfUsername.text?.isEmpty ?? true {
            self.present(AlertGeneric.simpleWith(message: "Ingresa tu Username"), animated: true, completion: nil)
        }else if txfDrowssap.text?.isEmpty ?? true {
            self.present(AlertGeneric.simpleWith(message: "Ingresa tu Password"), animated: true, completion: nil)

        }else {
            ProgressView.showHUDAddedToWindow()
            loadSessionLocal()
        }
        //        self.vmToken.getTokenKey(option: .apiKey, username: txfUsername.text ?? "", drowssap: txfDrowssap.text ?? "") { [weak self] error in
        //            guard let self = self else { return }
        //            if error.code.isSuccess{
        //
        //                self.loadSession()
        //
        //            }else{
        //                self.lblError.text = error.localizedDescription
        //            }
        //        }
        
        //        self.vmToken.getSession(option: .sessionNew) { [weak self] error in
        //            guard let self = self else { return }
        //            if error.code.isSuccess{
        //                print("Sesison id: \(UserDefaults.standard.string(forKey: "sessionID") ?? "")")
        ////                self.lblError.text = ""
        //                //                self.loadSession()
        //
        //            }else{
        //                self.lblError.text = error.localizedDescription
        //            }
        //        }
        //        lblError.text = "Invalid username and/or password: You did not provide a valid login"
    }
    
    @IBAction func btnShowDrowssap(_ sender: UIButton) {
        let eye: UIImage = UIImage(systemName: "eye.fill") ?? UIImage()
        let eyeFill: UIImage = UIImage(systemName: "eye.slash.fill") ?? UIImage()
        btnDrowssap.setImage(enableEye ? eye : eyeFill, for: .normal)
        txfDrowssap.isSecureTextEntry = enableEye ? true:false
        enableEye = !enableEye
        
    }
    
}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
