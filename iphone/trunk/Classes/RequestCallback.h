//
//  RequestCallback.h
//  SafeCity
//
//  Created by João Eduardo Galli on 3/13/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RequestCallback

- (void) onSuccess: (id) content fromRequest: (NSString*) request;
- (void) onFailure: (NSString*) errorMessage fromRequest: (NSString*) request;

@end
