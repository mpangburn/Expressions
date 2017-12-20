import UIKit
import PlaygroundSupport


extension UIImage {
    public func saveToDocumentsDirectory(as name: String) {
        guard let data = UIImagePNGRepresentation(self) else { print("Could not obtain image data."); return }
        // To save properly, there must be a "Shared Playground Data" folder in Documents with the appropriate permissions set.
        let filename = playgroundSharedDataDirectory.appendingPathComponent(name)
        try! data.write(to: filename) // This will spit out the appropriate error in the Playground console if it occurs.
    }
}
