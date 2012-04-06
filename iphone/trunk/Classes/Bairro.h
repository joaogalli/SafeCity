//
//  Bairro.h
//  SafeCity
//
//  Created by João Eduardo Galli on 3/12/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bairro : NSObject {
	NSNumber* identifier;
	NSString* nome;
	NSString* cerca;
	NSNumber* version;
}


@property (nonatomic, retain) NSNumber* identifier;
@property (nonatomic, retain) NSString* nome;
@property (nonatomic, retain) NSString* cerca;
@property (nonatomic, retain) NSNumber* version;

- (Bairro*) initWithDic: (NSDictionary*) dic;

@end
