import Foundation
import Yaap

enum MissingInputError: LocalizedError {
    case missingInputOrPasteboard

    var errorDescription: String? {
        return "The tool needs a filepath or a valid copy in Pasteboard"
    }
}

struct LoadFileError: LocalizedError {
    let path: String

    var errorDescription: String? {
        return "Loading the file from \(path) failed"
    }
}

struct SaveFileError: LocalizedError {
    let path: String

    var errorDescription: String? {
        return "Saving the output to \(path) failed"
    }
}

struct ParsingFailedError: LocalizedError {
    let path: String

    var errorDescription: String? {
        return "The file at \(path) doesn't contain a valid Instruments deep copy"
    }
}
