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
bool Strategy_CloseRule()
{
   //if(order_profit_point<0 && order_loss_max_point>400)  //亏损200点止损
   //  { 
   //   comment_str+="strategy_closerule -> true";
   //   comment_str+="\n"; 
   //   Print("人工规则  -> 400止损");
   //   return true;
   //  }
   //  else if(order_profit_point>0 && order_opentime_gap>90 && order_profit_retrace_percent>0.20)   //盈利情况下，开仓时间超过90分钟，并且摸高回撤10%
   //         {
   //          comment_str+="strategy_closerule -> true";
   //          comment_str+="\n";
   //          Print("人工规则  ->  回撤获利");
   //          return true;
   //         }
   //  else
   //    {   
   //     comment_str+="strategy_closerule -> false";
   //     comment_str+="\n";    
   //     return false;
   //    }
       
   return false;
   
}