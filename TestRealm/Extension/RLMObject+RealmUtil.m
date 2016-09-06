//
//  RLMObject+RealmUtil.m
//  TestRealm
//
//  Created by Felipe Kimio Nishikaku on 9/2/16.
//  Copyright © 2016 Felipe Kimio Nishikaku. All rights reserved.
//

#import "RLMObject+RealmUtil.h"
#import <objc/runtime.h>

@implementation RLMObject (RealmUtil)

/**
 *  Catch the last value autoincremented and sum plus 1
 *
 *  @param object Realm Object
 */
+(void)pkAutoIncrement:(RLMObject*)object{
    NSArray *campoAutoIncrement = [self fieldsAutoIncrements:object];
    if([campoAutoIncrement count]>0){
        id obj = [[self allObjects] lastObject];
        for(NSString *campo in campoAutoIncrement){
            int valueAutoIncrement = [[obj valueForKey:campo] intValue]+1;
            [object setValue:@(valueAutoIncrement) forKey:campo];
        }
    }
}
/**
 *  Get all fields that contains autoincrement in name or name equals id
 *
 *  @param object Populated object with values
 *
 *  @return return array with NSString name fields
 */
+(NSArray*)fieldsAutoIncrements:(RLMObject*)object{
    NSMutableArray* array = [NSMutableArray new];
    NSArray* properties = [[object objectSchema] properties];
    for(RLMProperty *prop in properties){
        NSString* field = ((NSString*)[prop name]);
        if([field containsString:@"autoIncrement"]||[field isEqualToString:@"id"]){
            [array addObject:field];
            break;
        }
    }
    return array;
}
/**
 *  Get value from primary key
 *
 *  @param object Realm Object
 *
 *  @param primaryKeyField primary key field name
 *
 *  @return return the value from primary key
 */
+(int)getValueFromPrimaryKey:(RLMObject*)object primaryKeyField:(NSString*)primaryKeyField{
    if([primaryKeyField length]>0){
        return [[object valueForKey:primaryKeyField] intValue];
    }
    return -1;
}
/**
 *  Get the name field of Primary Key Field
 *
 *  @return return NSString name
 */
+(NSString*)getPrimaryKeyFieldName{
   return [self primaryKey];
}
+(BOOL)update:(RLMObject*)object andError:(NSError **)outError{
    return [self update:object updateFields:nil andError:outError];
}
+(BOOL)update:(RLMObject*)object updateFields:(NSArray<NSString*>*)fields andError:(NSError **)outError{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    NSError* error = nil;
    @try {
        if(fields!=nil){
            NSMutableDictionary *fieldValue = [NSMutableDictionary new];
            //add primary key value
            [fieldValue setValue:@([self getValueFromPrimaryKey:object primaryKeyField:[self getPrimaryKeyFieldName]]) forKey:[self getPrimaryKeyFieldName] ];
            for(NSString *field in fields){
                [fieldValue setValue:[object valueForKey:field] forKey:field];
            }
            [self createOrUpdateInRealm:realm withValue:fieldValue];
            [realm commitWriteTransaction];
        }else{
            [realm addOrUpdateObject:object];
            [realm commitWriteTransaction:&error];
        }
    }
    @catch (NSException *exception) {
        NSDictionary *errorDictionary = @{ NSLocalizedDescriptionKey : [exception description]};
        error = [[NSError alloc] initWithDomain:NSMachErrorDomain code:errno userInfo:errorDictionary];
        if ([realm inWriteTransaction]) {
            [realm cancelWriteTransaction];
        }
    }
    *outError = error;
    return (!error);
}
+(BOOL)delete:(RLMObject*)object andError:(NSError **)outError{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [self pkAutoIncrement:object];
    [realm beginWriteTransaction];
    NSError* error = nil;
    @try {
        [realm deleteObject:object];
        [realm commitWriteTransaction:&error];
    }
    @catch (NSException *exception) {
        NSDictionary *errorDictionary = @{ NSLocalizedDescriptionKey : [exception description]};
        error = [[NSError alloc] initWithDomain:NSMachErrorDomain code:errno userInfo:errorDictionary];
        if ([realm inWriteTransaction]) {
            [realm cancelWriteTransaction];
        }
    }
    *outError = error;
    return (!error);
}
+(id)select:(NSError **)outError{
    return [self select:nil andError:outError];
}
+(id)select:(NSString*)where andError:(NSError **)outError{
    NSError* error = nil;
    id values = nil;
    @try {
        values = (where!=nil)?
        [self objectsWhere:where]:
        [self allObjects];
    }
    @catch (NSException *exception) {
           NSDictionary *errorDictionary = @{ NSLocalizedDescriptionKey : [exception description]};
           error = [[NSError alloc] initWithDomain:NSMachErrorDomain code:errno userInfo:errorDictionary];
    }
    *outError = error;
    return values;
}
+(BOOL)insert:(RLMObject*)object andError:(NSError **)outError{
    RLMRealm *realm = [RLMRealm defaultRealm];
    //auto setter when field is autoincrement
    [self pkAutoIncrement:object];
    [realm beginWriteTransaction];
    NSError* error = nil;
    @try {
        [realm addObject:object];
        [realm commitWriteTransaction:&error];
    }
    @catch (NSException *exception) {
        NSDictionary *errorDictionary = @{ NSLocalizedDescriptionKey : [exception description]};
        error = [[NSError alloc] initWithDomain:NSMachErrorDomain code:errno userInfo:errorDictionary];
        if ([realm inWriteTransaction]) {
            [realm cancelWriteTransaction];
        }
    }
    *outError = error;
    return (!error);
}
+(void)showRealmAdress{
    NSLog(@"%@",[RLMRealmConfiguration defaultConfiguration].fileURL);
}
@end
