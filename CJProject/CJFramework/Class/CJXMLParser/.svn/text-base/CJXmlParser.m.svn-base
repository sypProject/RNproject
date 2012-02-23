//
//  CJXmlParser.m
//  CJFramework
//
//  Created by solaster on 11-11-21.
//  Copyright (c) 2011年 datou. All rights reserved.
//

#import "CJXmlParser.h"

#pragma mark -
#pragma CJXmlParser (Private)

@interface CJXmlParser (Private)

-(id)initWithXmlData:(NSData *)aXmlData;
-(id)initWithFile:(NSString *)aFile;
-(id)initWithRootElement:(CJXmlElement *)aRootEle;

@end

#pragma mark -
#pragma CJXmlParser

@implementation CJXmlParser

@synthesize xmlDoc = _xmlDoc;

+(CJXmlParser *)parserWithXmlData:(NSData *)aXmlData {
    CJLOG_NULLPOINT(aXmlData);
    CJXmlParser * _xml_parser = [[CJXmlParser alloc] initWithXmlData:aXmlData];
    CJLOG_NULLPOINT(_xml_parser);
    return [_xml_parser autorelease];
}

+(CJXmlParser *)parserWithFile:(NSString *)aFile {
    CJLOG_NULLPOINT(aFile);
    CJXmlParser * _xml_parser = [[CJXmlParser alloc] initWithFile:aFile];
    CJLOG_NULLPOINT(_xml_parser);
    return [_xml_parser autorelease];
}

+(CJXmlParser *)parserWithRootElement:(CJXmlElement *)aRootEle {
    CJLOG_NULLPOINT(aRootEle);
    CJXmlParser * _xml_parser = [[CJXmlParser alloc] initWithRootElement:aRootEle];
    CJLOG_NULLPOINT(_xml_parser);
    return [_xml_parser autorelease];
}

-(void)dealloc {
    CJRelease(_xmlDoc);
    [super dealloc];
}

-(void)saveFile:(NSString *)aFile {
    CJLOG_NULLPOINT(aFile);
    CJFileHandle * _file_handle = nil;
    if ([[CJFileManager defaultManager] fileExistsAtPath:aFile] == NO){
        _file_handle = [CJFileHandle fileHandleCreateFile:aFile mode:CJFileReadWriteMode];
        
    }
    else{
        _file_handle = [CJFileHandle fileHandleOpenFile:aFile mode:CJFileReadWriteMode];
    }
    CJLOG_NULLPOINT(_file_handle);
    NSData * _xml_data = [self getXmlData];
    CJLOG_NULLPOINT(_xml_data);
    [_file_handle writeData:_xml_data];
}

-(NSData *)getXmlData {
    return [_xmlDoc XMLData];
}

-(void)setVersion:(NSString *)aVersion {
    [_xmlDoc setVersion:aVersion];
}

-(void)setCharacterEncoding:(NSString *)aEncoding {
    [_xmlDoc setCharacterEncoding:aEncoding];
}

-(CJXmlElement *)getRootElement {
    CJXmlElement * _xml_element = [CJXmlElement elementWithElement:[_xmlDoc rootElement]];
    CJLOG_NULLPOINT(_xml_element);
    return _xml_element;
}

-(void)addElement:(CJXmlElement *)aParent elementName:(NSString *)aEleName {
    CJLOG_NULLPOINT(aParent);
    CJLOG_NULLPOINT(aEleName);
    CJXmlElement * _xml_element = [CJXmlElement elementWithName:aEleName];
    CJLOG_NULLPOINT(_xml_element);
    [aParent.xmlElement addChild:_xml_element.xmlElement];
}

-(void)removeElement:(CJXmlElement *)aParent elementName:(NSString *)aEleName {
    CJLOG_NULLPOINT(aParent);
    CJLOG_NULLPOINT(aEleName);
    for (int i = 0; i < [aParent.xmlElement childCount]; i++) {
        if ([[aParent.xmlElement childAtIndex:i] stringValue] == aEleName) {
            [aParent.xmlElement removeChild:[aParent.xmlElement childAtIndex:i]];
            break;
        }
    }
}

