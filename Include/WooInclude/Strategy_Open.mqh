//+------------------------------------------------------------------+
//|                                                Strategy_Open.mqh |
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
bool Strategy_Open()
{

   datetime t = iTime(Symbol(),PERIOD_H1,0);
   string d = IntegerToString(TimeDay(t));
   string h = IntegerToString(TimeHour(t));
   string m = IntegerToString(TimeMinute(t));
   string t_flag=d+"-"+h+"-"+m;
   
   if(h1_3_fore_trend==1 && h1_3_up_trend_percent>0.55)                 //当算法预测涨，并且系数超过70%，决策开买单
     {
      buy_open_flag=t_flag;   //打上开 买单标示
      return true;
     }
     
     else if(h1_3_fore_trend==0 && h1_3_down_trend_percent>0.55)        //当算法预测跌，并且系数超过70%，决策开卖单
             {
               sell_open_flag=t_flag;     //打上开 卖单标示
              return true;
             }
             else
                {
                 return false;
                 
                }
                
                
   
}