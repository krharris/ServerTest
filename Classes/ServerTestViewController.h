//
//  ServerTestViewController.h
//  ServerTest
//
//  Created by Kevin Harris on 2/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>

@interface ServerTestViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate>
{
	UITableView* _tableView;
	NSArray* _posts;
}

@end
