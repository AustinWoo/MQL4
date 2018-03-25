//+------------------------------------------------------------------+
//|                                                   myddl_test.mq4 |
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

//#import "DLLSample.dll"
//int    GetIntValue(int);
//#import

//2018.03.25 10:04:28.860	Cannot load 'C:\Users\AustinWoo\AppData\Roaming\MetaQuotes\Terminal\BB190E062770E27C3E79391AB0D1A117\MQL4\Experts\QuantPrediction.dll' [126]


int gobal;
string in;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   int i = 5;
   //int o = QuantPrediction_evaluate(5);
   //Print("return value is ",i);
   Comment("initial");
   in="gapbid_pre_d1:0.0008,pricetimehour:16,downbar_d3:0,gapbid_pre_h3:0.0044,highlow_d7:0,gapbid_pre_h2:0.0037,downbar_d9:0,upbar_d13:0,downbar_d1:0,openclose_d12:0,downbar_d4:0";
   //struct MqlString o={1000};//="apbid_pre_d1:0.0008,pricetimehour:16,downbar_d3:0,gapbid_pre_h3:0.0044,highlow_d7:0,gapbid_pre_h2:0.0037,downbar_d9:0,upbar_d13:0,downbar_d1:0,openclose_d12:0,downbar_d4:0";
   string o;
   o= QuantPrediction_evaluate(in);
   Comment(o);
   in="gapbid_pre_d1:0.0308,pricetimehour:16,downbar_d3:0,gapbid_pre_h3:0.0044,highlow_d7:0,gapbid_pre_h2:0.0037,downbar_d9:0,upbar_d13:0,downbar_d1:0,openclose_d12:0,downbar_d4:0";
   o= QuantPrediction_evaluate(in);
   Comment(o);
   //deletePchar(o);
   //Comment(GetIntValue(2));
   gobal=0;
   //Comment("end initial");
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
      //int i = 5;
   //Comment(QuantPrediction_evaluate(10));
   //Print("return value is ",i);
   //Comment(QuantPrediction_evaluate(10));
   //string o;// = "hello123123123123123123123123123123123123111111122222222222222222222222222222222222222222222222222222222213fsfsdffffffffffffffffffffffffffffffff";
   //o=QuantPrediction_evaluate(in);
   //Comment(GetIntValue(gobal));
   //deletePchar(o);
   //Comment(GetIntValue(gobal));
   gobal = gobal+1;
  }
//+------------------------------------------------------------------+
