//
//  MovieViewController.swift
//  TextureTest
//
//  Created by 박기석 on 2019/12/31.
//  Copyright © 2019 Peter. All rights reserved.
//

import AsyncDisplayKit

class MovieViewController: ASViewController<MovieSearchNode> {
    
    var disposeBag = DisposeBag()
    
    var items: [MovieItem] = [] {
        didSet {
            node.tableNode.reloadData()
        }
    }
    
    init() {
        super.init(node: MovieSearchNode.init())
        ASDisplayNode.shouldShowRangeDebugOverlay = true
        node.tableNode.dataSource = self
        node.tableNode.delegate = self
        node.searchBar?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieViewController: ASTableDataSource {
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            let item = self.items[indexPath.row]
            return MovieCellNode(item: item)
        }
    }
}

extension MovieViewController: ASTableDelegate {
    
}

extension MovieViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Observable<String>.just(searchText)
            .flatMap { NetworkService.shared.request(.search($0)) }
            .map { MovieModel(JSONString: $0) }
            .filterNil()
            .map { $0.items }
            .subscribe(onNext: { [weak self] in
                self?.items = $0
            })
            .disposed(by: self.disposeBag)
    }
}
