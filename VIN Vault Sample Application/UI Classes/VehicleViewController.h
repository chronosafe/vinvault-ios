//
//  VehicleViewController.h
//  VIN Vault Sample Application
//
//  Created by Richard Brown on 11/14/13.
//  Copyright (c) 2013 VIN Vault LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Decode.h"
#import "Vehicle.h"

@class ItemViewController;

@interface VehicleViewController : UITableViewController
@property (strong, nonatomic) Decode *decode;
@property (nonatomic) ItemViewController * detailViewController;

@end
