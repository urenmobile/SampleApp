//
//  ReloadableChanges.swift
//  SampleApp
//
//  Created by Remzi YILDIRIM on 12/13/20.
//

import Foundation

struct ReloadableChanges {
    let insertItems: [IndexPath]
    let deleteItems: [IndexPath]
    let reloadItems: [IndexPath]
    let moveItems: [(from: IndexPath, to: IndexPath)]
}
