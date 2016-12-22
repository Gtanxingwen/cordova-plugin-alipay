//
//  CDVAlipay.m
//  cordova-plugin-alipay
//
//  Created by lesonli on 3/31/16.
//
//

#import "CDVAlipay.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation CDVAlipay
-(void)handleOpenURL:(NSNotification *)notification{
    NSURL* url = [notification object];
    //跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
    if (url!=nil && [url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService]
         processOrderWithPaymentResult:url
         standbyCallback:^(NSDictionary *resultDic) {
             NSLog(@"result = %@", resultDic);
             CDVPluginResult* result = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsString:[NSString stringWithFormat:@"%@",resultDic[@"resultStatus"]]];
             [self.commandDelegate sendPluginResult:result callbackId:self.currentCallbackId];
             [self endForExec];
         }];
    }
}


-(void)pluginInitialize{

    NSString* appId = [[self.commandDelegate settings] objectForKey:@"alipayappid"];
    if(appId){
        self.alipayAppId = appId;
    }
}


-(void) prepareForExec:(CDVInvokedUrlCommand *)command{
    self.currentCallbackId = command.callbackId;
    
}

-(NSDictionary *)checkArgs:(CDVInvokedUrlCommand *) command{
    // check arguments
    NSDictionary *params = [command.arguments objectAtIndex:0];
    if (!params)
    {
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"] callbackId:command.callbackId];
        
        [self endForExec];
        return nil;
    }
    return params;
}

-(void) endForExec{
    self.currentCallbackId = nil;
}


- (void)pay:(CDVInvokedUrlCommand*)command{
    [self prepareForExec:command];
    NSDictionary *orderInfoArgs = [self checkArgs:command];
    //获取签名字符串
    NSString *orderStr = orderInfoArgs[@"orderString"];
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = [self alipayAppId];
    if (orderStr != nil) {
        NSLog(@"orderStr = %@",orderStr);
        [[AlipaySDK defaultService] payOrder:orderStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            CDVPluginResult* result = [CDVPluginResult resultWithStatus: CDVCommandStatus_OK messageAsString:[NSString stringWithFormat:@"%@",resultDic[@"resultStatus"]]];
            [self.commandDelegate sendPluginResult:result callbackId:self.currentCallbackId];
            [self endForExec];
        }];
    }
}

@end
