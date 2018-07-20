//
//  NSString+Category.m
//  YjyxParent
//
//  Created by 刘少昌 on 2018/6/13.
//  Copyright © 2018年 YJYX. All rights reserved.
//

#import "NSString+Category.h"
#import "NSDate+Extension.h"
#import "NSDate+Category.h"

@implementation NSString (Category)

- (bool)isNumber
{
    NSString *numberRegex = @"[0-9]+";
    NSPredicate *regexNumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    return [regexNumber evaluateWithObject:self];
}

- (bool)isPhone
{
    /**
     10         * 中国移动：China Mobile
     11         * 134,135,136,137,138,139,147,150,151,152,157,158,159,178,182,183,184,187,188,198,1705(虚拟)
     12         */
    NSString * CM = @"(^1((3[4-9]|5[0127-9]|8[23478]|47|78|98)[0-9])\\d{7}$)|(^1705\\d{7}$)";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,145,155,156,185,186,176,166,1709(虚拟)
     17         */
    NSString * CU = @"(^1((3[0-2]|45|5[56]|8[56]|76|66)[0-9])\\d{7}$)|(^1709\\d{7}$)";
    /**
     20         * 中国电信：China Telecom
     21         * 133,153,180,181,189,177,199,1700(虚拟)
     22         */
    NSString * CT = @"(^1((33|53|8[019]|77|99)[0-9])\\d{7}$)|(^1700\\d{7}$)";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestcm evaluateWithObject:self] == YES)
        || ([regextestct evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (bool)isEmail
{
    NSString *emailRegex = @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*.\\w+([-.]\\w+)*";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (bool)isURL
{
    NSDataDetector *URLDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    NSArray *matches = [URLDetector matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    NSString *urlRegex = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
    
    return [urlTest evaluateWithObject:self] || ([matches count]>0);
}

- (bool)isZipcode
{
    NSString *zipCodeRegex = @"[1-9]d{5}(?!d)";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", zipCodeRegex];
    return [emailTest evaluateWithObject:self];
}

- (bool)isIdentity
{
    NSString *identityRegex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",identityRegex];
    return [identityCardPredicate evaluateWithObject:self];
}

- (bool)isSingle
{
    NSString *singleRegex = @"^([\u4e00-\u9fa5]+|([a-zA-Z]+\\s?)+)$";
    NSPredicate *singleCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",singleRegex];
    return [singleCardPredicate evaluateWithObject:self];
}

- (bool)isChinese
{
    for(int i=0; i< self.length;i++){
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

- (bool)isSpace
{
    BOOL isSpace = YES;
    for ( int i = 0; i<self.length; i++) {
        char c = [self characterAtIndex:i];
        if (c  != ' ') {
            isSpace = NO;
            break;
        }
    }
    return isSpace;
}

- (bool)isEmpty
{
    if (self == nil) {
        return YES;
    }
    
    if (self.length == 0) {
        return YES;
    }
    
    if ([self isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if ([self isEqualToString:@"(null)"]) {
        return YES;
    }
    
    if ([self isEqualToString:@"null"]) {
        return YES;
    }
    return NO;
}

- (bool)isJson
{
    return [NSJSONSerialization isValidJSONObject:[self JSONValue]];
}


//判断全字母
- (BOOL) deptPassInputShouldAlpha
{
    NSString *regex =@"[a-zA-Z]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![pred evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}


//判断仅输入字母或数字：

- (BOOL) deptIdInputShouldAlphaNum
{
    NSString *regex =@"[a-zA-Z0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![pred evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}


- (bool)strengthOfPassword
{
    NSString *passRegex = @"^(?=.*[0-9].*)(?=.*[a-zA-Z].*).{8,}$";
    NSPredicate *passTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passRegex];
    return [passTest evaluateWithObject:self];
}

- (NSString*)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

- (NSString*)base64Encrypt
{
    return [GTMBase64 encodeBase64String:self];
}

- (NSString*)base64Decrypt
{
    return [GTMBase64 decodeBase64String:self];
}

- (NSString*)des3:(CCOperation)descc withPass:(NSString*)pass
{
    if (pass.isEmpty) {
        return nil;
    }
    if (pass.length <= 8) {
        pass = [pass stringByAppendingString:@"$#365#$*[`@$(#$#36#"];
    }
    const void *bytes;
    size_t byteSize;
    if (descc == kCCDecrypt)//解密
    {
        NSData *data = [GTMBase64 decodeData:[self dataUsingEncoding:NSUTF8StringEncoding]];
        byteSize = data.length;
        bytes = data.bytes;
    }else{
        NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
        byteSize = data.length;
        bytes = data.bytes;
    }
    
    size_t movedBytes = 0;
    size_t bufferSize = (byteSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    void *buffer = malloc(bufferSize * sizeof(uint8_t));
    memset((void *)buffer, 0x0, bufferSize);
    
    const void *vkey = (const void *) [pass UTF8String];
    const void *vi = (const void *) [@"vrvxaIvS" UTF8String];
    CCCryptorStatus ccStatus = CCCrypt(descc,
                                       kCCAlgorithm3DES,
                                       kCCOptionPKCS7Padding,
                                       vkey,
                                       kCCKeySize3DES,
                                       vi,
                                       bytes,
                                       byteSize,
                                       buffer,
                                       bufferSize,
                                       &movedBytes);
    
    NSString *result = nil;
    if (ccStatus == kCCSuccess) {
        if (descc == kCCDecrypt){
            result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)buffer length:(NSUInteger)movedBytes]
                                           encoding:NSUTF8StringEncoding];
        }else{
            result = [GTMBase64 stringByEncodingData:[NSData dataWithBytes:(const void *)buffer length:(NSUInteger)movedBytes]];
        }
    }
    
    free(buffer);
    return result;
}

-(NSString *)URLEncoding
{
    NSString *result = ( NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              NULL,
                                                              CFSTR("!*();+$,%#[] "),
                                                              kCFStringEncodingUTF8));
    return result;
}

- (NSString*)indexs
{
    if (!self || [self length] == 0) {
        return @"*";
    }
    
    //    NSString *preString =[NSString stringWithFormat:@"%@",self];
    //
    //    if ([[preString substringToIndex:1] compare:@"长"] ==NSOrderedSame)
    //    {
    //        return @"C";
    //    }
    //    if ([[preString substringToIndex:1] compare:@"沈"] ==NSOrderedSame)
    //    {
    //        return @"S";
    //    }
    //
    //    if ([[preString substringToIndex:1] compare:@"厦"] ==NSOrderedSame)
    //    {
    //        return @"X";
    //    }
    //
    //    if ([[preString substringToIndex:1] compare:@"地"] ==NSOrderedSame)
    //    {
    //        return @"D";
    //    }
    //
    //    if ([[preString substringToIndex:1] compare:@"重"] ==NSOrderedSame)
    //    {
    //        return @"C";
    //    }
    
    NSMutableString *ms = [[NSMutableString alloc] initWithString:self];
    CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO);
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
        NSString *first = [[ms substringToIndex:1] uppercaseString];
        return first;
    }
    return nil;
}

-(BOOL)containsEmoji {
    __block BOOL isEomji = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         //         NSLog(@"hs++++++++%04x",hs);
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f)
                 {
                     isEomji = YES;
                 }
                 //                 NSLog(@"uc++++++++%04x",uc);
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3|| ls ==0xfe0f) {
                 isEomji = YES;
             }
             //             NSLog(@"ls++++++++%04x",ls);
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
         
     }];
    return isEomji;
}

