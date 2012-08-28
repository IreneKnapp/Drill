//
//  Modern.h
//  Drill
//
//  Created by Irene Knapp on 8/23/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    int8ValueModernNodeType,
    int16ValueModernNodeType,
    int32ValueModernNodeType,
    int64ValueModernNodeType,
    nat8ValueModernNodeType,
    nat16ValueModernNodeType,
    nat32ValueModernNodeType,
    nat64ValueModernNodeType,
    float32ValueModernNodeType,
    float64ValueModernNodeType,
    float128ValueModernNodeType,
    utf8ValueModernNodeType,
    blobValueModernNodeType,
    sigmaValueModernNodeType,
    namedValueModernNodeType,
    int8TypeModernNodeType,
    int16TypeModernNodeType,
    int32TypeModernNodeType,
    int64TypeModernNodeType,
    nat8TypeModernNodeType,
    nat16TypeModernNodeType,
    nat32TypeModernNodeType,
    nat64TypeModernNodeType,
    float32TypeModernNodeType,
    float64TypeModernNodeType,
    float128TypeModernNodeType,
    utf8TypeModernNodeType,
    blobTypeModernNodeType,
    sigmaTypeModernNodeType,
    namedTypeModernNodeType,
    universeTypeModernNodeType,
} ModernNodeType;

@interface Modern : NSObject {
    ModernNodeType _nodeType;
    Modern *_valueType;
    int8_t _int8Value;
    int16_t _int16Value;
    int32_t _int32Value;
    int64_t _int64Value;
    uint8_t _nat8Value;
    uint16_t _nat16Value;
    uint32_t _nat32Value;
    uint64_t _nat64Value;
    float _float32Value;
    double _float64Value;
    long double _float128Value;
    NSMutableString *_utf8Value;
    NSMutableData *_blobValue;
    Modern *_sigmaValueFieldValue;
    Modern *_sigmaValueSuccessor;
    Modern *_namedValueValue;
    NSString *_namedTypeName;
    Modern *_namedTypeContentType;
    uint64_t _universeTypeLevel;
}

+ (Modern *) makeInt8: (int8_t) value;
+ (Modern *) makeInt16: (int16_t) value;
+ (Modern *) makeInt32: (int32_t) value;
+ (Modern *) makeInt64: (int64_t) value;
+ (Modern *) makeNat8: (uint8_t) value;
+ (Modern *) makeNat16: (uint16_t) value;
+ (Modern *) makeNat32: (uint32_t) value;
+ (Modern *) makeNat64: (uint64_t) value;
+ (Modern *) makeFloat32: (float) value;
+ (Modern *) makeFloat64: (double) value;
+ (Modern *) makeFloat128: (long double) value;
+ (Modern *) makeUTF8: (NSString *) value;
+ (Modern *) makeBlob: (NSData *) value;
+ (Modern *) makeSigmaValueOfType: (Modern *) type
             fieldValue: (Modern *) fieldValue
             successor: (Modern *) successorValue;
+ (Modern *) makeNamedValueOfType: (Modern *) type
             value: (Modern *) value;
+ (Modern *) makeInt8Type;
+ (Modern *) makeInt16Type;
+ (Modern *) makeInt32Type;
+ (Modern *) makeInt64Type;
+ (Modern *) makeNat8Type;
+ (Modern *) makeNat16Type;
+ (Modern *) makeNat32Type;
+ (Modern *) makeNat64Type;
+ (Modern *) makeFloat32Type;
+ (Modern *) makeFloat64Type;
+ (Modern *) makeFloat128Type;
+ (Modern *) makeUTF8Type;
+ (Modern *) makeBlobType;
+ (Modern *) makeSigmaType: (Modern *) type
             fieldType: (Modern *) fieldType
             successor: (Modern *) successor;
+ (Modern *) makeNamedType: (NSString *) name
             contentType: (Modern *) contentType;
+ (Modern *) makeUniverseType: (uint64_t) level;

- (id) initWithNodeType: (ModernNodeType) nodeType;

- (ModernNodeType) nodeType;
- (Modern *) valueType;
- (int8_t) int8Value;
- (int16_t) int16Value;
- (int32_t) int32Value;
- (int64_t) int64Value;
- (uint8_t) nat8Value;
- (uint16_t) nat16Value;
- (uint32_t) nat32Value;
- (uint64_t) nat64Value;
- (float) float32Value;
- (double) float64Value;
- (long double) float128Value;
- (NSString *) utf8Value;
- (NSData *) blobValue;
- (Modern *) sigmaValue;
- (Modern *) sigmaSuccessor;
- (Modern *) namedValue;
- (NSString *) namedTypeName;
- (Modern *) namedTypeContentType;
- (uint64_t) universeTypeLevel;

- (void) setInt8Value: (int8_t) value;
- (void) setInt16Value: (int16_t) value;
- (void) setInt32Value: (int32_t) value;
- (void) setInt64Value: (int64_t) value;
- (void) setNat8Value: (uint8_t) value;
- (void) setNat16Value: (uint16_t) value;
- (void) setNat32Value: (uint32_t) value;
- (void) setNat64Value: (uint64_t) value;
- (void) setFloat32Value: (float) value;
- (void) setFloat64Value: (double) value;
- (void) setFloat128Value: (long double) value;
- (void) setUTF8Value: (NSString *) value;
- (void) setBlobValue: (NSData *) value;
- (void) setSigmaValueType: (Modern *) type;
- (void) setSigmaValue: (Modern *) value;
- (void) setSigmaSuccessor: (Modern *) successor;
- (void) setNamedValueType: (Modern *) type;
- (void) setNamedValue: (Modern *) value;
- (void) setNamedTypeName: (NSString *) name;
- (void) setNamedTypeContentType: (Modern *) contentType;
- (void) setUniverseTypeLevel: (uint64_t) level;
@end
