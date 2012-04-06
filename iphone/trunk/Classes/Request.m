//
//  Request.m
//  SafeCity
//
//  Created by João Eduardo Galli on 5/18/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import "Request.h"
#import "Preferences.h"

@implementation Request

+ (NSString*)REQUEST_ID {
	return @"Request";
}

- (NSString*)HOST {
    return [Preferences get: @"host"];
}

- (void) request: (NSString*) url {
	NSLog(@"request");
	// Create the request.
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
											  cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
														  timeoutInterval:30.0];
	
	[theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	
	// create the connection with the request
	// and start loading the data
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if (theConnection) {
		// Create the NSMutableData to hold the received data.
		// receivedData is an instance variable declared elsewhere.
		receivedData = [[NSMutableData data] retain];
	} else {
		// Inform the user that the connection failed.
		[requestCallback onFailure:@"Erro na conexão" fromRequest:@"request"];
	}
	
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	//NSLog(@"didReceiveResponse");
	[receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	//NSLog(@"didReceiveData");
    [receivedData appendData: data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	//NSLog(@"connectionDidFinishLoading");
	NSString *dataString = [[NSString alloc] initWithBytes: [receivedData bytes] 
													length: [receivedData length] 
												  encoding: NSISOLatin1StringEncoding];
	//NSLog(@"dataReceived String: \"%@\"\n", dataString);
	[self processData:dataString];
	
    // release the connection, and the data object
    [connection release];
    [receivedData release];
	[dataString release];
}

- (void)processData: (NSString *) data {
	NSLog(@"ProcessData.");
	[requestCallback onSuccess:data fromRequest:[Request REQUEST_ID]];
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"didFailWithError: %@", error);

	NSString* errorMessage = @"Ocorreu um erro na conexão, tente novamente ou aguarde alguns minutos.";
	
	if ([error class] == [NSURLErrorDomain class]) {
		errorMessage = @"Não foi possível conectar ao servidor, tente novamente ou aguarde alguns minutos.";
	}
	
	[requestCallback onFailure: errorMessage fromRequest:[Request REQUEST_ID]];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
	NSLog(@"canAuthenticateAgainstProtectionSpace");
	return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	NSLog(@"connection:didReceiveAuthenticationChallenge:");
	
	NSURLCredential *credential = [[NSURLCredential alloc] initWithUser:@"iphone" 
															   password:@"iphoneSafeCity"
															persistence:NSURLCredentialPersistencePermanent];
	
	[[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
}

@end
