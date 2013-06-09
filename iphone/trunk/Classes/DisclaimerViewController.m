//
//  DisclaimerViewController.m
//  SafeCity
//
//  Created by João Eduardo Galli on 7/29/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import "DisclaimerViewController.h"
#import "Preferences.h"

@implementation DisclaimerViewController

@synthesize formBackgroundImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Aviso Legal";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    formBackgroundImage.image = [UIImage imageNamed: 
                                 [NSString stringWithFormat: @"background-tela-%@.png", [Preferences get: @"city"]]];
    
    disclaimerText.text = [Preferences get: [NSString stringWithFormat: @"avisoLegal_%@", [Preferences get: @"city"]]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
