//+------------------------------------------------------------------+
//|                                            Strategy_Forecast.mqh |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property strict
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
// #define MacrosHello   "Hello, world!"
// #define MacrosYear    2010
//+------------------------------------------------------------------+
//| DLL imports                                                      |
//+------------------------------------------------------------------+
// #import "user32.dll"
//   int      SendMessageA(int hWnd,int Msg,int wParam,int lParam);
// #import "my_expert.dll"
//   int      ExpertRecalculate(int wParam,int lParam);
// #import
//+------------------------------------------------------------------+
//| EX5 imports                                                      |
//+------------------------------------------------------------------+
// #import "stdlib.ex5"
//   string ErrorDescription(int error_code);
// #import
//+------------------------------------------------------------------+


void Strategy_Forecast()
{

   string in = GetDataH1();
   
   string out = QuantPrediction_evaluate(in);
   
   int r1 = StringReplace(out,"trend_h3:ProbabilityDistribution{result=","");
   
   int r2 = StringReplace(out,"probability_entries=[0=","");
   
   int r3 = StringReplace(out,"1=","");
   
   int r4 = StringReplace(out,"]}","");
   
   int r5 = StringReplace(out," ","");
   
   string result[];
   string sep=",";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   u_sep=StringGetCharacter(sep,0);
   int k=StringSplit(out,u_sep,result);
   
   
   h3_fore_trend=StringToInteger(result[0]);
   h3_up_trend_percent=StringToDouble(result[2]);
   h3_down_trend_percent=StringToDouble(result[1]);
   
   //Print("预测 --> "+IntegerToString(h3_fore_trend)+":"+"up ->"+DoubleToString(h3_up_trend_percent)+"/down ->"+DoubleToString(h3_down_trend_percent));
   
   return;
}