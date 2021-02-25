//
//  EPUBArchiveService.swift
//  EPUBKit
//
//  Created by Witek Bobrowski on 30/06/2018.
//  Copyright © 2018 Witek Bobrowski. All rights reserved.
//

import Foundation
import Zip

protocol EPUBArchiveService {
    func unarchive(archive url: URL) throws -> URL
}

class EPUBArchiveServiceImplementation: EPUBArchiveService {
    init() {
        Zip.addCustomFileExtension("epub")
    }

    func unarchive(archive url: URL, unarchiveDirectory destinationUrl: URL?) throws -> URL {
        var destination: URL

        do {
            if let destination = destinationUrl {
                destination = try Zip.unzipFile(url, destination: destination)
            } else {
                destination = try Zip.quickUnzipFile(url)
            }
        } catch {
            throw EPUBParserError.unzipFailed(reason: error)
        }

        return destination
    }
}
