// Models.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

protocol JSONEncodable {
    func encodeToJSON() -> Any
}

public enum ErrorResponse : Error {
    case Error(Int, Data?, Error)
}

open class Response<T> {
    open let statusCode: Int
    open let header: [String: String]
    open let body: T?

    public init(statusCode: Int, header: [String: String], body: T?) {
        self.statusCode = statusCode
        self.header = header
        self.body = body
    }

    public convenience init(response: HTTPURLResponse, body: T?) {
        let rawHeader = response.allHeaderFields
        var header = [String:String]()
        for (key, value) in rawHeader {
            header[key as! String] = value as? String
        }
        self.init(statusCode: response.statusCode, header: header, body: body)
    }
}

private var once = Int()
class Decoders {
    static fileprivate var decoders = Dictionary<String, ((AnyObject) -> AnyObject)>()

    static func addDecoder<T>(clazz: T.Type, decoder: @escaping ((AnyObject) -> T)) {
        let key = "\(T.self)"
        decoders[key] = { decoder($0) as AnyObject }
    }

    static func decode<T>(clazz: T.Type, discriminator: String, source: AnyObject) -> T {
        let key = discriminator;
        if let decoder = decoders[key] {
            return decoder(source) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }

    static func decode<T>(clazz: [T].Type, source: AnyObject) -> [T] {
        let array = source as! [AnyObject]
        return array.map { Decoders.decode(clazz: T.self, source: $0) }
    }

    static func decode<T, Key: Hashable>(clazz: [Key:T].Type, source: AnyObject) -> [Key:T] {
        let sourceDictionary = source as! [Key: AnyObject]
        var dictionary = [Key:T]()
        for (key, value) in sourceDictionary {
            dictionary[key] = Decoders.decode(clazz: T.self, source: value)
        }
        return dictionary
    }

    static func decode<T>(clazz: T.Type, source: AnyObject) -> T {
        initialize()
        if T.self is Int32.Type && source is NSNumber {
            return source.int32Value as! T;
        }
        if T.self is Int64.Type && source is NSNumber {
            return source.int64Value as! T;
        }
        if T.self is UUID.Type && source is String {
            return UUID(uuidString: source as! String) as! T
        }
        if source is T {
            return source as! T
        }
        if T.self is Data.Type && source is String {
            return Data(base64Encoded: source as! String) as! T
        }

        let key = "\(T.self)"
        if let decoder = decoders[key] {
           return decoder(source) as! T
        } else {
            fatalError("Source \(source) is not convertible to type \(clazz): Maybe swagger file is insufficient")
        }
    }

    static func decodeOptional<T>(clazz: T.Type, source: AnyObject?) -> T? {
        if source is NSNull {
            return nil
        }
        return source.map { (source: AnyObject) -> T in
            Decoders.decode(clazz: clazz, source: source)
        }
    }

    static func decodeOptional<T>(clazz: [T].Type, source: AnyObject?) -> [T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    static func decodeOptional<T, Key: Hashable>(clazz: [Key:T].Type, source: AnyObject?) -> [Key:T]? {
        if source is NSNull {
            return nil
        }
        return source.map { (someSource: AnyObject) -> [Key:T] in
            Decoders.decode(clazz: clazz, source: someSource)
        }
    }

    private static var __once: () = {
        let formatters = [
            "yyyy-MM-dd",
            "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ss'Z'",
            "yyyy-MM-dd'T'HH:mm:ss.SSS"
        ].map { (format: String) -> DateFormatter in
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter
        }
        // Decoder for Date
        Decoders.addDecoder(clazz: Date.self) { (source: AnyObject) -> Date in
           if let sourceString = source as? String {
                for formatter in formatters {
                    if let date = formatter.date(from: sourceString) {
                        return date
                    }
                }
            }
            if let sourceInt = source as? Int {
                // treat as a java date
                return Date(timeIntervalSince1970: Double(sourceInt / 1000) )
            }
            fatalError("formatter failed to parse \(source)")
        } 

        // Decoder for [Edge]
        Decoders.addDecoder(clazz: [Edge].self) { (source: AnyObject) -> [Edge] in
            return Decoders.decode(clazz: [Edge].self, source: source)
        }
        // Decoder for Edge
        Decoders.addDecoder(clazz: Edge.self) { (source: AnyObject) -> Edge in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = Edge()
            instance.id = Decoders.decodeOptional(clazz: UUID.self, source: sourceDictionary["id"] as AnyObject?)
            instance.head = Decoders.decodeOptional(clazz: UUID.self, source: sourceDictionary["head"] as AnyObject?)
            instance.tail = Decoders.decodeOptional(clazz: UUID.self, source: sourceDictionary["tail"] as AnyObject?)
            instance._class = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["class"] as AnyObject?)
            return instance
        }


        // Decoder for [InlineResponse200]
        Decoders.addDecoder(clazz: [InlineResponse200].self) { (source: AnyObject) -> [InlineResponse200] in
            return Decoders.decode(clazz: [InlineResponse200].self, source: source)
        }
        // Decoder for InlineResponse200
        Decoders.addDecoder(clazz: InlineResponse200.self) { (source: AnyObject) -> InlineResponse200 in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = InlineResponse200()
            instance.id = Decoders.decodeOptional(clazz: UUID.self, source: sourceDictionary["id"] as AnyObject?)
            instance._class = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["class"] as AnyObject?)
            return instance
        }


        // Decoder for [InlineResponse2001]
        Decoders.addDecoder(clazz: [InlineResponse2001].self) { (source: AnyObject) -> [InlineResponse2001] in
            return Decoders.decode(clazz: [InlineResponse2001].self, source: source)
        }
        // Decoder for InlineResponse2001
        Decoders.addDecoder(clazz: InlineResponse2001.self) { (source: AnyObject) -> InlineResponse2001 in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = InlineResponse2001()
            instance.id = Decoders.decodeOptional(clazz: UUID.self, source: sourceDictionary["id"] as AnyObject?)
            instance._class = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["class"] as AnyObject?)
            return instance
        }


