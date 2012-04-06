//
//  EmergencyTextSettingsViewController.m
//  SafeCity
//
//  Created by João Eduardo Galli on 5/5/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import "EmergencyTextSettingsViewController.h"


@implementation EmergencyTextSettingsViewController

@synthesize telefoneField, mensagemView, scrollView;

NSString * const EmergencyTextFileName = @"EmergencyTextFileName.plist";

+ (NSDictionary*) getTextInfo {
	NSString *filePath = [EmergencyTextSettingsViewController dataFilePath]; 
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
		NSArray *keys = [[NSArray alloc] initWithObjects: @"telefone", @"mensagem", nil];
		NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjects:array forKeys: keys];
		
		NSLog(@"Dic: %@", dic);
		
		return dic;
		//[array release];
	} else {
		return nil;
	}
}

- (IBAction) salvar: (id) sender {
	NSMutableArray *array = [[NSMutableArray alloc] init];
	[array addObject: telefoneField.text]; 
	[array addObject: mensagemView.text]; 
	[array writeToFile: [EmergencyTextSettingsViewController dataFilePath] atomically:YES]; 
	[array release];
	
	[self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)textFieldDoneEditing:(id)sender {
	[self resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender {
	[telefoneField resignFirstResponder];
	[mensagemView resignFirstResponder];
}

+ (NSString *)dataFilePath { 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0]; 
	return [documentsDirectory stringByAppendingPathComponent:EmergencyTextFileName];
}

#pragma mark - 
- (void)viewDidLoad {
	
	NSString *filePath = [EmergencyTextSettingsViewController dataFilePath]; 
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
		telefoneField.text = [array objectAtIndex:0];
		mensagemView.text = [array objectAtIndex:1];
		[array release];
	}
	
	[super viewDidLoad];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
	svos = scrollView.contentOffset;
	CGPoint pt;
    CGRect rc = [textView bounds];
    rc = [textView convertRect:rc toView:scrollView];
    pt = rc.origin;
    pt.x = 0;
    pt.y -= 60;
	
    [scrollView setContentOffset:pt animated:YES];    
}

- (void) textViewDidEndEditing:(UITextView *)textView {
    [scrollView setContentOffset:svos animated:YES]; 
    [textView resignFirstResponder];
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
