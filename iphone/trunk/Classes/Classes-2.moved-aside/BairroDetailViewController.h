//
//  BairroDetailViewController.h
//  SafeCity
//
//  Created by João Eduardo Galli on 3/11/11.
//  Copyright 2011 Sovi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bairro.h"
#import "RequestCallback.h"

@class RequestCallback;

@interface BairroDetailViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
	IBOutlet UILabel *nomeBairroLabel;
	IBOutlet UISegmentedControl *segmentedControl;
	IBOutlet UITableView *tableView;
	
	IBOutlet UITextView *detailTextView;
	IBOutlet UILabel *detailTitleLabel;
	IBOutlet UIView *detailView;
	
	NSDictionary *bairro;
	NSArray *delitos;
	NSArray *dadosUteis;
	bool *showDelitos;
	bool *showTable;
}

@property (retain, nonatomic) UILabel *nomeBairroLabel;
@property (retain, nonatomic) UISegmentedControl *segmentedControl;
@property (retain, nonatomic) UITableView *tableView;

@property (retain, nonatomic) UITextView *detailTextView;
@property (retain, nonatomic) UILabel *detailTitleLabel;
@property (retain, nonatomic) UIView *detailView;

@property (retain, nonatomic) NSDictionary *bairro;
@property (retain, nonatomic) NSArray *delitos;
@property (retain, nonatomic) NSArray *dadosUteis;
@property (nonatomic) bool *showDelitos;
@property (nonatomic) bool *showTable;

- (IBAction) dismissScreen: (id) sender;
- (IBAction) segmentedChanged;
- (void) setBairro: (NSDictionary*) bairroDic;
- (IBAction) dismissDetailView: (id) sender;

@end
