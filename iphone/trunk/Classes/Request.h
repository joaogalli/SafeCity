//
//  Request.h
//  SafeCity
//
//  Created by João Eduardo Galli on 5/18/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestCallback.h"

@interface Request : NSObject {
	NSMutableData *receivedData;
	id <RequestCallback> *requestCallback;
}
// asd
+ (NSString*)REQUEST_ID;
- (NSString*)HOST;
- (void)request: (NSString*) url;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
- (void)processData: (NSString *) data;

@end