- (FILE_TYPE)fileType
{
    if ([self hasSuffix:@".jpg"] || [self hasSuffix:@".JPG"] || [self hasSuffix:@".png"] || [self hasSuffix:@".PNG"]|| [self hasSuffix:@".gif"]|| [self hasSuffix:@".GIF"]) {
        return FILE_TYPE_IMAGE;
    }
    if([self hasSuffix:@".amr"] || [self hasSuffix:@".AMR"]){
        return FILE_TYPE_AUDIO;
    }
    if([self hasSuffix:@".doc"] || [self hasSuffix:@".DOC"] || [self hasSuffix:@".docx"] || [self hasSuffix:@".DOCX"]){
        return FILE_TYPE_DOC;
    }
    if([self hasSuffix:@".xls"] || [self hasSuffix:@".XLS"] || [self hasSuffix:@".xlsx"] || [self hasSuffix:@".XLSX"]){
        return FILE_TYPE_XLS;
    }
    if([self hasSuffix:@".exe"] || [self hasSuffix:@".EXE"]){
        return FILE_TYPE_EXE;
    }
    if([self hasSuffix:@".apk"] || [self hasSuffix:@".APK"]){
        return FILE_TYPE_APK;
    }
    if([self hasSuffix:@".txt"] || [self hasSuffix:@".TXT"] || [self hasSuffix:@".log"]){
        return FILE_TYPE_TXT;
    }
    
    if([self hasSuffix:@".xml"] || [self hasSuffix:@".XML"] || [self hasSuffix:@".xhtml"] || [self hasSuffix:@".XHTML"] || [self hasSuffix:@".htmls"] || [self hasSuffix:@".HTMLS"] || [self hasSuffix:@".html"] || [self hasSuffix:@".HTML"] || [self hasSuffix:@".plist"] || [self hasSuffix:@".PLIST"]){
        return FILE_TYPE_XML;
    }
    if([self hasSuffix:@".pdf"] || [self hasSuffix:@".PDF"]){
        return FILE_TYPE_PDF;
    }
    if([self hasSuffix:@".bin"] || [self hasSuffix:@".BIN"]){
        return FILE_TYPE_BIN;
    }
    if([self hasSuffix:@".pptx"] || [self hasSuffix:@".ppt"] || [self hasSuffix:@".potx"] || [self hasSuffix:@".pot"]){
        return FILE_TYPE_PPT;
    }
    if([self hasSuffix:@".bat"] || [self hasSuffix:@".BAT"]){
        return FILE_TYPE_BAT;
    }
    if([self hasSuffix:@".dll"] || [self hasSuffix:@".DLL"]){
        return FILE_TYPE_DLL;
    }
    if ([self rangeOfString:@"."].location == NSNotFound) {
        return FILE_TYPE_FOLDER;
    }
    return FILE_TYPE_UNKONW;
}

