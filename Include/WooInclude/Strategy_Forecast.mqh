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
   
   in=GetDataH1();
   
   string out = QuantPrediction_evaluate(in);
   
   
   
   int r1_1 = StringReplace(out,"trend_h3:ProbabilityDistribution{result=","");
   
   int r2 = StringReplace(out,"probability_entries=[0=","");
   
   int r3 = StringReplace(out,"1=","");
   
   int r3_2 = StringReplace(out,"2=","");
   
   int r4 = StringReplace(out,"]}","");
   
   int r5 = StringReplace(out," ","");
   
   int r6 = StringReplace(out,"|",",");
   
   
   string result[];
   string sep=",";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   u_sep=StringGetCharacter(sep,0);
   int k=StringSplit(out,u_sep,result);
   
   
   h1_3_fore_trend=StringToInteger(result[0]);
   h1_3_up_trend_percent=StringToDouble(result[2]);
   h1_3_down_trend_percent=StringToDouble(result[1]);
   //h1_3_na_trend_percent=StringToDouble(result[1]);
   
   
   //Print("预测 --> "+IntegerToString(h3_fore_trend)+":"+"up ->"+DoubleToString(h3_up_trend_percent)+"/down ->"+DoubleToString(h3_down_trend_percent));
   datetime get_current_dt = iTime(Symbol(),PERIOD_H1,1);
   //log_txt += TimeToString(get_current_dt);
   //log_txt += " Close_H -> " + iClose(Symbol(),PERIOD_H1,1);
   //log_txt += " Close_D -> " + iClose(Symbol(),PERIOD_D1,1);
   //log_txt += " trend -> "+ h1_3_fore_trend;
   
   
   //log_txt += " 0 -> " + h1_3_na_trend_percent;
   //log_txt += " 1 -> " + h1_3_up_trend_percent;
   //log_txt += " 2 -> " + h1_3_down_trend_percent;
   
   //log_txt += " out -> " + out;
   
   //log_txt += "\n";
   
   //log_txt = TimeToString(get_current_dt)+"\n";
   //log_txt += GetDataH1_TXT();
   
   
   datetime t = iTime(Symbol(),PERIOD_H1,0);
   string d = IntegerToString(TimeDay(t));
   string h = IntegerToString(TimeHour(t));
   string m = IntegerToString(TimeMinute(t));
   string t_flag=d+"-"+h+"-"+m;
   
   
   if(h1_3_fore_trend==1 && h1_3_up_trend_percent>0.55)
     {
      buy_open_flag=t_flag;
      //Print("涨 -> "+h3_up_trend_flag);
     }
     else if(h1_3_fore_trend==0 && h1_3_down_trend_percent>0.55)
            {
             sell_open_flag=t_flag;
             //Print("跌 -> "+h3_down_trend_flag);
            }
   
   return;
}