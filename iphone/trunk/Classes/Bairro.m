//
//  Bairro.m
//  SafeCity
//
//  Created by João Eduardo Galli on 3/12/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import "Bairro.h"

@implementation Bairro

@dynamic identifier;
@dynamic nome;
@dynamic cerca;
@dynamic version;


- (Bairro*) initWithDic: (NSDictionary*) dic
{
	
	identifier = [dic objectForKey:@"id"];
	nome = [dic objectForKey:@"nome"];
	cerca = [dic objectForKey:@"cerca"];
	version = [dic objectForKey:@"version"];
	
	return self;
}

- (NSString*) nome
{
	return nome;
}

@end
