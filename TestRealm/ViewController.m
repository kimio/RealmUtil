//
//  ViewController.m
//  TestRealm
//
//  Created by Felipe Kimio Nishikaku on 9/1/16.
//  Copyright © 2016 Felipe Kimio Nishikaku. All rights reserved.
//

#import "ViewController.h"
#import "Products.h"
#import "RLMObject+RealmUtil.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //print address
    [Products showRealmAdress];
    
    // Add New product
    Products *products = [Products new];
    products.name = @"Mesa123";
    products.code = (NSInteger)423412;
    NSError* erro = nil;
    [Products insert:products andError:&erro];
    if(erro){
        NSLog([erro localizedDescription]);
    }
    
    //Select all products
    id produtos = [Products select:&erro];
    if(erro){
        NSLog([erro localizedDescription]);
    }
    for(Products* prod in produtos){
        NSLog([prod description]);
    }
    
    //Select only one
    produtos = [Products select:@" id=3 " andError:&erro];
    if(erro){
        NSLog([erro localizedDescription]);
    }
    for(Products* prod in produtos){
        NSLog([prod description]);
    }
    
    //Update a product
    products = [Products new];
    products.id = 3;
    products.name = @"Mesa super bacana";
    [Products update:products updateFields:@[@"name"] andError:&erro];
    
    //Select only one
    produtos = [Products select:@" id=3 " andError:&erro];
    if(erro){
        NSLog([erro localizedDescription]);
    }
    for(Products* prod in produtos){
        NSLog([prod description]);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
