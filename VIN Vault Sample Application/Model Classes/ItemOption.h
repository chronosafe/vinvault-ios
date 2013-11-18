//
//  ItemOption.h
//  VIN Vault Sample Application
//
//  Created by Richard Brown on 11/14/13.
//  Copyright (c) 2013 VIN Vault LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ItemOption : NSManagedObject

@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) NSManagedObject *item;

@end
