//
//  TFireIS.h
//  FireIFELSEDemo
//
//  Created by 唐鹏 on 2018/5/21.
//  Copyright © 2018年 唐鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

#define REGISTER_INVOCATION(key,target,sel,arguments) [[TFireIS sharedInctance] registerInvocationKey:key target:target forSelector:sel arguments:arguments]
#define TFireISInstance [TFireIS sharedInctance]

@interface TFireIS : NSObject
+ (instancetype)sharedInctance;
- (void)registerInvocationKey:(id)key target:(id)target forSelector:(SEL)aSelector arguments:(NSArray *)arguments;
- (void)startInvoking;
@end
