//+------------------------------------------------------------------+
//|                                               Check_HasOrder.mqh |
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

bool Check_HasOrder()
{
   //检查总订单数
   if(OrdersTotal()>0)
     {
      int total_order_cnt=OrdersTotal();
      
      for(int i=0;i<total_order_cnt;i++)
       {
         //检查是否有当前货币订单
        if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==true && OrderSymbol()==Symbol())
          {
           order_count++;
           has_order=true;
           //计算订单点数
           Order_Accounting(true);
           return true;
          }else
             {
               //非当前订单
               Order_Accounting(false);
               return false;
             }
       }
      //总订单数等于0
     }else
        {
         Order_Accounting(false);
         return false;
        }
        
        
   return false;
}