//
//  FindAllBairros.m
//  SafeCity
//
//  Created by João Eduardo Galli on 3/17/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import "FindAllBairros.h"
#import "SBJsonParser.h"
#import "Preferences.h"

@implementation FindAllBairros

+ (NSString*) REQUEST_ID {
	return @"FindAllBairros";
}

- (void) sendRequests: (id <RequestCallback>) callback {
	requestCallback = callback;
    
	[self request: [[super HOST] stringByAppendingString: 
                    [NSString stringWithFormat:@"/SafeCity/bairroes/all/%@", [Preferences get:@"city"]]]];
}

- (void)processData: (NSString *) data {
	NSLog(@"ProcessData on FindAllBairros.");
	
	SBJsonParser* parser = [[SBJsonParser alloc] init];
	NSArray *result = (NSArray*) [parser objectWithString: data];
	
	NSMutableArray *bairros = [[NSMutableArray alloc] init];
	
	for (NSDictionary *dic in result) {
		[bairros addObject:dic];
	}
	
	[requestCallback onSuccess:bairros fromRequest:[FindAllBairros REQUEST_ID]];

	[parser release];
	[bairros release];
}

@end
