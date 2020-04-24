//
//  LSIEmployee.m
//  KVO KVC Demo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "LSIEmployee.h"

@interface LSIEmployee ()

@property (nonatomic, copy) NSString *privateName;

@end

@implementation LSIEmployee

- (instancetype)init
{
    if (self = [super init]) {
        _privateName = @"Hair Force One";
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@, Title: %@, Salary: %li", self.name, self.jobTitle, self.salary];
}

@end
