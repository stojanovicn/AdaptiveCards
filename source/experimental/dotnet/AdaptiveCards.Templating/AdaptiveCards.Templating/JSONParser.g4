/** Taken from "The Definitive ANTLR 4 Reference" by Terence Parr */

// Derived from http://json.org
parser grammar JSONParser;
options { tokenVocab=JSONLexer; }

json
   : value
   ;

obj
   : LCB pair (COMMA pair)* RCB
   | LCB RCB
   ;

pair
   : StringDeclOpen STRING CLOSE COLON value    # jsonPair
   | StringDeclOpen TEMPLATEDATA CLOSE COLON value # templateData
   | StringDeclOpen TEMPLATEWHEN CLOSE COLON templateExpression # templateWhen
   ;

array
   : LSB value (COMMA value)* RSB
   | LSB RSB
   ;

value
   : StringDeclOpen STRING CLOSE # valueString
   | StringDeclOpen templateRootDataContext CLOSE # valueTemplateRootData
   | StringDeclOpen templateString CLOSE # valueTemplateString
   | NUMBER # valueNumber
   | obj    # valueObject
   | array  # valueArray
   | TRUE # valueTrue
   | FALSE # valueFalse
   | NULL  # valueNull
   ;

templateRootDataContext
   : TemplateOpen TEMPLATEROOT TEMPLATECLOSE # valueTemplateRootDataContext
   ;


templateString
   : (STRING? TemplateOpen TEMPLATELITERAL TEMPLATECLOSE STRING?)+ 
   ;

templateExpression
   : StringDeclOpen TemplateOpen TEMPLATELITERAL TEMPLATECLOSE CLOSE # valueTemplateExpression
   ;

