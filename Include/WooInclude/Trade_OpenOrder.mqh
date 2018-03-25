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

   double price=Ask;                                              //取当前最新报价
//--- calculated SL and TP prices must be normalized
   double stoploss=NormalizeDouble(Bid-200*Point,Digits);         //计算止损
   double takeprofit=NormalizeDouble(Bid+5000*Point,Digits);      //计算止盈
   
   
//--- place market order to buy 0.01 lot
   int ticket=OrderSend(Symbol(),OP_BUY,0.01,price,3,stoploss,takeprofit,"test order",0,0,clrGreen);     //开单，并返回订单号码，如果返回-1，则表示失败，(0.01手)
   
   if(ticket<0)
     {
      Print("OrderSend failed with error #",GetLastError());         //下单失败，打印错误信息到日志
     }
   else
      Print("OrderSend placed successfully");                        //下单成功，打印成功信息到日志
//---
   return ticket;                                                    //返回订单号码
}