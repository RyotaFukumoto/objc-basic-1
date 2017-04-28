#import "NSString+dictionaryFromQueryString.h"

@implementation NSString (dictionaryFromQueryString)

/**
 "+"は半角スペースに置き換える.
 値の"="には何もしない（キーに=が入っている場合は、stringByReplacingPercentEscapesUsingEncoding が例外を出す）
 http://qiita.com/hal_sk/items/413ec7902f48ec39821f

 @return 例：@"title=paths_of_glory&key=year"から@{@"title":@"paths_of_glory",@"key":@"year"}ができている.
 キー、値中の"+"は半角スペースに置き換えている
 */
-(NSDictionary *) dictionaryFromQueryString{

    //NSString *query = [self query];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSArray *pairs = [self componentsSeparatedByString:@"&"];

    for (NSString *pair in pairs) {
        NSRange range = [pair rangeOfString:@"="];
        NSString *key = range.length ? [pair substringToIndex:range.location] : pair;
        NSString *val = range.length ? [pair substringFromIndex:range.location+1] : @"";
        
        key = [key stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        val = [val stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        key = [key stringByRemovingPercentEncoding];
        val = [val stringByRemovingPercentEncoding];
        [dict setObject:val forKey:key];
    }
    return dict;
}
@end