#pragma mark -
#pragma CJXmlparser (Private)

-(id)initWithXmlData:(NSData *)aXmlData {
    CJLOG_NULLPOINT([super init]);
    CJLOG_NULLPOINT(aXmlData);
    CJASSERT(([aXmlData length] >0),"XML_FILE_EMPTY");
    NSError * _error = nil;
    _xmlDoc = [[GDataXMLDocument alloc] initWithData:aXmlData options:0 error:&_error];
    CJLOG_NSERROR(_error);
    CJLOG_NULLPOINT(_xmlDoc);
    CJLOG_NULLPOINT(self);
    return self;
}

-(id)initWithFile:(NSString *)aFile {
    CJLOG_NULLPOINT([super init]);
    CJLOG_NULLPOINT(aFile);
    NSLog(@"path is %@",aFile);
    CJFileHandle * _file_handle = nil;
    if ([[CJFileManager defaultManager] fileExistsAtPath:aFile] == NO){
        _file_handle = [CJFileHandle fileHandleCreateFile:aFile mode:CJFileReadWriteMode];
    
    }
    else{
        _file_handle = [CJFileHandle fileHandleOpenFile:aFile mode:CJFileReadWriteMode];
    }
    CJLOG_NULLPOINT(_file_handle);
    NSData * _xml_data = [_file_handle availableData];
    CJLOG_NULLPOINT(_xml_data);
    CJASSERT(([_xml_data length] >0),"XML_FILE_EMPTY");
    NSError * _error = nil;
    _xmlDoc = [[GDataXMLDocument alloc] initWithData:_xml_data options:0 error:&_error];
    CJLOG_NSERROR(_error);
    CJLOG_NULLPOINT(_xmlDoc);
    CJLOG_NULLPOINT(self);
    return self;
}

-(id)initWithRootElement:(CJXmlElement *)aRootEle {
    CJLOG_NULLPOINT(aRootEle);
    _xmlDoc = [[GDataXMLDocument alloc] initWithRootElement:aRootEle.xmlElement];
    CJLOG_NULLPOINT(_xmlDoc);
    CJLOG_NULLPOINT(self);
    return self;
}

@end



#pragma mark -
#pragma CJXmlElements (Privare)

@interface CJXmlElement (Private)

-(id)initWithName:(NSString *)aName;

@end

#pragma mark -
#pragma CJXmlElement

@implementation CJXmlElement

@synthesize xmlElement = _xmlElement;

-(void)dealloc {
    CJRelease(_xmlElement);
    [super dealloc];
}

+(CJXmlElement *)elementWithName:(NSString *)aName {
    CJLOG_NULLPOINT(aName);
    CJXmlElement * _xml_element = [[CJXmlElement alloc] initWithName:aName];
    CJLOG_NULLPOINT(_xml_element);
    return [_xml_element autorelease];
}

+(CJXmlElement *)elementWithElement:(GDataXMLElement *)otherElement {
    CJLOG_NULLPOINT(otherElement);
    CJXmlElement * _xml_element = [[CJXmlElement alloc] init];
    CJLOG_NULLPOINT(_xml_element);
    _xml_element.xmlElement = otherElement;
    return [_xml_element autorelease];
}

-(NSString *)getName {
    NSString * _name = [self.xmlElement name];
    CJLOG_NULLPOINT(_name);
    return _name;
}

-(void)setName:(NSString *)aName {
    CJLOG_NULLPOINT(aName);
    [self.xmlElement setStringValue:aName];
}

-(NSArray *)getAttributeSet {
    return [self.xmlElement attributes];
}

-(NSString *)getAttribute:(NSString *)aAttrName {
    CJLOG_NULLPOINT(aAttrName);
    GDataXMLNode * _node = [self.xmlElement attributeForName:aAttrName];
    CJLOG_NULLPOINT(_node);
    return [_node stringValue];
}

