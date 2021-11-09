//
//  ViewModelManager.swift
//  Instagrid
//
//  Created by Quentin on 27/10/2021.
//

import Foundation

// Manager class used to save the current viewModel utilized by the current view controller
class ViewModelManager {
    
    static let viewModel = LayoutViewModel()
    
    private init() {}
}