        // Decoder for [InlineResponse2002]
        Decoders.addDecoder(clazz: [InlineResponse2002].self) { (source: AnyObject) -> [InlineResponse2002] in
            return Decoders.decode(clazz: [InlineResponse2002].self, source: source)
        }
        // Decoder for InlineResponse2002
        Decoders.addDecoder(clazz: InlineResponse2002.self) { (source: AnyObject) -> InlineResponse2002 in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = InlineResponse2002()
            instance.id = Decoders.decodeOptional(clazz: UUID.self, source: sourceDictionary["id"] as AnyObject?)
            instance._class = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["class"] as AnyObject?)
            return instance
        }


        // Decoder for [InlineResponse2003]
        Decoders.addDecoder(clazz: [InlineResponse2003].self) { (source: AnyObject) -> [InlineResponse2003] in
            return Decoders.decode(clazz: [InlineResponse2003].self, source: source)
        }
        // Decoder for InlineResponse2003
        Decoders.addDecoder(clazz: InlineResponse2003.self) { (source: AnyObject) -> InlineResponse2003 in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = InlineResponse2003()
            instance.from = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["from"] as AnyObject?)
            instance.to = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["to"] as AnyObject?)
            instance._in = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["in"] as AnyObject?)
            instance.out = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["out"] as AnyObject?)
            return instance
        }


        // Decoder for [InlineResponse2003In]
        Decoders.addDecoder(clazz: [InlineResponse2003In].self) { (source: AnyObject) -> [InlineResponse2003In] in
            return Decoders.decode(clazz: [InlineResponse2003In].self, source: source)
        }
        // Decoder for InlineResponse2003In
        Decoders.addDecoder(clazz: InlineResponse2003In.self) { (source: AnyObject) -> InlineResponse2003In in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = InlineResponse2003In()
            instance._5f9e769ff6fe4cee02b3b4547200db6b = Decoders.decodeOptional(clazz: NodeEdge.self, source: sourceDictionary["5f9e769ff6fe4cee02b3b4547200db6b"] as AnyObject?)
            return instance
        }


        // Decoder for [InlineResponse2004]
        Decoders.addDecoder(clazz: [InlineResponse2004].self) { (source: AnyObject) -> [InlineResponse2004] in
            return Decoders.decode(clazz: [InlineResponse2004].self, source: source)
        }
        // Decoder for InlineResponse2004
        Decoders.addDecoder(clazz: InlineResponse2004.self) { (source: AnyObject) -> InlineResponse2004 in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = InlineResponse2004()
            instance.success = Decoders.decodeOptional(clazz: Bool.self, source: sourceDictionary["success"] as AnyObject?)
            return instance
        }


        // Decoder for [Node]
        Decoders.addDecoder(clazz: [Node].self) { (source: AnyObject) -> [Node] in
            return Decoders.decode(clazz: [Node].self, source: source)
        }
        // Decoder for Node
        Decoders.addDecoder(clazz: Node.self) { (source: AnyObject) -> Node in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = Node()
            instance.id = Decoders.decodeOptional(clazz: UUID.self, source: sourceDictionary["id"] as AnyObject?)
            instance.context = Decoders.decodeOptional(clazz: UUID.self, source: sourceDictionary["context"] as AnyObject?)
            instance.creator = Decoders.decodeOptional(clazz: UUID.self, source: sourceDictionary["creator"] as AnyObject?)
            instance._class = Decoders.decodeOptional(clazz: String.self, source: sourceDictionary["class"] as AnyObject?)
            return instance
        }


        // Decoder for [NodeEdge]
        Decoders.addDecoder(clazz: [NodeEdge].self) { (source: AnyObject) -> [NodeEdge] in
            return Decoders.decode(clazz: [NodeEdge].self, source: source)
        }
        // Decoder for NodeEdge
        Decoders.addDecoder(clazz: NodeEdge.self) { (source: AnyObject) -> NodeEdge in
            let sourceDictionary = source as! [AnyHashable: Any]

            let instance = NodeEdge()
            instance.id = Decoders.decodeOptional(clazz: UUID.self, source: sourceDictionary["id"] as AnyObject?)
            instance.classes = Decoders.decodeOptional(clazz: Array.self, source: sourceDictionary["classes"] as AnyObject?)
            return instance
        }
    }()

    static fileprivate func initialize() {
        _ = Decoders.__once
    }
}
