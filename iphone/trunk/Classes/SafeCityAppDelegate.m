//
//  SafeCityAppDelegate.m
//  SafeCity
//
//  Created by João Eduardo Galli on 3/11/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import "SafeCityAppDelegate.h"
#import "SafeCityViewController.h"

@implementation SafeCityAppDelegate

@synthesize window;
@synthesize navigationController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {   
    NSLog(@"SafeCityAppDelegate.application didFinishLaunchingWithOptions");
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
	
    // Mostra o splashscreen apenas na inicialização
    // TODO assegurar que está pegando a classe certa.
	[[navigationController.viewControllers objectAtIndex:0] showSplash];
	
    return YES;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"SafeCityAppDelegate.applicationDidBecomeActive");
        
    // Mostra o splash todas as vezes
    //[[navigationController.viewControllers objectAtIndex:0] showSplash];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"SafeCityAppDelegate.applicationWillResignActive");
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"SafeCityAppDelegate.applicationDidEnterBackground");
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"SafeCityAppDelegate.applicationWillEnterForeground");
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"SafeCityAppDelegate.applicationWillTerminate");
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    NSLog(@"SafeCityAppDelegate.applicationDidReceiveMemoryWarning");
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[navigationController release];
    [window release];
    [super dealloc];
}


@end