- (NSAttributedString*)attributeStringForKey:(NSString*)key
{
    NSRange keyRange = [self rangeOfString:key options:NSCaseInsensitiveSearch];
    if (keyRange.location == NSNotFound) {
        return [[NSAttributedString alloc] initWithString:self];
    }else{
        NSString *tempString = self;
        if (keyRange.location > 12) {
            tempString = [[NSString stringWithFormat:@"...%@",[self substringFromIndex:keyRange.location - 3]] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            keyRange = [tempString rangeOfString:key options:NSCaseInsensitiveSearch];
        }
        NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:tempString];
        [result addAttribute:NSForegroundColorAttributeName value:RGBACOLOR(98, 159, 40, 1) range:keyRange];
        return result;
    }
}

/**
 * 对数字字符串加星处理(132****8990)
 */
- (NSString *)handlePhoneNumber {
    if ([self isPhone]) {
        NSString *newStr = [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return newStr;
    }
    return nil;
    
}

- (NSDate*)dateValue:(NSString*)format forTimeZone:(NSTimeZone*)timeZone
{
    if (timeZone == nil) {
        timeZone = [NSTimeZone systemTimeZone];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setTimeZone:timeZone];
    NSDate *date = [formatter dateFromString:self];
    if (!date) {
        date = [[NSDate dateWithTimeIntervalSince1970:[self longLongValue] / 1000] dateByAddingTimeInterval:[timeZone secondsFromGMT]];
    }
    return date;
}

- (NSString*)dateString:(NSString*)format forTimeZone:(NSTimeZone*)timeZone
{
    if (timeZone == nil) {
        timeZone = [NSTimeZone systemTimeZone];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setTimeZone:timeZone];
    NSDate *date = [formatter dateFromString:self];
    if (!date) {
        date = [NSDate dateWithTimeIntervalSince1970:[self longLongValue] / 1000];
    }
    return [formatter stringFromDate:date];
}

- (NSString*)dateString1:(NSString*)format forTimeZone:(NSTimeZone*)timeZone
{
    if (timeZone == nil) {
        timeZone = [NSTimeZone systemTimeZone];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setTimeZone:timeZone];
    NSDate *date = [formatter dateFromString:self];
    if (!date) {
        date = [NSDate dateWithTimeIntervalSince1970:[self longLongValue]];
    }
    return [formatter stringFromDate:date];
}
- (NSString *)dateStringwithType:(NSInteger)type {
    NSArray *tmpStrArr = [self componentsSeparatedByString:@"."];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    if (self == nil || tmpStrArr.count == 0) {
        return nil;
    }
    NSString *returnedString;
    switch (type) {
        case DATE_TYPE_YEAR_MONTH_DAY_HOUR_MINUTE:
        {
            NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
            [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSDate *date = [dateFormatter dateFromString:tmpStrArr[0]];
            returnedString = [dateFormatter2 stringFromDate:date];
            
        }
            break;
        case DATE_TYPE_YEAR_MONTH_DAY:
        {
            NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
            [dateFormatter2 setDateFormat:@"yyyy年MM月dd日"];
            NSDate *date = [dateFormatter dateFromString:tmpStrArr[0]];
            returnedString = [dateFormatter2 stringFromDate:date];
            
        }
            
            break;
        case DATE_TYPE_MONTH_DAY_HOUR_MINUTE:
        {
            NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
            [dateFormatter2 setDateFormat:@"MM-dd HH:mm"];
            NSDate *date = [dateFormatter dateFromString:tmpStrArr[0]];
            returnedString = [dateFormatter2 stringFromDate:date];
            
        }
            break;
        case DATE_TYPE_MONTH_DAY:
        {
            NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
            [dateFormatter2 setDateFormat:@"MM月dd日"];
            NSDate *date = [dateFormatter dateFromString:tmpStrArr[0]];
            returnedString = [dateFormatter2 stringFromDate:date];
            
            
        }
            break;
        case DATE_TYPE_MONTH_DAY_HOUR_MINUTE_CHI:
        {
            NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
            [dateFormatter2 setDateFormat:@"MM月dd日 HH:mm"];
            NSDate *date = [dateFormatter dateFromString:tmpStrArr[0]];
            returnedString = [dateFormatter2 stringFromDate:date];
            
        }
            break;
            
        case DATE_TYPE_YEAR_MONTH_DAY_HOUR_MINUTE_SECOND:
        {
            NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
            [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate *date = [dateFormatter dateFromString:tmpStrArr[0]];
            returnedString = [dateFormatter2 stringFromDate:date];
            
            
        }
            break;
        case DATE_TYPE_YEARMONTHDAY:
        {
            NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
            [dateFormatter2 setDateFormat:@"yyyy/MM/dd"];
            NSDate *date = [dateFormatter dateFromString:tmpStrArr[0]];
            returnedString = [dateFormatter2 stringFromDate:date];
            
            
        }
            break;
        case DATE_TYPE_YEARMONTHDAY_HOUR_MINUTE:
        {
            NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
            [dateFormatter2 setDateFormat:@"yyyy年MM月dd日 HH:mm"];
            NSDate *date = [dateFormatter dateFromString:tmpStrArr[0]];
            returnedString = [dateFormatter2 stringFromDate:date];
            
            
        }
            break;
        case DATE_TYPE_YEAR_MONTH_DAY_POINT:
        {
            NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
            [dateFormatter2 setDateFormat:@"yyyy.MM.dd"];
            NSDate *date = [dateFormatter dateFromString:tmpStrArr[0]];
            returnedString = [dateFormatter2 stringFromDate:date];
            
        }
            break;
        case DATE_TYPE_YEAR_MONTH_DAY_ROD:
        {
            NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
            [dateFormatter2 setDateFormat:@"yyyy-MM-dd"];
            NSDate *date = [dateFormatter dateFromString:tmpStrArr[0]];
            returnedString = [dateFormatter2 stringFromDate:date];
        }
            break;
        case DATE_TYPE_HOUR_MINUTE:
        {
            NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
            [dateFormatter2 setDateFormat:@"HH:mm"];
            NSDate *date = [dateFormatter dateFromString:tmpStrArr[0]];
            returnedString = [dateFormatter2 stringFromDate:date];;
        }
            break;
            
        default:
            break;
    }
    return returnedString;
    
}

-(NSString *)dateConvertTime{
    NSArray *tmpStrArr = [self componentsSeparatedByString:@"."];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss";
    //获得发布的具体时间
    NSDate *createDate = [fmt dateFromString:tmpStrArr[0]];
    // 判断是否为今年
    if (createDate.mh_isThisYear) {
        if (createDate.mh_isToday) { // 今天
            NSDateComponents *cmps = [createDate mh_deltaWithNow];
            if (cmps.hour >= 1) { // 至少是1小时前发的
                return [NSString stringWithFormat:@"%ld小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1~59分钟之前发的
                return [NSString stringWithFormat:@"%ld分钟前", cmps.minute];
            } else { // 1分钟内发的
                return @"刚刚";
            }
        } else if (createDate.mh_isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else { // 至少是前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createDate];
    }
}

/** 根据时间戳获取周几 */
- (NSString *)weekDay {
    NSArray *tmpStrArr = [self componentsSeparatedByString:@"."];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:tmpStrArr[0]];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSCalendarUnit unitFlag = NSCalendarUnitWeekday;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    comps = [calendar components:unitFlag fromDate:date];
    NSArray *weekArr = @[@"",@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    NSInteger index = [comps weekday];
    NSString *weekStr = weekArr[index];
    return weekStr;
}

- (NSString *)dateStringTimeBefore
{
    NSString *timeString = @"";
    if ([self longLongValue]/60<1) {
        timeString = [NSString stringWithFormat:@"%lld", [self longLongValue]];
        timeString=[NSString stringWithFormat:@"%@秒", timeString];
    }
    else if ([self longLongValue]/3600<1) {
        timeString = [NSString stringWithFormat:@"%lld", [self longLongValue]/60];
        timeString=[NSString stringWithFormat:@"%@分钟", timeString];
    }
    else if ([self longLongValue]/3600>1&&[self longLongValue]/86400<1) {
        timeString = [NSString stringWithFormat:@"%lld", [self longLongValue]/3600];
        timeString=[NSString stringWithFormat:@"%@小时", timeString];
    }
    else if ([self longLongValue]/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%lld", [self longLongValue]/86400];
        timeString=[NSString stringWithFormat:@"%@天", timeString];
        
    }
    return timeString;
}


- (BOOL)isAm:(NSTimeZone*)timeZone
{
    if (timeZone == nil) {
        timeZone = [NSTimeZone systemTimeZone];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss SSSS"];
    [formatter setTimeZone:timeZone];
    NSDate *date = [formatter dateFromString:self];
    if (!date) {
        date = [[NSDate dateWithTimeIntervalSince1970:[self longLongValue] / 1000] dateByAddingTimeInterval:[timeZone secondsFromGMT]];
    }
    return date.hour < 18 && date.hour > 6;
}

- (UIImage*)sexImage
{
    switch ([self intValue]) {
        case 0:
            return [UIImage imageNamed:@"sex_secret_nomal_big"];
            break;
        case 1:
            return [UIImage imageNamed:@"sex_male_nomal_big"];
            break;
        case 2:
            return [UIImage imageNamed:@"sex_female_big"];
        default:
            return nil;
    }
}

/**
 * 十进制数转化成十六进制数
 */
- (NSString*)toHex
{
    NSString *hexChar;
    NSString *hex =@"";
    int64_t decimalChar;
    int64_t decimal = [self longLongValue];
    for (int i = 0; i<9; i++) {
        decimalChar = decimal%16;
        decimal = decimal/16;
        switch (decimalChar)
        {
            case 10:
                hexChar =@"A";break;
            case 11:
                hexChar =@"B";break;
            case 12:
                hexChar =@"C";break;
            case 13:
                hexChar =@"D";break;
            case 14:
                hexChar =@"E";break;
            case 15:
                hexChar =@"F";break;
            default:
                hexChar=[[NSString alloc] initWithFormat:@"%lli",decimalChar];
                
        }
        hex = [hexChar stringByAppendingString:hex];
        if (decimal == 0) {
            break;
        }
    }
    return hex;
}

/**
 * 十进制数转化成二进制数
 */
- (NSString *)toBinary
{
    int num = [self intValue];
    int remainder = 0;      //余数
    int divisor = 0;        //除数
    
    NSString * prepare = @"";
    
    while (true)
    {
        remainder = num%2;
        divisor = num/2;
        num = divisor;
        prepare = [prepare stringByAppendingFormat:@"%d",remainder];
        
        if (divisor == 0)
        {
            break;
        }
    }
    
    NSString * result = @"";
    for (NSInteger i = prepare.length - 1; i >= 0; i --)
    {
        result = [result stringByAppendingFormat:@"%@",
                  [prepare substringWithRange:NSMakeRange(i , 1)]];
    }
    
    return result;
}

/**
 * 预登录智能域名
 */
- (NSString*)intelligentHost
{
    NSMutableString *host = [NSMutableString stringWithCapacity:0];
    //用户未输入http
    if (![self hasPrefix:@"http://"]) {
        [host appendString:@"http://"];
    }
    //用户输入的是企业标识
    if ([self rangeOfString:@"."].location == NSNotFound) {
        [host appendFormat:@"%@.linkdood.cn",self];
    }else{
        [host appendString:self];
    }
    //用户未输入端口号
    if (([[self componentsSeparatedByString:@":"] count] < 3 && [self hasPrefix:@"http://"]) || [[self componentsSeparatedByString:@":"] count] < 2) {
        [host appendString:@":80"];
    }
    //用户未输入后缀
    if (![self hasSuffix:@"/pre"]) {
        [host appendString:@"/pre"];
    }
    return host;
}

/**
 * 随机生成16位密钥
 * @returned    NSString值
 */
+ (NSString *)ret16bitString
{
    int length = 16;
    char data[16];
    for (int i = 0; i <length; i++) {
        switch (rand()%3) {
            case 0:
                data[i] = 'A'+rand()%26;
                break;
            case 1:
                data[i] = 'a'+rand()%26;
                break;
            case 2:
                data[i] = '0'+rand()%10;
                break;
            default:
                break;
        }
    }
    return [[NSString alloc] initWithBytes:data length:16 encoding:NSUTF8StringEncoding];
    
}

+(NSString *)ReplacingNewLineAndWhitespaceCharactersFromJson:(NSString *)dataStr{
    NSScanner *scanner = [[NSScanner alloc] initWithString:dataStr];
    [scanner setCharactersToBeSkipped:nil];
    NSMutableString *result = [[NSMutableString alloc] init];
    
    NSString *temp;
    NSCharacterSet*newLineAndWhitespaceCharacters = [ NSCharacterSet newlineCharacterSet];
    // 扫描
    while (![scanner isAtEnd])
    {
        temp = nil;
        [scanner scanUpToCharactersFromSet:newLineAndWhitespaceCharacters intoString:&temp];
        if (temp) [result appendString:temp];
        
        // 替换换行符
        if ([scanner scanCharactersFromSet:newLineAndWhitespaceCharacters intoString:NULL]) {
            if (result.length > 0 && ![scanner isAtEnd]) // Dont append space to beginning or end of result
                [result appendString:@""];
        }
    }
    return result;
}
// 处理float小数点后一位
+ (NSString *)percentHandleFloatToStr:(CGFloat)num
{
    NSString *str = [NSString stringWithFormat:@"%.1f", num];
    NSArray *tmpArr = [str componentsSeparatedByString:@"."];
    if ([tmpArr[1] integerValue] == 0) {
        str = tmpArr[0];
    }
    return [NSString stringWithFormat:@"%@", str];
}
// 将秒转换成指定格式的字符串
+ (NSString *)exchangeToTimeType:(TIMETYPE)timeType withSecond:(NSInteger)second
{
    NSInteger sec = second % 60;
    NSInteger hour = second / 3600;
    NSInteger min = (second % 3600)/60;
    NSString *exchangeStr;
    switch (timeType) {
        case TIMETYPE_POINT_HOUR_MIN_SEC:
            if (hour == 0) {
                exchangeStr = [NSString stringWithFormat:@"%02ld:%02ld", min, sec];
            }else {
                exchangeStr = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", hour, min, sec];
            }
            break;
        case TIMETYPE_SYMBOL_MIN_SEC://(限1小时内,超过1小时不正确)
            if (min == 0) {
                exchangeStr = [NSString stringWithFormat:@"%02ld″",sec];
            }else {
                exchangeStr = [NSString stringWithFormat:@"%02ld'%02ld″",  min, sec];
            }
            
            break;
        case TIMETYPE_WORD_MIN://(转换成分钟,只进不舍)
            if (sec > 0) {
                exchangeStr = [NSString stringWithFormat:@"%ld分钟", hour*60 + min + 1];
            }else {
                exchangeStr = [NSString stringWithFormat:@"%ld分钟", hour*60 + min];
            }
            
            break;
        case TIMETYPE_MIN:
            if (sec > 0) {
                exchangeStr = [NSString stringWithFormat:@"%ld", hour*60 + min + 1];
            }else {
                exchangeStr = [NSString stringWithFormat:@"%ld", hour*60 + min];
            }
            break;
        default:
            break;
    }
    return exchangeStr;
}


- (NSString*)iphoneType {
    
    //需要导入头文件：#import <sys/utsname.h>
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"])  return@"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"])  return@"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"])  return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"])  return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])  return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])  return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])  return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"])  return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"])  return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])  return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,3"])  return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"])  return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone9,4"])  return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPod1,1"])  return@"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"])  return@"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"])  return@"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"])  return@"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"])  return@"iPod Touch 5G";
    
    if([platform isEqualToString:@"iPad1,1"])  return@"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"])  return@"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"])  return@"iPhone Simulator";
    
    return platform;
    
}

@end
