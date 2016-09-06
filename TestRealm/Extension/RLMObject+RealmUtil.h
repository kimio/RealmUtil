//
//  RLMObject+RealmUtil.h
//  TestRealm
//
//  Created by Felipe Kimio Nishikaku on 9/2/16.
//  Copyright © 2016 Felipe Kimio Nishikaku. All rights reserved.
//

#import <Realm/Realm.h>

@interface RLMObject (RealmUtil)
/**
 *  Insert Object and return error in external NSError
 *
 *  @param object   Realm Object
 *  @param outError external NSError
 *
 *  @return return Boolean and case error NSError
 */
+(BOOL)insert:(RLMObject*)object andError:(NSError **)outError;
/**
 *  Show Adress of Realm, this is used to get the adress and open the realm browser
 */
+(void)showRealmAdress;
/**
 *  Update Realm Model with new object value
 *
 *  @param object   Realm Object
 *  @param outError external NSError
 *
 *  @return return Boolean and case error NSError
 */
+(BOOL)update:(RLMObject*)object andError:(NSError **)outError;
/**
 *  Update Realm Model with object values of determinate fields
 *
 *  @param object   Realm Model
 *  @param fields   fields to update
 *  @param outError external NSError
 *
 *  @return return Boolean and case error NSError
 */
+(BOOL)update:(RLMObject*)object updateFields:(NSArray<NSString*>*)fields andError:(NSError **)outError;
/**
 *  Delete a determinate Realm Object
 *
 *  @param object   Realm Model
 *  @param outError external NSError
 *
 *  @return return Boolean and case error NSError
 */
+(BOOL)delete:(RLMObject*)object andError:(NSError **)outError;
/**
 *  Return all data of this Realm Object
 *
 *  @param outError external NSError
 *
 *  @return Return all data of this Realm Object
 */
+(id)select:(NSError **)outError;
/**
 *  Return data of this Realm Object using where
 *
 *  @param where    string where to filter the data
 *  @param outError external NSError
 *
 *  @return Return data of this Realm Object using where
 */
+(id)select:(NSString*)where andError:(NSError **)outError;
@end
