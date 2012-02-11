//
//  User.m
//  ServerTest
//
//  Created by Kevin Harris on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "User.h"

@implementation User

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
