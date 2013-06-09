//
//  AlertaEspecialDetailViewController.m
//  SafeCity
//
//  Created by João Eduardo Galli on 7/13/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import "AlertaEspecialDetailViewController.h"
#import "Preferences.h"

@implementation AlertaEspecialDetailViewController

@synthesize textoTextView, formBackgroundImage;

- (id) initWithBairro: (NSDictionary*) bairroDic {
	self = [super init];
	self.title = @"Alerta Especial";	
	bairro = bairroDic;
	
	return self;
}


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	textoTextView.text = [bairro objectForKey:@"alertaEspecial"];
    
    formBackgroundImage.image = [UIImage imageNamed: 
                                 [NSString stringWithFormat: @"background-tela-%@.png", [Preferences get: @"city"]]];

}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[textoTextView release];
    [super dealloc];
}


@end
