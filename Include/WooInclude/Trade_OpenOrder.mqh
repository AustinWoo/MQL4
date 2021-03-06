//+------------------------------------------------------------------+
//|                                              Trade_OpenOrder.mqh |
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
int Trade_OpenOrder()
{

   
   int ticket=-1;    //默认先置成失败
   
   if(h1_3_fore_trend==1)                                                 //预测涨趋势，开买单
     {
         double price=Ask;                                              //取当前最新报价
         double stoploss=NormalizeDouble(Ask-600*Point,Digits);         //计算止损
         double takeprofit=NormalizeDouble(Ask+6000*Point,Digits);      //计算止盈
         ticket=OrderSend(Symbol(),OP_BUY,0.01,price,3,stoploss,takeprofit,"",0,0,clrGreen);     //开单，并返回订单号码，如果返回-1，则表示失败，(0.01手)
         
     }   
     else if(h1_3_fore_trend==0)
            {
               double price=Bid;                                           //取当前最新报价
               double stoploss=NormalizeDouble(Bid+600*Point,Digits);         //计算止损
               double takeprofit=NormalizeDouble(Bid-6000*Point,Digits);      //计算止盈
               ticket=OrderSend(Symbol(),OP_SELL,0.01,price,3,stoploss,takeprofit,"",0,0,clrGreen);     //开单，并返回订单号码，如果返回-1，则表示失败，(0.01手)
               
            }    
  
//---
   return ticket;                                                    //返回订单号码
}