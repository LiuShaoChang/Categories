//
//  NSString+Category.h
//  YjyxParent
//
//  Created by 刘少昌 on 2018/6/13.
//  Copyright © 2018年 YJYX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/utsname.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import "GTMBase64.h"

typedef enum FILE_TYPE {
    FILE_TYPE_TXT,
    FILE_TYPE_DOC,
    FILE_TYPE_XLS,
    FILE_TYPE_PPT,
    FILE_TYPE_PDF,
    FILE_TYPE_LOG,
    FILE_TYPE_XML,
    FILE_TYPE_AUDIO,
    FILE_TYPE_IMAGE,
    FILE_TYPE_APK,
    FILE_TYPE_EXE,
    FILE_TYPE_BIN,
    FILE_TYPE_BAT,
    FILE_TYPE_DLL,
    FILE_TYPE_FOLDER,
    FILE_TYPE_UNKONW,
} FILE_TYPE;

typedef enum DATE_TYPE {
    DATE_TYPE_YEAR_MONTH_DAY_HOUR_MINUTE,               // yyyy-MM-dd HH:mm
    DATE_TYPE_YEAR_MONTH_DAY,                           // yyyy年MM月dd日
    DATE_TYPE_MONTH_DAY_HOUR_MINUTE,                    // MM-dd HH:mm
    DATE_TYPE_MONTH_DAY,                                // MM月dd日
    DATE_TYPE_MONTH_DAY_HOUR_MINUTE_CHI,                // MM月dd日 HH:mm
    DATE_TYPE_YEAR_MONTH_DAY_HOUR_MINUTE_SECOND,        // yyyy-MM-dd HH:mm:ss
    DATE_TYPE_YEARMONTHDAY,                             // yyyy/MM/dd
    DATE_TYPE_YEARMONTHDAY_HOUR_MINUTE,                 // yyyy年MM月dd日 HH:mm
    DATE_TYPE_YEAR_MONTH_DAY_POINT,                     // yyyy.MM.dd
    DATE_TYPE_YEAR_MONTH_DAY_ROD,                       // yyyy-MM-dd
    DATE_TYPE_HOUR_MINUTE                               // HH:mm
    
} DATE_TYPE;

typedef NS_ENUM(NSInteger, TIMETYPE){
    TIMETYPE_POINT_HOUR_MIN_SEC,   // 00:00:00
    TIMETYPE_WORD_MIN,            // 00分钟
    TIMETYPE_SYMBOL_MIN_SEC,      //00'00''
    TIMETYPE_MIN                   // 转换成分钟(只进不舍,不包含分钟两个字,纯数字)
};

@interface NSString (Category)

/**
 * 字符串数字校验
 * @returned    bool值
 */
- (bool)isNumber;

/**
 * 字符串手机号校验
 * @returned    bool值
 */
- (bool)isPhone;

/**
 * 字符串邮箱校验
 * @returned    bool值
 */
- (bool)isEmail;
//判断全字母
- (BOOL) deptPassInputShouldAlpha;
//判断仅输入字母或数字：

- (BOOL) deptIdInputShouldAlphaNum;
//URL校验
- (bool)isURL;
/**
 * 字符串邮政编码校验
 * @returned    bool值
 */
- (bool)isZipcode;

/**
 * 字符串身份证校验
 * @returned    bool值
 */
- (bool)isIdentity;

/**
 * 字符串名字校验
 * @returned    bool值
 */
- (bool)isSingle;

/**
 * 字符串中文校验
 * @returned    bool值
 */
- (bool)isChinese;

/**
 *  是否全为空格
 * @returned    bool值
 */
- (bool)isSpace;


/**
 * 字符串空判断
 * @returned    字符串是否为空
 */
- (bool)isEmpty;

/**
 * 字符串json判断
 * @returned    字符串是否为json
 */
- (bool)isJson;


/**
 * 密码是否符合要求强度
 * @returned    密码是否符合要求强度
 */
- (bool)strengthOfPassword;

/**
 * 字符串md5加密
 * @returned    md5加密后的字串
 */
- (NSString*)md5;

/**
 * 字符串base64加密
 * @returned    base64加密后的字串
 */
- (NSString*)base64Encrypt;

