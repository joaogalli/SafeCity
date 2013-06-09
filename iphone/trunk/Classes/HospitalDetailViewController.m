//
//  HospitalDetailViewController.m
//  SafeCity
//
//  Created by João Eduardo Galli on 7/11/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import "HospitalDetailViewController.h"
#import "Preferences.h"

@implementation HospitalDetailViewController
@synthesize bairro, items, formBackgroundImage;

- (id) initWithBairro: (NSDictionary*) bairroDic {
	self = [super init];
	self.bairro = bairroDic;
	
	items = [[NSMutableArray alloc] init];
	
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Hospital";
    
	formBackgroundImage.image = [UIImage imageNamed: 
                                 [NSString stringWithFormat: @"background-tela-%@.png", [Preferences get: @"city"]]];

	self.navigationItem.rightBarButtonItem = 
	[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay 
												  target:self action:@selector(nextItem:)];
	
    @try {
        [self addItem: [[NSArray alloc] initWithObjects: [bairro objectForKey:@"hospitalEndereco1"],
                        [bairro objectForKey:@"hospitalTelefone1"], nil]
         ];
        [self addItem: [[NSArray alloc] initWithObjects: [bairro objectForKey:@"hospitalEndereco2"],
                        [bairro objectForKey:@"hospitalTelefone2"], nil]
         ];
        [self addItem: [[NSArray alloc] initWithObjects: [bairro objectForKey:@"hospitalEndereco3"],
                        [bairro objectForKey:@"hospitalTelefone3"], nil]
         ];
    }
    @catch (NSException *exception) {
        
    }
    
	currentItem = -1;
	
	[self nextItem: nil];
}

- (void) addItem: (NSArray*) item {
	
	if (0 < [(NSString*)[item objectAtIndex:0] length]) {
		[items addObject:item];
	}
}

- (void) nextItem: (id) sender {
	currentItem++;
	
	if (currentItem >= [items count])
		currentItem = 0;
	
	@try {
		NSArray *item = [items objectAtIndex:currentItem];
		[enderecoTextView setText:[item objectAtIndex:0]];
		[telefoneLabel setText:[item objectAtIndex:1]];
		[tituloLabel setText: [NSMutableString stringWithFormat:@"Hospital %i", (currentItem + 1)]];
	}
	@catch (id e) {
		[tituloLabel setText: @"Hospital"];
		[enderecoTextView setText:@"Nenhum hospital cadastrado para este bairro."];
	}
	
}

-(void)ligar:(id)sender {
	@try {
		NSString *urlTelefone = [@"tel:" stringByAppendingString:[[items objectAtIndex:currentItem] objectAtIndex:1]];
		//NSLog(urlTelefone);
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString: urlTelefone]];
		//[urlTelefone release];
	}
	@catch (id e) {
		NSLog(@"%@", e);
	}
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
	[items release];
	[enderecoTextView release];
	[telefoneLabel release];
	[tituloLabel release];
    [super dealloc];
}


@end
