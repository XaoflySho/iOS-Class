## XSString

### 方法

**移除字符串中的HTML标签**

```objective-c
- (NSString *)stringByRemovingHTMLMark;
```

**生成一个由大写英文字母组成的随机字符串**

```objective-c
+ (NSString *)generatesRandomStringWithLength:(int)lenght;
```

**将JSON对象（NSArray、NSDictionary）转换为字符串**

```objective-c
+ (NSString *)stringByJSONObject:(id)JSONObject;
```


**对字符串进行SHA1计算**

```objective-c
- (NSString *) sha1;
```

**对字符串进行MD5计算**

```objective-c
- (NSString *) md5;
```
