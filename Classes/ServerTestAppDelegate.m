//
//  ServerTestAppDelegate.m
//  ServerTest
//
//  Created by Blake Watters on 9/5/10.
//  Copyright Two Toasters 2010. All rights reserved.
//

#import <RestKit/RestKit.h>
#import "ServerTestAppDelegate.h"
#import "ServerTestViewController.h"
#import "RKTPost.h"

@implementation ServerTestAppDelegate

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    RKLogConfigureByName("RestKit/Network*", RKLogLevelTrace);

    // Initialize RestKit
	//RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURL:@"http://emptyapp.herokuapp.com/"];
    RKObjectManager* objectManager = [RKObjectManager objectManagerWithBaseURL:@"http://0.0.0.0:3000"];
    
    // Enable automatic network activity indicator management
    objectManager.client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
    
    RKObjectMapping* postMapping = [RKObjectMapping mappingForClass:[RKTPost class]];
    [postMapping mapKeyPathsToAttributes:@"id", @"statusID",
                                         @"created_at", @"createdAt",
                                         @"name", @"name",
                                         @"email", @"email",
                                         nil];

    // Register our mappings with the provider
    [objectManager.mappingProvider setMapping:postMapping forKeyPath:@"/users/list.json"];
    
    // Uncomment this to use XML, comment it to use JSON
    //objectManager.acceptMIMEType = RKMIMETypeXML;

    // Create Window and View Controllers
	ServerTestViewController* viewController = [[[ServerTestViewController alloc] initWithNibName:nil bundle:nil] autorelease];
	UINavigationController* controller = [[UINavigationController alloc] initWithRootViewController:viewController];
	UIWindow* window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [window addSubview:controller.view];
    [window makeKeyAndVisible];
	
    return YES;
}

- (void)dealloc
{
    [super dealloc];
}


@end
