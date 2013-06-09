//
//  ContatoDetailViewController.m
//  SafeCity
//
//  Created by João Eduardo Galli on 5/5/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import "ContatoDetailViewController.h"
#import "Preferences.h"

@implementation ContatoDetailViewController

@synthesize nomeField, telefoneField, contatoNumber, formBackgroundImage;

NSString * const ContatoFileName = @"ContatoFileName%i";

- (id) initWithNumber: (NSInteger*) number {
	self = [super init];
	NSLog(@"Contato number: %i", number);
	self.contatoNumber = number;
	
	return self;
}

- (IBAction) salvar: (id) sender {
	NSMutableArray *array = [[NSMutableArray alloc] init];
	[array addObject: nomeField.text]; 
	[array addObject: telefoneField.text]; 
	[array writeToFile: [ContatoDetailViewController dataFilePath: contatoNumber] atomically:YES]; 
	[array release];
	
	// TODO salvar
	[self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)textFieldDoneEditing:(id)sender {
	[self resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender {
	[nomeField resignFirstResponder];
	[telefoneField resignFirstResponder];
}

+ (NSString *)dataFilePath: (NSInteger*) number { 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0]; 
	return [documentsDirectory stringByAppendingPathComponent: 
			[NSString stringWithFormat:ContatoFileName, number]];
}

#pragma mark - 
- (void)viewDidLoad {
	formBackgroundImage.image = [UIImage imageNamed: 
                                 [NSString stringWithFormat: @"background-tela-%@.png", [Preferences get: @"city"]]];

	NSArray *array = [ContatoDetailViewController getContato:contatoNumber];
	
	if (array) {
		nomeField.text = [array objectAtIndex:0];
		telefoneField.text = [array objectAtIndex:1];
		[array release];
	}
	
	[super viewDidLoad];
}

+ (NSArray*) getContato: (NSInteger*) number {
	NSString *filePath = [self dataFilePath: number]; 
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
		return array;
	} else
		return nil;
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
    [super dealloc];
}


@end
