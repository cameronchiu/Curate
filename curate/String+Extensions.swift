//
//  String+Extentions.swift
//  LearnSearch
//
//  Created by Mohammad Azam on 6/22/21.
//

import Foundation

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
