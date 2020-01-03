//
//  SearchNode.swift
//  TextureTest
//
//  Created by 박기석 on 2019/12/31.
//  Copyright © 2019 Peter. All rights reserved.
//

import AsyncDisplayKit

class SearchNode: ASDisplayNode {
    
    // MARK: UI Properties
    
    var searchBar: UISearchBar? {
        return self.view as? UISearchBar
    }
    
    // MARK: Node Life Cycle
    
    override init() {
        super.init()
        setViewBlock {
            let view = UISearchBar()
            return view
        }
    }
}
