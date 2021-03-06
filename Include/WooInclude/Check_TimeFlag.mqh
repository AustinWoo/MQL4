//+------------------------------------------------------------------+
//|                                               Check_TimeFlag.mqh |
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

//函数 检查当前M5时间段是否执行过，是就返回true
bool Check_TimeFlag(datetime &dofore_flag)
{
   //datetime get_current_dt_m5 = iTime(Symbol(),PERIOD_M5,0);
   datetime get_current_dt = iTime(Symbol(),PERIOD_H1,0);      //暂时先改成M30的执行
   
   if(dofore_flag==get_current_dt)
     {
      return false;
     }else
        {
         dofore_flag=get_current_dt;
         return true;
        };
}