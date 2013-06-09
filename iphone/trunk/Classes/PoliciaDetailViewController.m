//
//  PoliciaDetailViewController.m
//  SafeCity
//
//  Created by João Eduardo Galli on 6/1/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import "PoliciaDetailViewController.h"
#import "Preferences.h"

@implementation PoliciaDetailViewController

@synthesize bairro, items, formBackgroundImage;

- (id) initWithBairro: (NSDictionary*) bairroDic {
	self = [super init];
	NSLog(@"Bairro: %@", bairroDic);
	self.bairro = bairroDic;
	
	items = [[NSMutableArray alloc] init];
	
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Polícia";
    
    formBackgroundImage.image = [UIImage imageNamed: 
                                 [NSString stringWithFormat: @"background-tela-%@.png", [Preferences get: @"city"]]];
	
	self.navigationItem.rightBarButtonItem = 
	[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay 
												  target:self action:@selector(nextItem:)];
	
    @try {
        [self addItem: [[NSArray alloc] initWithObjects: [bairro objectForKey:@"delegaciaEndereco1"],
					[bairro objectForKey:@"delegaciaTelefone1"], nil]
         ];
        [self addItem: [[NSArray alloc] initWithObjects: [bairro objectForKey:@"delegaciaEndereco2"],
					[bairro objectForKey:@"delegaciaTelefone2"], nil]
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
		[tituloLabel setText: [NSMutableString stringWithFormat:@"Policia %i", (currentItem + 1)]];
	}
	@catch (id e) {
		[tituloLabel setText: @"Policia"];
		[enderecoTextView setText:@"Nenhuma delegacia cadastrada para este bairro."];
	}
	
}

-(void)ligar:(id)sender {
	@try {
		NSString *urlTelefone = [@"tel:" stringByAppendingString:[[items objectAtIndex:currentItem] objectAtIndex:1]];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString: urlTelefone]];
		//[urlTelefone release];
	}
	@catch (id e) {
		
	}
}

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
	//[bairro release]; testar
	[items release];
	[enderecoTextView release];
	[telefoneLabel release];
	[tituloLabel release];
    [super dealloc];
}


@end