/**
 * 字符串base64解密
 * @returned    base64解密后的字串
 */
- (NSString*)base64Decrypt;

/**
 * 字符串des3加解密
 * @returned    des3加解密后的字串
 */
- (NSString*)des3:(CCOperation)descc withPass:(NSString*)pass;

/**
 * url编码
 * @returned    编码后的url字串
 */
-(NSString *)URLEncoding;

/**
 * 字符串首字符
 * @returned    字串串首字母
 */
- (NSString*)indexs;

/**
 * 字符串中是否包含表情
 * @returned    字符串中是否包含表情
 */
- (BOOL)containsEmoji;

/**
 * 文件路径判断文件类型
 * @returned    文件类型枚举
 */
- (FILE_TYPE)fileType;

/**
 * 对关键字进行命中变绿色显示
 * @param       key 关键字
 * @returned    转换后的关键字
 */
- (NSAttributedString*)attributeStringForKey:(NSString*)key;

/**
 * 对数字字符串加星处理(132****8990)
 */
- (NSString *)handlePhoneNumber;

/**
 * 时间字串转换为时间
 * @param       format 时间格式
 * @param       timeZone 时间转化时区
 * @returned    转换后的时间
 */
- (NSDate*)dateValue:(NSString*)format forTimeZone:(NSTimeZone*)timeZone;

/**
 * 毫秒时间字符串
 * @param       format 时间格式
 * @param       timeZone 时间转化时区
 * @returned    转换后的时间格式字符串
 */
- (NSString*)dateString:(NSString*)format forTimeZone:(NSTimeZone*)timeZone;

/**
 * 秒时间字符串
 * @param       format 时间格式
 * @param       timeZone 时间转化时区
 * @returned    转换后的时间格式字符串
 */
- (NSString*)dateString1:(NSString*)format forTimeZone:(NSTimeZone*)timeZone;

/**
 * ****年**月**日 **:**格式字符串
 * @param       "2016-04-08T15:31:11"格式字符串
 * @param       类型:0,2016-04-08类型;1,年月日类型
 * @returned    转换后的时间格式字符串
 */
- (NSString *)dateStringwithType:(DATE_TYPE)type ;
/**
 * 转换为刚刚,**小时前,**周前,**月前等等
 */
-(NSString *)dateConvertTime;

/** 根据时间戳获取周几 */
- (NSString *)weekDay;

/**
 * 多长时间之前
 * @param       format 时间格式
 * @param       timeZone 时间转化时区
 * @returned    多长时间之前
 */
- (NSString *)dateStringTimeBefore;

/**
 * 判断时间是上午还是下午
 * @param       timeZone 指定时区/为空的话是本地时区
 * @returned    是否上午
 */
- (BOOL)isAm:(NSTimeZone*)timeZone;

/**
 * 返回性别头像
 * @returned 性别头像Image (0 保密，1 男，2女)
 */
- (UIImage*)sexImage;

/**
 * 十进制转化成十六进制字符串
 * @returned    十六进制字符串
 */
- (NSString*)toHex;

/**
 * 十进制数转化成二进制数
 * @returned    二进制字符串
 */
- (NSString*)toBinary;

/**
 * 预登录智能域名
 * @returned    智能域名
 */
- (NSString*)intelligentHost;

/**
 * 随机生成16位密钥
 * @returned    NSString值
 */
+ (NSString *)ret16bitString;

/**
 * 去掉字符串中\n
 * @returned    NSString值
 */
+(NSString *)ReplacingNewLineAndWhitespaceCharactersFromJson:(NSString *)dataStr;
/** 将小数转换成NSString类型的
 * 保留一位小数,如果小数为是0,则不保留;如果不是0,则保留
 * @param   num是转换成%的那个数字
 * @returned    NSString不包含%
 */
+ (NSString *)percentHandleFloatToStr:(CGFloat)num;
/** 将秒转换成指定格式的字符串
 *  @param   timeType字符串格式 second秒数
 *  @returned 返回指定格式的字符串
 */
+ (NSString *)exchangeToTimeType:(TIMETYPE)timeType withSecond:(NSInteger)second;

/**
 iphone,ipod,ipad型号

 @return 返回iPhone/iPad/iPod+型号字符串
 */
- (NSString*)iphoneType;

@end
