//
//  CoreStoreBridge.m
//  CoreStore
//
//  Copyright © 2016 John Rommel Estropia
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "CoreStoreBridge.h"

#if USE_FRAMEWORKS
#import <CoreStore/CoreStore-Swift.h>

#elif !defined(SWIFT_OBJC_INTERFACE_HEADER_NAME)
#error Add "SWIFT_OBJC_INTERFACE_HEADER_NAME=$(SWIFT_OBJC_INTERFACE_HEADER_NAME)" to the project's GCC_PREPROCESSOR_DEFINITIONS settings

#else
#define _STRINGIFY(x)    #x
#define STRINGIFY(x)    _STRINGIFY(x)
#import STRINGIFY(SWIFT_OBJC_INTERFACE_HEADER_NAME)

#endif


CS_OBJC_OVERLOADABLE
CSFrom *_Nonnull CSFromClass(Class _Nonnull entityClass) CS_OBJC_RETURNS_RETAINED {
    
    return [[CSFrom alloc] initWithEntityClass:entityClass];
}

CS_OBJC_OVERLOADABLE
CSFrom *_Nonnull CSFromClass(Class _Nonnull entityClass, NSNull *_Nonnull configuration) CS_OBJC_RETURNS_RETAINED {
    
    return [[CSFrom alloc] initWithEntityClass:entityClass configuration:configuration];
}

CS_OBJC_OVERLOADABLE
CSFrom *_Nonnull CSFromClass(Class _Nonnull entityClass, NSString *_Nonnull configuration) CS_OBJC_RETURNS_RETAINED {
    
    return [[CSFrom alloc] initWithEntityClass:entityClass configuration:configuration];
}

CS_OBJC_OVERLOADABLE
CSFrom *_Nonnull CSFromClass(Class _Nonnull entityClass, NSArray<id> *_Nonnull configurations) CS_OBJC_RETURNS_RETAINED {
    
    return [[CSFrom alloc] initWithEntityClass:entityClass configurations:configurations];
}


// MARK: - Select

//CSSelectTerm *_Nonnull CSAttribute(NSString *_Nonnull keyPath) CS_OBJC_RETURNS_RETAINED {
//    
//    return [[CSSelectTerm alloc] initWithKeyPath:keyPath];
//}

CSSelect *_Nonnull CSSelectNumber(CSSelectTerm *_Nonnull selectTerm) CS_OBJC_RETURNS_RETAINED {
    
    return [[CSSelect alloc] initWithNumberTerm:selectTerm];
}

CSSelect *_Nonnull CSSelectDecimal(CSSelectTerm *_Nonnull selectTerm) CS_OBJC_RETURNS_RETAINED {
    
    return [[CSSelect alloc] initWithDecimalTerm:selectTerm];
}

CSSelect *_Nonnull CSSelectString(CSSelectTerm *_Nonnull selectTerm) CS_OBJC_RETURNS_RETAINED {
    
    return [[CSSelect alloc] initWithStringTerm:selectTerm];
}

CSSelect *_Nonnull CSSelectDate(CSSelectTerm *_Nonnull selectTerm) CS_OBJC_RETURNS_RETAINED {
    
    return [[CSSelect alloc] initWithDateTerm:selectTerm];
}

CSSelect *_Nonnull CSSelectData(CSSelectTerm *_Nonnull selectTerm) CS_OBJC_RETURNS_RETAINED {
    
    return [[CSSelect alloc] initWithDataTerm:selectTerm];
}

CSSelect *_Nonnull CSSelectObjectID() CS_OBJC_RETURNS_RETAINED {
    
    return [[CSSelect alloc] initWithObjectIDTerm];
}


// MARK: - Where

CSWhere *_Nonnull CSWhereValue(BOOL value) CS_OBJC_RETURNS_RETAINED {
    
    return [[CSWhere alloc] initWithValue:value];
}

