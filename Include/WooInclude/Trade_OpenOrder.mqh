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

//--- get minimum stop level
   //double minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
   //Print("Minimum Stop Level=",minstoplevel," points");
   double price=Ask;
//--- calculated SL and TP prices must be normalized
   double stoploss=NormalizeDouble(Bid-200*Point,Digits);
   double takeprofit=NormalizeDouble(Bid+1000*Point,Digits);
//--- place market order to buy 0.01 lot
   int ticket=OrderSend(Symbol(),OP_BUY,0.01,price,3,stoploss,takeprofit,"test order",0,0,clrGreen);
   if(ticket<0)
     {
      Print("OrderSend failed with error #",GetLastError());
     }
   else
      Print("OrderSend placed successfully");
//---
   return ticket;
}