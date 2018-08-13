//
//  Bundle+LoadNib.swift
//  CoMotion
//
//  Created by Yoon, Kyle on 7/20/18.
//  Copyright © 2018 Yoon, Kyle. All rights reserved.
//

import UIKit

extension Bundle {
    
    static func com_loadNib<T: UIView>(_ aClass: T.Type) -> T {
        guard let viewFromNib = Bundle(for: T.self).loadNibNamed(String(describing: T.self),
                                                                 owner: nil,
                                                                 options: nil)?.first as? T else {
                                                                    fatalError("Could not load view from nib!")
        }
        
        return viewFromNib
    }
    
}
