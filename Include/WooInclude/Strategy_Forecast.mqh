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
  string in ;
   
   in+=GetDataH1();
   in+=GetDataM30();
   in+=GetDataM15();
   in+=GetDataM5();
   
   string out = QuantPrediction_evaluate(in);
   
   int r1_1 = StringReplace(out,"trend_h1:ProbabilityDistribution{result=","");
   
   int r1_2 = StringReplace(out,"trend_m30_3:ProbabilityDistribution{result=","");
   
   int r1_3 = StringReplace(out,"trend_m15_3:ProbabilityDistribution{result=","");
   
   int r1_4 = StringReplace(out,"trend_m5_3:ProbabilityDistribution{result=","");
   
   int r2 = StringReplace(out,"probability_entries=[0=","");
   
   int r3 = StringReplace(out,"1=","");
   
   int r4 = StringReplace(out,"]}","");
   
   int r5 = StringReplace(out," ","");
   
   int r6 = StringReplace(out,"|",",");
   
   
   string result[];
   string sep=",";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   u_sep=StringGetCharacter(sep,0);
   int k=StringSplit(out,u_sep,result);
   
   
   h1_1_fore_trend=StringToInteger(result[0]);
   h1_1_up_trend_percent=StringToDouble(result[2]);
   h1_1_down_trend_percent=StringToDouble(result[1]);
   
   m30_3_fore_trend=StringToInteger(result[3]);
   m30_3_up_trend_percent=StringToDouble(result[5]);
   m30_3_down_trend_percent=StringToDouble(result[4]);
   
   m15_3_fore_trend=StringToInteger(result[6]);
   m15_3_up_trend_percent=StringToDouble(result[8]);
   m15_3_down_trend_percent=StringToDouble(result[7]);
   
   m5_3_fore_trend=StringToInteger(result[9]);
   m5_3_up_trend_percent=StringToDouble(result[11]);
   m5_3_down_trend_percent=StringToDouble(result[10]);
   
   
   //Print("预测 --> "+IntegerToString(h3_fore_trend)+":"+"up ->"+DoubleToString(h3_up_trend_percent)+"/down ->"+DoubleToString(h3_down_trend_percent));
   
   
   
   //datetime t = iTime(Symbol(),PERIOD_H1,0);
   //string d = IntegerToString(TimeDay(t));
   //string h = IntegerToString(TimeHour(t));
   //string t_flag=d+"-"+h;
   
   
   
   //if(h3_fore_trend==1 && h3_up_trend_percent>0.75)
   //  {
   //   h3_up_trend_flag=t_flag;
      //Print("涨 -> "+h3_up_trend_flag);
   //  }
   //  else if(h3_fore_trend==0 && h3_down_trend_percent>0.75)
   //         {
   //          h3_down_trend_flag=t_flag;
             //Print("跌 -> "+h3_down_trend_flag);
   //         }
   
   return;
}