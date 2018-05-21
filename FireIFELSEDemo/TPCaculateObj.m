//
//  TPCaculateObj.m
//  FireIFELSEDemo
//
//  Created by 唐鹏 on 2018/5/21.
//  Copyright © 2018年 唐鹏. All rights reserved.
//

#import "TPCaculateObj.h"
#import "TFireIS.h"
@implementation TPCaculateObj
+ (void)caculateWithType:(FireIFELSE)type{
    [TFireISInstance registerInvocationKey:@(FireIFELSE11) target:[self new] forSelector:@selector(test1) arguments:nil];
    [TFireISInstance registerInvocationKey:@(FireIFELSE22) target:[self new] forSelector:@selector(test2) arguments:nil];
    [TFireISInstance registerInvocationKey:@(FireIFELSE33) target:[self new] forSelector:@selector(test3) arguments:nil];
    [TFireISInstance startInvoking];
}

- (void)test1{
    NSLog(@"1");
}
- (void)test2{
    NSLog(@"2");
}
- (void)test3{
    NSLog(@"3");
}



@end
