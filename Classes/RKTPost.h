//
//  RKTPost.h
//  ServerTest
//
//  Created by Blake Watters on 9/5/10.
//  Copyright 2010 Two Toasters. All rights reserved.
//

@interface RKTPost : NSObject
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