CSWhere *_Nonnull CSWhereFormat(NSString *_Nonnull format, ...) CS_OBJC_RETURNS_RETAINED {
    
    CSWhere *where;
    va_list args;
    va_start(args, format);
    where = [[CSWhere alloc] initWithPredicate:[NSPredicate predicateWithFormat:format arguments:args]];
    va_end(args);
    return where;
}

CSWhere *_Nonnull CSWherePredicate(NSPredicate *_Nonnull predicate) CS_OBJC_RETURNS_RETAINED {
    
    return [[CSWhere alloc] initWithPredicate:predicate];
}


// MARK: - OrderBy

@class CSOrderBy;

NSSortDescriptor *_Nonnull CSSortAscending(NSString *_Nonnull key) {
    
    return [[NSSortDescriptor alloc] initWithKey:key ascending:YES];
}

NSSortDescriptor *_Nonnull CSSortDescending(NSString *_Nonnull key) {
    
    return [[NSSortDescriptor alloc] initWithKey:key ascending:NO];
}

CSOrderBy *_Nonnull CSOrderBySortKey(NSSortDescriptor *_Nonnull sortDescriptor) CS_OBJC_RETURNS_RETAINED {
    
    return [[CSOrderBy alloc] initWithSortDescriptor:sortDescriptor];
}

CS_OBJC_OVERLOADABLE
CSOrderBy *_Nonnull CSOrderBySortKeys(NSSortDescriptor *_Nonnull sortDescriptor, ...) CS_OBJC_RETURNS_RETAINED {
    
    va_list args;
    va_start(args, sortDescriptor);
    
    NSMutableArray *sortDescriptors = [NSMutableArray new];
    [sortDescriptors addObject:sortDescriptor];
    
    NSSortDescriptor *next;
    while ((next = va_arg(args, NSSortDescriptor *)) != nil) {
        
        [sortDescriptors addObject:next];
    }
    va_end(args);
    return [[CSOrderBy alloc] initWithSortDescriptors:sortDescriptors];
}

CS_OBJC_OVERLOADABLE
CSOrderBy *_Nonnull CSOrderBySortKeys(NSArray<NSSortDescriptor *> *_Nonnull sortDescriptors) CS_OBJC_RETURNS_RETAINED {
    
    return [[CSOrderBy alloc] initWithSortDescriptors:sortDescriptors];
}


// MARK: - GroupBy

CSGroupBy *_Nonnull CSGroupByKeyPath(NSString *_Nonnull keyPath) CS_OBJC_RETURNS_RETAINED {
    
    return [[CSGroupBy alloc] initWithKeyPath:keyPath];
}

CS_OBJC_OVERLOADABLE
CSGroupBy *_Nonnull CSGroupByKeyPaths(NSString *_Nonnull keyPath, ...) CS_OBJC_RETURNS_RETAINED {
    
    va_list args;
    va_start(args, keyPath);
    
    NSMutableArray *keyPaths = [NSMutableArray new];
    [keyPaths addObject:keyPath];
    
    NSString *next;
    while ((next = va_arg(args, NSString *)) != nil) {
        
        [keyPaths addObject:next];
    }
    va_end(args);
    return [[CSGroupBy alloc] initWithKeyPaths:keyPaths];
}

CS_OBJC_OVERLOADABLE
CSGroupBy *_Nonnull CSGroupByKeyPaths(NSArray<NSString *> *_Nonnull keyPaths) CS_OBJC_RETURNS_RETAINED {
 
    return [[CSGroupBy alloc] initWithKeyPaths:keyPaths];
}


// MARK: - Tweak

CS_OBJC_OVERLOADABLE
CSTweak *_Nonnull CSTweakCreate(void (^_Nonnull block)(NSFetchRequest *_Nonnull fetchRequest)) CS_OBJC_RETURNS_RETAINED {
    
    return [[CSTweak alloc] initWithBlock:block];
}
