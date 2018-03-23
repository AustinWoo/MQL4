//+------------------------------------------------------------------+
//|                                                         test.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict


#import "DLLSample.dll"
int    GetIntValue(int);
#import


#import "QuantPrediction.dll"
   int QuantPrediction_evaluate(int features);
#import

int ticket;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
  int ord_cnt=OrdersTotal();
  for(int i=0;i<ord_cnt;i++)
    {
     if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
       {
        Comment(OrderType(),"\n",OrderTicket(),"\n",OrderTakeProfit());
        ticket = OrderTicket();
       }
    }
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
