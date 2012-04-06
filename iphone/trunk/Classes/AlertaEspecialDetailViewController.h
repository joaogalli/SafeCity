//
//  AlertaEspecialDetailViewController.h
//  SafeCity
//
//  Created by João Eduardo Galli on 7/13/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AlertaEspecialDetailViewController : UIViewController {
	IBOutlet UITextView *textoTextView;
	NSDictionary *bairro;
    IBOutlet UIImageView *formBackgroundImage;
}

@property (nonatomic, retain) IBOutlet UITextView *textoTextView;
@property (nonatomic, retain) IBOutlet UIImageView *formBackgroundImage;

@end
