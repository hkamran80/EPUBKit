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
    func unarchive(archive url: URL, extractionDirectory destinationUrl: URL?) throws -> URL
}

class EPUBArchiveServiceImplementation: EPUBArchiveService {
    init() {
        Zip.addCustomFileExtension("epub")
    }

    func unarchive(archive url: URL, extractionDirectory extractionPathUrl: URL?) throws -> URL {
        var destination: URL

        do {
            if let extractionUrl = extractionPathUrl {
                try Zip.unzipFile(url, destination: extractionUrl, overwrite: true, password: nil, progress: nil)
                destination = extractionUrl
            } else {
                destination = try Zip.quickUnzipFile(url)
            }
        } catch {
            throw EPUBParserError.unzipFailed(reason: error)
        }

        return destination
    }
}
