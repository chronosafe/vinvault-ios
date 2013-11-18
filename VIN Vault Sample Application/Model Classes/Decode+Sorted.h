//
//  Decode+Sorted.h
//  VIN Vault Sample Application
//
//  Created by Richard Brown on 11/17/13.
//  Copyright (c) 2013 VIN Vault LLC. All rights reserved.
//

#import "Decode.h"

@interface Decode (Sorted)
// Sort the vehicles by Trim name
-(NSArray *)sortedVehicles;

@end
