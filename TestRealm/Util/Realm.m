//
//  Realm.m
//  TestRealm
//
//  Created by Felipe Kimio Nishikaku on 9/2/16.
//  Copyright © 2016 Felipe Kimio Nishikaku. All rights reserved.
//

#import "Realm.h"
#import "Products.h"

@implementation Realm
/**
 *  Adiciona os dados do Objeto no Realm
 *
 *  @param object Objeto do tipo RealmObject
 */
+(void)add:(RLMObject*)objeto{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [self showRealmAdress];
    [realm beginWriteTransaction];
    [realm addObject:objeto];
    [realm commitWriteTransaction];
}
/**
 *  Printa endereço do .realm para leitura dos dados
 */
+(void)showRealmAdress{
    NSLog(@"%@",[RLMRealmConfiguration defaultConfiguration].fileURL);
}
@end
