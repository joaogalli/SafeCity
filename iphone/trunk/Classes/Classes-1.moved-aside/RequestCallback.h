//
//  RequestCallback.h
//  SafeCity
//
//  Created by João Eduardo Galli on 3/13/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RequestCallback : NSObject {

}

- (void) onSuccess: (NSObject*) object;
- (void) onFailure: (NSString*) errorMessage;

@end
