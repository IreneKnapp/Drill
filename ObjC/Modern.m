//
//  Modern.m
//  Drill
//
//  Created by Irene Knapp on 8/23/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "Modern.h"

@implementation Modern

+ (Modern *) makeInt8: (int8_t) value {
    Modern *result = [[Modern alloc] initWithNodeType: int8ValueModernNodeType];
    if(result) {
        [result setInt8Value: value];
    }
    return result;
}


+ (Modern *) makeInt16: (int16_t) value {
    Modern *result = [[Modern alloc] initWithNodeType: int16ValueModernNodeType];
    if(result) {
        [result setInt16Value: value];
    }
    return result;
}


+ (Modern *) makeInt32: (int32_t) value {
    Modern *result = [[Modern alloc] initWithNodeType: int32ValueModernNodeType];
    if(result) {
        [result setInt32Value: value];
    }
    return result;
}


+ (Modern *) makeInt64: (int64_t) value {
    Modern *result = [[Modern alloc] initWithNodeType: int64ValueModernNodeType];
    if(result) {
        [result setInt64Value: value];
    }
    return result;
}


+ (Modern *) makeNat8: (uint8_t) value {
    Modern *result = [[Modern alloc] initWithNodeType: nat8ValueModernNodeType];
    if(result) {
        [result setNat8Value: value];
    }
    return result;
}


+ (Modern *) makeNat16: (uint16_t) value {
    Modern *result = [[Modern alloc] initWithNodeType: nat16ValueModernNodeType];
    if(result) {
        [result setNat16Value: value];
    }
    return result;
}


+ (Modern *) makeNat32: (uint32_t) value {
    Modern *result = [[Modern alloc] initWithNodeType: nat32ValueModernNodeType];
    if(result) {
        [result setNat32Value: value];
    }
    return result;
}


+ (Modern *) makeNat64: (uint64_t) value {
    Modern *result = [[Modern alloc] initWithNodeType: nat64ValueModernNodeType];
    if(result) {
        [result setNat64Value: value];
    }
    return result;
}


+ (Modern *) makeFloat32: (float) value {
    Modern *result = [[Modern alloc] initWithNodeType: float32ValueModernNodeType];
    if(result) {
        [result setFloat32Value: value];
    }
    return result;
}


+ (Modern *) makeFloat64: (double) value {
    Modern *result = [[Modern alloc] initWithNodeType: float64ValueModernNodeType];
    if(result) {
        [result setFloat64Value: value];
    }
    return result;
}


+ (Modern *) makeFloat128: (long double) value {
    Modern *result = [[Modern alloc] initWithNodeType: float128ValueModernNodeType];
    if(result) {
        [result setFloat128Value: value];
    }
    return result;
}


+ (Modern *) makeUTF8: (NSString *) value {
    Modern *result = [[Modern alloc] initWithNodeType: utf8ValueModernNodeType];
    if(result) {
        [result setUTF8Value: value];
    }
    return result;
}


+ (Modern *) makeBlob: (NSData *) value {
    Modern *result = [[Modern alloc] initWithNodeType: blobValueModernNodeType];
    if(result) {
        [result setBlobValue: value];
    }
    return result;
}


+ (Modern *) makeSigmaValueOfType: (Modern *) type
             fieldValue: (Modern *) fieldValue
             successor: (Modern *) successorValue
{
    Modern *result = [[Modern alloc] initWithNodeType: sigmaValueModernNodeType];
    if(result) {
        [result setSigmaValueType: type];
        [result setSigmaValue: fieldValue];
        [result setSigmaSuccessor: successorValue];
    }
    return result;
}


+ (Modern *) makeNamedValueOfType: (Modern *) type
             value: (Modern *) value
{
    Modern *result = [[Modern alloc] initWithNodeType: namedValueModernNodeType];
    if(result) {
        [result setNamedValueType: type];
        [result setNamedValue: value];
    }
    return result;
}


+ (Modern *) makeInt8Type {
    Modern *result = [[Modern alloc] initWithNodeType: int8TypeModernNodeType];
    return result;
}


