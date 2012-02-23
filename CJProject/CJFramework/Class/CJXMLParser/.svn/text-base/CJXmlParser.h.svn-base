//
//  CJXmlParser.h
//  CJFramework
//
//  Created by solaster on 11-11-21.
//  Copyright (c) 2011年 datou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
#import "CJFileHandle.h"
#import "CJFileManager.h"
#import "CJLog.h"

@class CJXmlElement;

@interface CJXmlParser : NSObject {
    
@protected
    
    // pointer to the XML document
    GDataXMLDocument * _xmlDoc;
}


@property (nonatomic, retain) GDataXMLDocument * xmlDoc;

// the static constructor
+(CJXmlParser *) parserWithXmlData:(NSData *)aXmlData;
+(CJXmlParser *) parserWithFile:(NSString *)aFile;
+(CJXmlParser *) parserWithRootElement:(CJXmlElement *)aRootEle;

// set the default Version
- (void)setVersion:(NSString *)aVersion;

// set the default encoding;
- (void)setCharacterEncoding:(NSString *)aEncoding;

//return the xmlData stream
-(NSData *)getXmlData;

// save XML file to disk
-(void) saveFile:(NSString *)aFile;

// return the root node of the XML document
-(CJXmlElement *) getRootElement;

// add an XML node to the specified parent
-(void) addElement:(CJXmlElement *)aParent elementName:(NSString *)aEleName;

// remove a XML node of the sprcified parent
-(void)removeElement:(CJXmlElement *)aParent elementName:(NSString *)aEleName;

@end

@interface CJXmlElement : NSObject {
    
@protected
    
    // pointer to the XML element
    GDataXMLElement * _xmlElement;
}

@property (nonatomic, retain) GDataXMLElement * xmlElement;

// static constructors
+(CJXmlElement *)elementWithName:(NSString *)aName;
+(CJXmlElement *)elementWithElement:(GDataXMLElement *)otherElement;

// set the element name of myself
-(void)setName: (NSString *)aName;

// return the element name of myself
-(NSString *)getName;

//return all of the attributes of myself
-(NSArray *)getAttributeSet;

// set attribute according to the specified attribute name & value, if it has exist, update it, else add it to myself
-(void)setAttribute:(NSString *)aAttrName attrValue:(NSString *)aAttrValue;
-(void)setIntAttribute:(NSString *)aAttrName attrValue:(NSInteger)aAttrValue;
-(void)setUintAttribute:(NSString *)aAttrName attrValue:(NSUInteger)aAttrValue;

// update the content of myself
-(void)setContent:(NSString *)aContent;
-(void)setIntContent:(NSInteger)aContent;
-(void)setUintContent:(NSUInteger)aContent;

// get the attribute value accoridng to the specified attribute name 
-(NSString *)getAttribute:(NSString *)aAttrName;
-(NSInteger)getIntAttribute:(NSString *)aAttrName;
-(NSUInteger)getUintAttribute:(NSString *)aAttrName;

// get the content of my self
-(NSString *)getContent;
-(NSInteger)getIntContent;
-(NSUInteger)getUintContent;

@end


