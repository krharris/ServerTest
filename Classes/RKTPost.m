//
//  RKTPost.m
//  ServerTest
//
//  Created by Blake Watters on 9/5/10.
//  Copyright 2010 Two Toasters. All rights reserved.
//

#import "RKTPost.h"

@implementation RKTPost

@synthesize statusID = _statusID;
@synthesize createdAt = _createdAt;

@synthesize name = _name;
@synthesize email = _email;

- (NSString*)description
{
	return [NSString stringWithFormat:@"%@ (ID: %@)", self.name, self.statusID];
}

- (void)dealloc
{
    [_statusID release];
	[_createdAt release];

    [_name release];
    [_email release];
    
    [super dealloc];
}

@end
