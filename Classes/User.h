//
//  User.h
//  ServerTest
//
//  Created by Kevin Harris on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@interface User : NSObject
{
	NSNumber* _statusID;
	NSDate* _createdAt;

    NSString* _name;
    NSString* _email;
}

// The unique ID of this Status
@property (nonatomic, retain) NSNumber* statusID;

// Timestamp the Status was sent
@property (nonatomic, retain) NSDate* createdAt;

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* email;

@end
