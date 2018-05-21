//
//  TFireIS.m
//  FireIFELSEDemo
//
//  Created by 唐鹏 on 2018/5/21.
//  Copyright © 2018年 唐鹏. All rights reserved.
//

#import "TFireIS.h"
#import <objc/message.h>
#import "NSInvocation+T_Target.h"
@interface TFireIS()
@property(strong,nonatomic) NSMutableDictionary *invocationContainer;
@property(strong,nonatomic) NSLock *registerLock;
@end
@implementation TFireIS

+ (instancetype)sharedInctance{
    static TFireIS *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (void)registerInvocationKey:(id)key target:(id)target forSelector:(SEL)aSelector arguments:(NSArray *)arguments{
    if (!key) {
        return;
    }
    
    NSInvocation *newInvocation = [self invocationWithTarget:target selector:aSelector arguments:arguments];
    if (!newInvocation) {
        return;
    }
    
    [self.registerLock lock];
    [self.invocationContainer setObject:newInvocation forKey:key];
    [self.registerLock unlock];
}

- (NSInvocation *)invocationWithTarget:(id)target selector:(SEL)aSelector arguments:(NSArray *)arguments{
    if (!target || !aSelector) {
        return nil;
    }
    NSMethodSignature *signature = [target methodSignatureForSelector:aSelector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.selector = aSelector;
    invocation.t_target = target;
    invocation.target = target;
    NSInteger argumentCount = arguments.count;
    
    for (NSInteger i = 0; i <argumentCount ; i++) {
        id argument = arguments[i];
        [invocation setArgument:&argument atIndex:i+2];
    }
    [invocation invoke];
    return invocation;
}

- (void)startInvoking{
    [self.registerLock lock];
    
    [self.invocationContainer enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSInvocation*  _Nonnull obj, BOOL * _Nonnull stop) {
        // 是否有实现这个方法
        BOOL isRespondingSelector = [[self allMethodWithTarget:obj.t_target] containsObject:NSStringFromSelector(obj.selector)];
        if (!isRespondingSelector){
            NSException *exception = [NSException exceptionWithName:@"**** wrong class or contain (+) selector ****" reason:@"target must be a class or selector must be a instance method" userInfo:nil];
            @throw exception;
        }
    }];
    
    [self.registerLock unlock];
}

- (NSMutableArray *)allMethodWithTarget:(id)target{
    NSMutableArray *alls = [[NSMutableArray alloc] init];
    unsigned int count = 0;
    Method *methods = class_copyMethodList([target class], &count);
    
    for (NSInteger i = 0; i < count; i++) {
        SEL mName = method_getName(methods[i]);
        const char *sName = sel_getName(mName);
        NSString *name = [NSString stringWithUTF8String:sName];
        [alls addObject:name];
    }
    free(methods);
    return alls;
}

- (NSLock *)registerLock{
    if (!_registerLock) {
        _registerLock = [[NSLock alloc] init];
    }
    return _registerLock;
}
- (NSMutableDictionary *)invocationContainer{
    if (!_invocationContainer) {
        _invocationContainer = [[NSMutableDictionary alloc] init];
    }
    return _invocationContainer;
}
@end