+ (Modern *) makeInt16Type {
    Modern *result = [[Modern alloc] initWithNodeType: int16TypeModernNodeType];
    return result;
}


+ (Modern *) makeInt32Type {
    Modern *result = [[Modern alloc] initWithNodeType: int32TypeModernNodeType];
    return result;
}


+ (Modern *) makeInt64Type {
    Modern *result = [[Modern alloc] initWithNodeType: int64TypeModernNodeType];
    return result;
}


+ (Modern *) makeNat8Type {
    Modern *result = [[Modern alloc] initWithNodeType: nat8TypeModernNodeType];
    return result;
}


+ (Modern *) makeNat16Type {
    Modern *result = [[Modern alloc] initWithNodeType: nat16TypeModernNodeType];
    return result;
}


+ (Modern *) makeNat32Type {
    Modern *result = [[Modern alloc] initWithNodeType: nat32TypeModernNodeType];
    return result;
}


+ (Modern *) makeNat64Type {
    Modern *result = [[Modern alloc] initWithNodeType: nat64TypeModernNodeType];
    return result;
}


+ (Modern *) makeFloat32Type {
    Modern *result = [[Modern alloc] initWithNodeType: float32TypeModernNodeType];
    return result;
}


+ (Modern *) makeFloat64Type {
    Modern *result = [[Modern alloc] initWithNodeType: float64TypeModernNodeType];
    return result;
}


+ (Modern *) makeFloat128Type {
    Modern *result = [[Modern alloc] initWithNodeType: float128TypeModernNodeType];
    return result;
}


+ (Modern *) makeUTF8Type {
    Modern *result = [[Modern alloc] initWithNodeType: utf8TypeModernNodeType];
    return result;
}


+ (Modern *) makeBlobType {
    Modern *result = [[Modern alloc] initWithNodeType: blobTypeModernNodeType];
    return result;
}


+ (Modern *) makeSigmaType: (Modern *) type
             fieldType: (Modern *) fieldType
             successor: (Modern *) successor
{
    Modern *result = [[Modern alloc] initWithNodeType: sigmaTypeModernNodeType];
    return result;
}


+ (Modern *) makeNamedType: (NSString *) name
             contentType: (Modern *) contentType
{
    Modern *result = [[Modern alloc] initWithNodeType: namedTypeModernNodeType];
    return result;
}


+ (Modern *) makeUniverseType: (uint64_t) level {
    Modern *result = [[Modern alloc] initWithNodeType: universeTypeModernNodeType];
    if(result) {
        [result setUniverseTypeLevel: level];
    }
    return result;
}


- (id) initWithNodeType: (ModernNodeType) nodeType {
    self = [super init];
    if(self) {
        _nodeType = nodeType;
        _valueType = nil;
    }
    return self;
}


- (ModernNodeType) nodeType {
    return _nodeType;
}


- (Modern *) valueType {
    if(!_valueType) {
        switch(_nodeType) {
        case int8ValueModernNodeType: return [Modern makeInt8Type];
        case int16ValueModernNodeType: return [Modern makeInt16Type];
        case int32ValueModernNodeType: return [Modern makeInt32Type];
        case int64ValueModernNodeType: return [Modern makeInt64Type];
        case nat8ValueModernNodeType: return [Modern makeNat8Type];
        case nat16ValueModernNodeType: return [Modern makeNat16Type];
        case nat32ValueModernNodeType: return [Modern makeNat32Type];
        case nat64ValueModernNodeType: return [Modern makeNat64Type];
        case float32ValueModernNodeType: return [Modern makeFloat32Type];
        case float64ValueModernNodeType: return [Modern makeFloat64Type];
        case float128ValueModernNodeType: return [Modern makeFloat128Type];
        case utf8ValueModernNodeType: return [Modern makeUTF8Type];
        case blobValueModernNodeType: return [Modern makeBlobType];
        case sigmaValueModernNodeType: return nil;
        case namedValueModernNodeType: return nil;
        case int8TypeModernNodeType:
        case int16TypeModernNodeType:
        case int32TypeModernNodeType:
        case int64TypeModernNodeType:
        case nat8TypeModernNodeType:
        case nat16TypeModernNodeType:
        case nat32TypeModernNodeType:
        case nat64TypeModernNodeType:
        case float32TypeModernNodeType:
        case float64TypeModernNodeType:
        case float128TypeModernNodeType:
        case utf8TypeModernNodeType:
        case blobTypeModernNodeType:
        case sigmaTypeModernNodeType:
        case namedTypeModernNodeType:
            return [Modern makeUniverseType: 0];
        case universeTypeModernNodeType:
            if(_universeTypeLevel < UINT64_MAX) {
                return [Modern makeUniverseType:
                            _universeTypeLevel + 1];
            } else {
                return nil;
            }
        }
    }
    return _valueType;
}


