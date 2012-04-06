//
//  HospitalDetailViewController.h
//  SafeCity
//
//  Created by João Eduardo Galli on 7/11/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HospitalDetailViewController : UIViewController {
	NSDictionary *bairro;
	NSMutableArray *items;
	int currentItem;
	IBOutlet UILabel *tituloLabel;
	IBOutlet UITextView *enderecoTextView;
	IBOutlet UILabel *telefoneLabel;
    IBOutlet UIImageView *formBackgroundImage;
}

@property (nonatomic, retain) NSDictionary *bairro;
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) IBOutlet UILabel *tituloLabel;
@property (nonatomic, retain) IBOutlet UITextView *enderecoTextView;
@property (nonatomic, retain) IBOutlet UILabel *telefoneLabel;
@property (nonatomic, retain) IBOutlet UIImageView *formBackgroundImage;

-(void)ligar:(id)sender;
- (void) addItem: (NSArray*) item;
- (void) nextItem: (id) sender;

@end
