//
//  Decode+Detail.m
//  VIN Vault Sample Application
//
//  Created by Richard Brown on 11/14/13.
//  Copyright (c) 2013 VIN Vault LLC. All rights reserved.
//

#import "Decode+Detail.h"
#import "Decode.h"

@implementation Decode (Detail)

-(NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@ %@", [self year], [self make], [self series]];
}

@end
