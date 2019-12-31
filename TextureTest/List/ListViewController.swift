//
//  ListViewController.swift
//  TextureTest
//
//  Created by 박기석 on 2019/12/31.
//  Copyright © 2019 Peter. All rights reserved.
//

import AsyncDisplayKit

class ListViewController: ASViewController<ASTableNode> {
    
    var items: [String] = ["Welcome to Texture-KR",
                           "Welcome to Texture-KR",
                           "Welcome to Texture-KR, long test!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"]
    
    
    init() {
        super.init(node: ASTableNode.init(style: .plain))
        self.node.backgroundColor = .white
        self.node.dataSource = self
        self.node.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListViewController: ASTableDataSource {
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            let item = self.items[indexPath.row]
            return ListCellNode(item: item)
        }
    }
}

extension ListViewController: ASTableDelegate {
    
}
