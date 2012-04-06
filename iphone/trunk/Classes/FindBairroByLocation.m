//
//  FindBairroByLocation.m
//  SafeCity
//
//  Created by João Eduardo Galli on 3/12/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import "FindBairroByLocation.h"
#import "RequestCallback.h"
#import "SBJsonParser.h"
#import "Preferences.h"

@implementation FindBairroByLocation

+ (NSString*) REQUEST_ID
{
	return @"FindBairroByLocation";
}

- (void)sendRequests: (id <RequestCallback>*) callback withLatitude: (NSString*) latitude andLongitude: (NSString*) longitude {
	requestCallback = callback;
    
    NSString* resourcePath = [NSString stringWithFormat:@"/SafeCity/bairroes/cerca/%@/%@/%@/t", latitude, longitude,
                              [Preferences get:@"city"]];

    [self request: [[super HOST] stringByAppendingString: resourcePath]];
}

- (void)processData: (NSString *) data {
	NSLog(@"ProcessData on FindBairroByLocation.");
	
	SBJsonParser* parser = [[SBJsonParser alloc] init];
	NSArray *result = (NSArray*) [parser objectWithString: data];
	
	[requestCallback onSuccess:result fromRequest:[FindBairroByLocation REQUEST_ID]];
	[parser release];
}


@end
