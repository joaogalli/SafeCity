//
//  Preferences.m
//  SafeCity
//
//  Created by João Eduardo Galli on 11/1/11.
//  Copyright (c) 2011 Sovi. All rights reserved.
//

#import "Preferences.h"

@implementation Preferences

+ (NSString*) get: (NSString*) key {
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    //NSLog(@"Caminho para o arquivo: %@", plistPath);
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    //NSLog(@"Dict: %@", plistDict);
    
    NSString *value = [plistDict objectForKey:key];
    
    //NSLog(@"HOST do arquivo PLIST: %@", value);
    return value; 
}

@end
