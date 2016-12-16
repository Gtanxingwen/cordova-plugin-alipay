# cordova-plugin-alipay
cordova plugin alipay
A cordova plugin, a JS version of alipay SDK

此插件为IONIC1插件，
而且是旧版本alipay的sdk，如需使用请参考内部实现，更新sdk和接口写法

# Install
clone到本地，
（YOUR_ALIPAY_APPID 这个写自己定义的app字符串就行，用于ios支付宝支付完成时返回app使用，不要用纯数字，提交AppStore时无法通过）
1. ```cordova plugin add "插件目录"  --variable alipayappid=YOUR_ALIPAY_APPID```

2. ```cordova build ios``` or ```cordova build android```

3. (iOS only) if your cordova version <5.1.1,check the URL Type using XCode

# Usage

```Javascript
 Alipay.pay({
  orderString:'partner="2088221532979990"&seller_id="2088221532979990"&out_trade_no="W8OQO9SBGPMRVM8"&subject="1"&body="我是测试数据"&total_fee="0.02"&notify_url="http://www.xxx.com"&service="mobile.securitypay.pay"&payment_type="1"&_input_charset="utf-8"&it_b_pay="30m"&show_url="m.alipay.com"&sign="Sf43Dxwdymdq3%2FqdhfBy4FEZzade%2FXhgduPIWV9%2BTuXCs%2FtozmlaiZWaF%2FmlWp2BdVQyUzC0NcPK8%2FcENQUodKzU8ZjkwFQPyMnxLqVjcuqBh%2FiYfMRBg9wMQWaxfRv5o5Gkqgvzq71MVO%2Fz1UttgnNqvWoL3RBw1GxSXQKmuoc%3D"&sign_type="RSA"'
 },
 function(msgCode){alert(msgCode)},
 function(msg){alert(msg)}
 );
```
说明：
支付宝sdk原型
方法名称：pay方法
方法原型：(void)payOrder:(NSString *)orderStr fromScheme:(NSString *)schemeStr callback:(CompletionBlock)completionBlock;

此插件直接传入orderStr，orderStr需要服务器端生成，这块可以参考阿里云的说明文档
schemeStr取的是填入的appid
https://doc.open.alipay.com/doc2/detail.htm?spm=a219a.7629140.0.0.fF6jLG&treeId=59&articleId=103563&docType=1
