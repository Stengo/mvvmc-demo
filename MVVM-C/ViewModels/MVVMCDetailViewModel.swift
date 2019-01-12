//
//  MVVMCDetailViewModel.swift
//  MVVM-C
//
//  Created by Scotty on 21/05/2016.
//  Copyright © 2016 Streambyte Limited. All rights reserved.
//

import Foundation


class MVVMCDetailViewModel: DetailViewModel
{
    weak var viewDelegate: DetailViewModelViewDelegate?
    weak var coordinatorDelegate: DetailViewModelCoordinatorDelegate?
    
    private(set) var detail: DataItem? {
        didSet {
            viewDelegate?.detailDidChange(viewModel: self)
        }
    }
    
    var model: DetailModel? {
        didSet {
            model?.detail(completionHandler: { (item) in
                self.detail = item
            })
        }
    }
    
    func done() {
        coordinatorDelegate?.detailViewModelDidEnd(viewModel: self)
    }
    
}
