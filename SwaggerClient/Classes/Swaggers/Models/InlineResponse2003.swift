//
// InlineResponse2003.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


open class InlineResponse2003: JSONEncodable {
    public var from: [NodeEdge]?
    public var to: [NodeEdge]?
    public var _in: [InlineResponse2003In]?
    public var out: [InlineResponse2003In]?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["from"] = self.from?.encodeToJSON()
        nillableDictionary["to"] = self.to?.encodeToJSON()
        nillableDictionary["in"] = self._in?.encodeToJSON()
        nillableDictionary["out"] = self.out?.encodeToJSON()
        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}