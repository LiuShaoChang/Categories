//
//  NSData+Category.h
//  YjyxParent
//
//  Created by 刘少昌 on 2018/6/13.
//  Copyright © 2018年 YJYX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSData (Category)
/** 函数名错误  其实是 AES128
 * 数据AES256加密
 * @param       key 加密key
 * @returned    加密后的数据
 */
- (NSData *)AES256Encrypt:(NSString *)key;

/** 函数名错误  其实是 AES128
 * 数据AES256解密
 * @param       key 解密key
 * @returned    解密后的数据
 */
- (NSData *)AES256Decrypt:(NSString *)key;
@end
