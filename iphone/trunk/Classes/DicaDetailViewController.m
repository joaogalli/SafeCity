//
//  DicaDetailViewController.m
//  SafeCity
//
//  Created by João Eduardo Galli on 5/4/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import "DicaDetailViewController.h"
#import "Preferences.h"

@implementation DicaDetailViewController

@synthesize bairro, dicaLabel, textoLabel, dicas, maisDicas;

- (id) initWithBairro: (NSDictionary*) bairroParam {
	self = [super init];
	self.bairro = bairroParam;
	
	dicas = [[NSMutableArray alloc] init];
    
   
	
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = @"Dicas";

    formBackgroundImage.image = [UIImage imageNamed: 
                                 [NSString stringWithFormat: @"background-tela-%@.png", [Preferences get: @"city"]]];
    
	self.navigationItem.rightBarButtonItem = 
		[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay 
													  target:self action:@selector(nextDica:)];
	
	[self addDica: [bairro objectForKey:@"dica1"]];
	[self addDica: [bairro objectForKey:@"dica2"]];
	[self addDica: [bairro objectForKey:@"dica3"]];
	[self addDica: [bairro objectForKey:@"dica4"]];
	
	currentDica = -1;
	
	[self nextDica: nil];
}

- (void) addDica: (NSString*) dica {
	if (0 < [dica length]) {
		//NSLog(@"Dica add: '%@'", dica);
		[dicas addObject:dica];
	}
}

- (void) nextDica: (id) sender {
	currentDica++;
	
	if (currentDica >= [dicas count]) {
		maisDicas.hidden = YES;
        currentDica = 0;    
    }
	
	@try {
		[textoLabel setText:[dicas objectAtIndex:currentDica]];
		[dicaLabel setText: [NSMutableString stringWithFormat:@"Dica %i", (currentDica + 1)]];
	}
	@catch (id e) {
		[dicaLabel setText: @"Dica"];
		[textoLabel setText:@"Nenhuma dica para este bairro."];
	}
	
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
	[dicas release];
	[dicaLabel release];
	[textoLabel release];
    [super dealloc];
}


@end
