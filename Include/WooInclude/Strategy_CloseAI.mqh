//+------------------------------------------------------------------+
//|                                               Strategy_Close.mqh |
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

bool Strategy_CloseAI()
{
   if(order_type==0 && h3_fore_trend==0)             //当buy单的时候，预测跌，返回关单
     {
      //Print("算法规则-关单");
      return true;
      
     }
     else if(order_type==1 && h3_fore_trend==1)      //当sell单的时候，预测涨，返回关单
            {
             //Print("算法规则-关单");
             return true;
            }
            else
              {
               return false;
              }
   
}