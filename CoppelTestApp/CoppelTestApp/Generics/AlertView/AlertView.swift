//
//  AlertView.swift
//  coppelTestApp
//
//  Created by El Reymon . on 06/12/22.
//

import UIKit

class AlertGeneric {
    
    //MARK: - Functions
    static func simpleWith(title        : String? = "The Movie DB",
                                  message      : String?,
                                  actionTitle  : String = "Aceptar",
                                  actionHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title         : title,
                                                message       : message ?? "",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title  : actionTitle,
                                                style  : .default,
                                                handler: actionHandler))
        return alertController
    }
    
    static func loadingViewAlert(title: String? = "Cargando...") -> UIAlertController {
        return UIAlertController(title: title, message: nil, preferredStyle: .alert)
    }
    
}
