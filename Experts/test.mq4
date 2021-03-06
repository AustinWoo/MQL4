//+------------------------------------------------------------------+
//|                                                         test.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict




#import "QuantPrediction.dll"
string QuantPrediction_evaluate(string);
void   deletePchar(string);
#import



#include <WooInclude/GetDataH1.mqh>          //获取H1特征值数据
#include <WooInclude/GetDataM30.mqh>         //获取M30分钟线特征数据
#include <WooInclude/GetDataM15.mqh>         //获取M15分钟线特征值数据
#include <WooInclude/GetDataM5.mqh>          //获取M5分钟线特征值数据

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
   string in ;
   
   in+=GetDataH1();
   //in+=GetDataM30();
   //in+=GetDataM15();
   //in+=GetDataM5();
   
   string out = QuantPrediction_evaluate(in);
   
   string com_str;
   
   
   
   
   
  
  
   //int file_handle=FileOpen("123.txt",FILE_READ|FILE_WRITE|FILE_TXT|FILE_ANSI);
   
   //FileWriteString(file_handle,in);
   //FileClose(file_handle);
    
   //Comment(out);
   //Print(out);
   
   int r1_1 = StringReplace(out,"trend_h3:ProbabilityDistribution{result=","");
   
   int r2 = StringReplace(out,"probability_entries=[0=","");
   
   int r3 = StringReplace(out,"1=","");
   
   int r3_2 = StringReplace(out,"2=","");
   
   int r4 = StringReplace(out,"]}","");
   
   int r5 = StringReplace(out," ","");
   
   int r6 = StringReplace(out,"|",",");
   
   //com_str=out;
   //Comment(com_str);
   //Print(com_str);
   
   
   string result[];
   string sep=",";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   u_sep=StringGetCharacter(sep,0);
   int k=StringSplit(out,u_sep,result);
   
   
   com_str+="result ->";
   com_str+=result[0];
   com_str+="\n";
   com_str+="0 ->";
   com_str+=result[1];
   com_str+="\n";
   com_str+="1 ->";
   com_str+=result[2];
   com_str+="\n";
   com_str+="2 ->";
   //com_str+=result[3];
   
   Comment(com_str);
   Print(com_str);
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
