import UniquelyTypedID
import Foundation

struct Chili {
  @UniquelyTypedID(String.self) public let id: ID
  let heatLevel: Int
  let name: String
}

// The generated ID conforms to `ExpressibleByStringLiteral`
let chili = Chili(id: "jalapeño", heatLevel: 2, name: "Jalapeño")
print("Chili ID:", chili.id)
/* Output
 Chili ID: jalapeño
 */

// MARK: -
print("---")
/// Default to UUID. The name of the type is
/// used to name the generated type
struct Tomato {
  @UniquelyTypedID public let id: MyUUID
  let name: String
}
let tomato = Tomato(id: .init(), name: "Roma")
print("Tomato ID:", tomato.id)
/* Output
 Tomato ID: 18E4399F-E8AE-4326-8C2E-C40645119DB9
 */


// MARK: -
print("---")
// Integer
struct Aubergine: Codable {
  @UniquelyTypedID(Int.self) let id: ID
  let name: String
}

let aubergineID: Aubergine.ID = 3
print("Aubergine ID:", aubergineID)

let aubergine = Aubergine(id: aubergineID, name: "Fairy Tale")
let jsonEncoder = JSONEncoder()
jsonEncoder.outputFormatting = .prettyPrinted
print("Aubergine JSON:", String(data: try jsonEncoder.encode(aubergine), encoding: .utf8)!)

/* Output
 Aubergine ID: 3
 Aubergine JSON: {
   "id" : 3,
   "name" : "Fairy Tale"
 }
 */

// MARK: -
print("---")

struct Vegetable: Codable {
  @UniquelyTypedID(String.self) let scientificName: ScientificName
  let name: String
}

let vegetable = Vegetable(scientificName: "Capsicum annuum", name: "Chili")
print("Vegetable JSON:", String(data: try jsonEncoder.encode(vegetable), encoding: .utf8)!)
/* Output
 Vegetable JSON: {
   "name" : "Chili",
   "scientificName" : "Capsicum annuum"
 }
*/
