//
//  Products.h
//  TestRealm
//
//  Created by Felipe Kimio Nishikaku on 9/2/16.
//  Copyright © 2016 Felipe Kimio Nishikaku. All rights reserved.
//

#import <Realm/Realm.h>

@interface Products : RLMObject
    @property int id;
    @property NSString *name;
    @property NSInteger code;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<Products>
RLM_ARRAY_TYPE(Products)