-(NSInteger)getIntAttribute:(NSString *)aAttrName {
    CJLOG_NULLPOINT(aAttrName);
    GDataXMLNode * _node = [self.xmlElement attributeForName:aAttrName];
    CJLOG_NULLPOINT(_node);
    return atoi([[_node stringValue] UTF8String]);
}

-(NSUInteger)getUintAttribute:(NSString *)aAttrName {
    CJLOG_NULLPOINT(aAttrName);
    GDataXMLNode * _node = [self.xmlElement attributeForName:aAttrName];
    CJLOG_NULLPOINT(_node);
    return strtoul([[_node stringValue] UTF8String],0,10);
}

-(void)setAttribute:(NSString *)aAttrName attrValue:(NSString *)aAttrValue {
    CJLOG_NULLPOINT(aAttrName);
    CJLOG_NULLPOINT(aAttrValue);
    GDataXMLNode * _node = [GDataXMLNode elementWithName:aAttrName stringValue:aAttrValue];
    CJLOG_NULLPOINT(_node);
    [self.xmlElement addAttribute:_node];
}

-(void)setIntAttribute:(NSString *)aAttrName attrValue:(NSInteger)aAttrValue {
    CJLOG_NULLPOINT(aAttrName);
    NSString * _attr_value = [NSString stringWithFormat:@"%d",aAttrValue];
    GDataXMLNode * _node = [GDataXMLNode elementWithName:aAttrName stringValue:_attr_value];
    CJLOG_NULLPOINT(_node);
    [self.xmlElement addAttribute:_node];
}

-(void)setUintAttribute:(NSString *)aAttrName attrValue:(NSUInteger)aAttrValue {
    CJLOG_NULLPOINT(aAttrName);
    NSString * _attr_value = [NSString stringWithFormat:@"%u",aAttrValue];
    GDataXMLNode * _node = [GDataXMLNode elementWithName:aAttrName stringValue:_attr_value];
    CJLOG_NULLPOINT(_node);
    [self.xmlElement addAttribute:_node];
}

-(NSString *)getContent {
    NSString * _content = [self.xmlElement stringValue];
    CJLOG_NULLPOINT(_content);
    return _content;
}

-(NSInteger)getIntContent {
    NSString * _content = [self.xmlElement stringValue];
    CJLOG_NULLPOINT(_content);
    return atoi([_content UTF8String]);
}

-(NSUInteger)getUintContent {
    NSString * _content = [self.xmlElement stringValue];
    CJLOG_NULLPOINT(_content);
    return strtoul([_content UTF8String],0,10);
}


-(void)setContent:(NSString *)aContent {
    CJLOG_NULLPOINT(aContent);
    GDataXMLNode * _content = [GDataXMLNode textWithStringValue:aContent];
    CJLOG_NULLPOINT(_content);
    [self.xmlElement addChild:_content];
}

-(void)setIntContent:(NSInteger)aContent {
    NSString * _content_value = [NSString stringWithFormat:@"%d",aContent];
    GDataXMLNode * _content = [GDataXMLNode textWithStringValue:_content_value];
    CJLOG_NULLPOINT(_content);
    [self.xmlElement addChild:_content];
}

-(void)setUintContent:(NSUInteger)aContent {
    NSString * _content_value = [NSString stringWithFormat:@"%u",aContent];
    GDataXMLNode * _content = [GDataXMLNode textWithStringValue:_content_value];
    CJLOG_NULLPOINT(_content);
    [self.xmlElement addChild:_content];
}

#pragma mark -
#pragma CJXmlElement (Private)

-(id)initWithName:(NSString *)aName {
    CJLOG_NULLPOINT([super init]);
    _xmlElement = [GDataXMLElement elementWithName:aName];
    CJLOG_NULLPOINT(_xmlElement);
    [_xmlElement retain];
    CJLOG_NULLPOINT(self);
    return self;
}

@end
