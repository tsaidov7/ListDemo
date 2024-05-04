//
//  String+extension.swift
//  UITableViewDemo
//
//  Created by Timur Saidov on 04.05.2024.
//

import UIKit

extension String {

    static func random(length: Int) -> Self {
        let base = "абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"
        var randomString: String = ""

        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }

        return randomString
    }
}
