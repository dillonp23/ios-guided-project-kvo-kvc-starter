//
//  ViewController.m
//  KVO KVC Demo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "LSIDepartment.h"
#import "LSIEmployee.h"
#import "LSIHRController.h"


@interface ViewController ()

@property (nonatomic) LSIHRController *hrController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    LSIDepartment *marketing = [[LSIDepartment alloc] init];
    marketing.name = @"Marketing";
    LSIEmployee *philSchiller = [[LSIEmployee alloc] init];
    philSchiller.name = @"Phil";
    philSchiller.jobTitle = @"VP of Marketing";
    philSchiller.salary = 10000000; 
    marketing.manager = philSchiller;

    
    LSIDepartment *engineering = [[LSIDepartment alloc] init];
    engineering.name = @"Engineering";
    LSIEmployee *craig = [[LSIEmployee alloc] init];
    craig.name = @"Craig";
    craig.salary = 9000000;
    craig.jobTitle = @"Head of Software";
    engineering.manager = craig;
    
    LSIEmployee *e1 = [[LSIEmployee alloc] init];
    e1.name = @"Chad";
    e1.jobTitle = @"Engineer";
    e1.salary = 200000;
    
    LSIEmployee *e2 = [[LSIEmployee alloc] init];
    e2.name = @"Lance";
    e2.jobTitle = @"Engineer";
    e2.salary = 250000;
    
    LSIEmployee *e3 = [[LSIEmployee alloc] init];
    e3.name = @"Joe";
    e3.jobTitle = @"Marketing Designer";
    e3.salary = 100000;
    
    [engineering addEmployee:e1];
    [engineering addEmployee:e2];
    [marketing addEmployee:e3];

    LSIHRController *controller = [[LSIHRController alloc] init];
    [controller addDepartment:engineering];
    [controller addDepartment:marketing];
    self.hrController = controller;
    
//    NSLog(@"%@", self.hrController);
    
//    NSString *name = craig.name;
//    NSLog(@"%@", name);
    
//    NSString *key = @"privateName";
//    NSString *value = [craig valueForKey:key];
//    NSLog(@"Value for key %@ is: %@", key, value);
//
//    [philSchiller setValue:@"Killer Schiller" forKey:key];
//    NSString *value2 = [philSchiller valueForKey:key];
//    NSLog(@"Value for key %@ is: %@", key, value2);
//
//    for (id employee in engineering.employees) {
//        NSString *value = [employee valueForKey:key];
//        NSLog(@"Value for key %@ is: %@", key, value);
//    }
    
    //    NSArray *employeesAlt = [self.hrController valueForKeyPath:@"departments.employees"];
    //    NSLog(@"Employees are %@", employeesAlt);
    
    NSString *key = @"salary";
    
    NSArray *employees = [self.hrController valueForKeyPath:@"departments.@distinctUnionOfArrays.employees"]; // distinct union will flatten multiple arrays of employees
    NSLog(@"Employees are %@", employees);
    NSArray *salaries = [employees valueForKeyPath:key];
    NSLog(@"Employees salaries are %@", salaries);
    
//    @try {
//        NSArray *directSalaries = [self.hrController valueForKeyPath:@"departments.@distinctUnionOfArrays.employees.salary"];
//        NSLog(@"Employees salaries are %@", directSalaries);
//    } @catch (NSException *exception) {
//        NSLog(@"Got an exception: %@", exception);
//    }
    
    
    
    [craig setValue:@(42 + 5) forKey:key];
    
    NSArray *directSalaries = [self.hrController valueForKeyPath:@"departments.@distinctUnionOfArrays.employees.salary"];
    NSLog(@"Employees salaries are %@", directSalaries);
    
    NSLog(@"Avg Salary: %@", [employees valueForKeyPath:@"@avg.salary"]);
    NSLog(@"Max Salary: %@", [employees valueForKeyPath:@"@max.salary"]);
    NSLog(@"Min Salary: %@", [employees valueForKeyPath:@"@min.salary"]);
    NSLog(@"Number of Salaries: %@", [employees valueForKeyPath:@"@count.salary"]);

    [engineering setValue:@"John" forKeyPath:@"manager.name"]; // when using multiple propertie sneed to use for key path
    NSLog(@"%@", engineering.manager.name);
    
    NSSortDescriptor *nameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSSortDescriptor *salarySortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"salary" ascending:YES];
    
    NSArray *sortedEmployees = [employees sortedArrayUsingDescriptors:@[nameSortDescriptor,
                                                                        salarySortDescriptor]];
    NSLog(@"Sorted employess: %@", sortedEmployees);
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", @"John"]; // predcate ~ a filter
    NSArray *filteredEmployees = [employees filteredArrayUsingPredicate:predicate];
    NSLog(@"Filtered employees: %@", filteredEmployees);
}


@end
