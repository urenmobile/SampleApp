//
//  ProductCoreDataProvider.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/13/20.
//

import Foundation
import URENCombine

protocol ProductCoreDataProvider: AnyObject {
    var reloadableChangesSubject: PassthroughSubject<ReloadableChanges, Never> { get }
    func performFetch()
    func numberOfSection() -> Int
    func numberOfItemsInSection(_ section: Int) -> Int
    func willDisplayItem(at indexPath: IndexPath)
    func item(at indexPath: IndexPath) -> ProductEntity
}
