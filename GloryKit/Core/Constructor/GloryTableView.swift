//
//  GloryTableView.swift
//  GloryKit
//
//  Created by Rolling Glory on 16/12/19.
//  Copyright © 2019 Rolling Glory. All rights reserved.
//

import Foundation
import SnapKit
import SkeletonView
import RxSwift
import RxCocoa

/// GloryTableView base class
final public class GloryTableView: UITableView {
    
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        rowHeight = UITableView.automaticDimension
        separatorStyle = .none
        tableFooterView = UIView()
    }
    
    // MARK: Refresh Control
    func addRefreshControl(disposeBag: DisposeBag, forEvent event: @escaping (() -> Void)) {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .clear
        refreshControl.tintColor = .gray
        
        refreshControl.rx
            .controlEvent(.valueChanged)
            .subscribe(onNext: { (next) in
                event()
            }).disposed(by: disposeBag)
        
        self.refreshControl = refreshControl
    }
}
