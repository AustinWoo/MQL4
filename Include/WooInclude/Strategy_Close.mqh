//+------------------------------------------------------------------+
//|                                           Strategy_CloseRule.mqh |
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
bool Strategy_Close()
{

   //规则一    兜底
   //if(order_profit_point>0 && order_opentime_gap>=300 && order_profit_retrace_percent>0.15)   //盈利情况下，开仓时间超过120分钟，并且摸高回撤10%
   //         {
   //          comment_str+="strategy_closerule -> true";
   //          comment_str+="\n";
   //          Print("关单  ->  回撤获利");
   //          return true;
   //         }
   
   
   //规则二    
   datetime t = iTime(Symbol(),PERIOD_H1,3);
   string d = IntegerToString(TimeDay(t));
   string h = IntegerToString(TimeHour(t));
   string m = IntegerToString(TimeMinute(t));
   string t_flag=d+"-"+h+"-"+m;
   
   
   if(order_type==0 && t_flag==buy_open_flag)
     {
      return true;   
     }
     else if(order_type==1 && t_flag==sell_open_flag)
            {
             return true;
            }
            else
              {
               return false;
              }
   
   return false;
}