//
//  PersistedPhoto.swift
//  PictureViewer
//
//  Created by H G on 2023/05/24.
//

import RealmSwift

class PersistedPhoto: Object {
    @Persisted var id: String = ""
    @Persisted var title: String = ""
    @Persisted var url_m: String

    override static func primaryKey() -> String? {
        return "id"
    }
}
