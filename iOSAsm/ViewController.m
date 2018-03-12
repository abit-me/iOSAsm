//
//  ViewController.m
//  iOSAsm
//
//  Created by A on 2018/3/12.
//  Copyright © 2018年 A. All rights reserved.
//

#import "ViewController.h"
#import "inline_asm.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    long a = add_two_int(102020, 2323);
    printf("%ld\n", a);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
