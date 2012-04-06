//
//  FindBairroByLocation.h
//  SafeCity
//
//  Created by João Eduardo Galli on 3/12/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
#import "RequestCallback.h"

@interface FindBairroByLocation : Request  {
	
}

+ (NSString*) REQUEST_ID;
- (void)sendRequests: (id <RequestCallback>*) callback withLatitude:(NSString*) latitude andLongitude:(NSString*) longitude;

@end