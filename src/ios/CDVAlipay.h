//
//  CDVAlipay.h
//  X5
//
//  Created by 007slm on 12/8/14.
//
//

#import <Foundation/Foundation.h>

#import <Cordova/CDV.h>
#import <Cordova/CDVPlugin.h>

@interface CDVAlipay : CDVPlugin


@property (nonatomic, strong) NSString *alipayAppId;
@property(nonatomic,strong)NSString *currentCallbackId;

- (void)pay:(CDVInvokedUrlCommand*)command;
@end