- (int8_t) int8Value {
    return _int8Value;
}


- (int16_t) int16Value {
    return _int16Value;
}


- (int32_t) int32Value {
    return _int32Value;
}


- (int64_t) int64Value {
    return _int64Value;
}


- (uint8_t) nat8Value {
    return _nat8Value;
}


- (uint16_t) nat16Value {
    return _nat16Value;
}


- (uint32_t) nat32Value {
    return _nat32Value;
}


- (uint64_t) nat64Value {
    return _nat64Value;
}


- (float) float32Value {
    return _float32Value;
}


- (double) float64Value {
    return _float64Value;
}


- (long double) float128Value {
    return _float128Value;
}


- (NSString *) utf8Value {
    return _utf8Value;
}


- (NSData *) blobValue {
    return _blobValue;
}


- (Modern *) sigmaValue {
    return _sigmaValueFieldValue;
}


- (Modern *) sigmaSuccessor {
    return _sigmaValueSuccessor;
}


- (Modern *) namedValue {
    return _namedValueValue;
}


- (NSString *) namedTypeName {
    return _namedTypeName;
}


- (Modern *) namedTypeContentType {
    return _namedTypeContentType;
}


- (uint64_t) universeTypeLevel {
    return _universeTypeLevel;
}


- (void) setInt8Value: (int8_t) value {
    _int8Value = value;
}


- (void) setInt16Value: (int16_t) value {
    _int16Value = value;
}


- (void) setInt32Value: (int32_t) value {
    _int32Value = value;
}


- (void) setInt64Value: (int64_t) value {
    _int64Value = value;
}


- (void) setNat8Value: (uint8_t) value {
    _nat8Value = value;
}


- (void) setNat16Value: (uint16_t) value {
    _nat16Value = value;
}


- (void) setNat32Value: (uint32_t) value {
    _nat32Value = value;
}


- (void) setNat64Value: (uint64_t) value {
    _nat64Value = value;
}


- (void) setFloat32Value: (float) value {
    _float32Value = value;
}


- (void) setFloat64Value: (double) value {
    _float64Value = value;
}


- (void) setFloat128Value: (long double) value {
    _float128Value = value;
}


- (void) setUTF8Value: (NSString *) value {
    _utf8Value = [value mutableCopy];
}


- (void) setBlobValue: (NSData *) value {
    _blobValue = [value mutableCopy];
}


- (void) setSigmaValueType: (Modern *) type {
    _valueType = type;
}


- (void) setSigmaValue: (Modern *) value {
    _sigmaValueFieldValue = value;
}


- (void) setSigmaSuccessor: (Modern *) successor {
    _sigmaValueSuccessor = successor;
}


- (void) setNamedValueType: (Modern *) type {
    _valueType = type;
}


- (void) setNamedValue: (Modern *) value {
    _namedValueValue = value;
}


- (void) setNamedTypeName: (NSString *) name {
    _namedTypeName = name;
}


- (void) setNamedTypeContentType: (Modern *) contentType {
    _namedTypeContentType = contentType;
}


- (void) setUniverseTypeLevel: (uint64_t) level {
    _universeTypeLevel = level;
}

@end
