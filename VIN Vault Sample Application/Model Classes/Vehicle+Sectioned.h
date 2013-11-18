//
//  Vehicle+Sectioned.h
//  VIN Vault Sample Application
//
//  Created by Richard Brown on 11/14/13.
//  Copyright (c) 2013 VIN Vault LLC. All rights reserved.
//

#import "Vehicle.h"

@interface Vehicle (Sectioned)
-(NSArray *)groupNames;
-(NSArray *)itemsForGroup:(NSString *)name;
@end
