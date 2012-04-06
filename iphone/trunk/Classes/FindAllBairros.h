//
//  FindAllBairros.h
//  SafeCity
//
//  Created by João Eduardo Galli on 3/17/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"
#import "RequestCallback.h"

@interface FindAllBairros : Request {
}

+ (NSString*) REQUEST_ID;
- (void) sendRequests: (id <RequestCallback>) callback;

@end
