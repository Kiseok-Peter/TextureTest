//
//  FlexBoxViewController.swift
//  TextureTest
//
//  Created by 박기석 on 2019/12/30.
//  Copyright © 2019 Peter. All rights reserved.
//

import AsyncDisplayKit

final class FlexBoxViewController: ASViewController<FlexBoxNode> {
    
    init() {
        super.init(node: FlexBoxNode.init())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
