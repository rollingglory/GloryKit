//
//  GloryView.swift
//  GloryKit
//
//  Created by Krisnandika Aji on 16/10/19.
//  Copyright © 2019 Krisnandika Aji. All rights reserved.
//

import Foundation
import SnapKit

/// GloryKit base UIView class made to better maintain
/// consistent UIView structure and ez helper methods.
/// Must be companied by a .xib file attached to it.
open class GloryView: UIView {
    
    /// Required init override method
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// Required code init method
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    /// Method called at the very first life cycle
    /// as soon as the class is initialized. Loads
    /// a .xib bundle named with the same name as the class.
    private func commonInit() {
        if let content = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            backgroundColor = content.backgroundColor
            addSubview(content)
            sendSubviewToBack(content)
            content.snp.makeConstraints({ (make) in
                make.left.right.top.bottom.equalTo(self)
            })
        }
    }
}
