//+------------------------------------------------------------------+
//|                                             Order_Accounting.mqh |
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
void Order_Accounting(bool has_order)
{
   if(has_order)
     {
         comment_str="\n";
         
         order_type=OrderType();
         comment_str+="order_type -> ";
         comment_str+=order_type;
         comment_str+="\n";
         
         ticket_no=OrderTicket();
         comment_str+="ticket_no -> ";
         comment_str+=ticket_no;
         comment_str+="\n";
         
         order_symbol=OrderSymbol();
         comment_str+="order_symbol -> ";
         comment_str+=order_symbol;
         comment_str+="\n";
         
         order_openprice=OrderOpenPrice();
         comment_str+="order_openprice -> ";
         comment_str+=order_openprice;
         comment_str+="\n";
         
         order_opentime=OrderOpenTime();
         comment_str+="order_opentime -> ";
         comment_str+=order_opentime;
         comment_str+="\n";
         
         current_time=TimeCurrent();
         comment_str+="current_time -> ";
         comment_str+=current_time;
         comment_str+="\n";
         
         order_stoploss=OrderStopLoss();
         comment_str+="order_stoploss -> ";
         comment_str+=order_stoploss;
         comment_str+="\n";
         
         order_takeprofit=OrderTakeProfit();
         comment_str+="order_takeprofit -> ";
         comment_str+=order_takeprofit;
         comment_str+="\n";
         
         order_lots=OrderLots();
         comment_str+="order_lots -> ";
         comment_str+=order_lots;
         comment_str+="\n";
         
         order_magicnumber=OrderMagicNumber();
         comment_str+="order_magicnumber -> ";
         comment_str+=order_magicnumber;
         comment_str+="\n";
         
         order_swap=OrderSwap();
         comment_str+="order_swap -> ";
         comment_str+=order_swap;
         comment_str+="\n";
         
         order_commission=OrderCommission();
         comment_str+="order_commission -> ";
         comment_str+=order_commission;
         comment_str+="\n";
         
         point_size = Point;
         comment_str+="Point -> ";
         comment_str+=point_size;
         comment_str+="\n";
         
         minstoplevel=MarketInfo(Symbol(),MODE_STOPLEVEL);
         comment_str+="minstoplevel -> ";
         comment_str+=minstoplevel;
         comment_str+="\n";
         comment_str+="\n";
         comment_str+="\n";
         comment_str+="\n";
         comment_str+="\n";
         comment_str+="\n";
         
         order_profit=OrderProfit();
         comment_str+="order_profit -> ";
         comment_str+=order_profit;
         comment_str+="\n";
         
         order_profit_point=order_profit/order_lots;
         comment_str+="order_profit_point -> ";
         comment_str+=order_profit_point;
         comment_str+="\n";
         
         
         if(order_profit>order_profit_max)
           {
            order_profit_max=order_profit;
           }
         comment_str+="order_profit_max -> ";
         comment_str+=order_profit_max;
         comment_str+="\n";
         
         order_profit_max_point=order_profit_max/order_lots;
         comment_str+="order_profit_max_point -> ";
         comment_str+=order_profit_max_point;
         comment_str+="\n";
         
         if(order_profit_point>0)
           {
            order_profit_retrace_point=(order_profit_max-order_profit)/order_lots;
            comment_str+="order_profit_retrace_point -> ";
            comment_str+=order_profit_retrace_point;
            comment_str+="\n";
           }
         
         
         if(order_profit_point>0)
           {
            order_profit_retrace_percent=NormalizeDouble(order_profit_retrace_point,8)/NormalizeDouble(order_profit_max_point,8);
            comment_str+="order_profit_retrace_percent -> ";
            comment_str+=order_profit_retrace_percent;
            comment_str+="\n";
           }
         
         int year_int = (TimeYear(current_time)-TimeYear(order_opentime))*525600;
         int day_int = (TimeDayOfYear(current_time)-TimeDayOfYear(order_opentime))*1440;
         int hour_int = (TimeHour(current_time)-TimeHour(order_opentime))*60;
         int minute_int = TimeMinute(current_time)-TimeMinute(order_opentime);
         order_opentime_gap=year_int+day_int+hour_int+minute_int;
         comment_str+="order_opentime_gap -> ";
         comment_str+=order_opentime_gap;
         comment_str+="\n";
         
         
         if(order_profit<order_loss_max)
           {
            order_loss_max=order_profit;
           }
         comment_str+="order_loss_max -> ";
         comment_str+=order_loss_max;
         comment_str+="\n";
         
         order_loss_max_point=-1*order_loss_max/order_lots;
         comment_str+="order_loss_max_point -> ";
         comment_str+=order_loss_max_point;
         comment_str+="\n";
         comment_str+="\n";
         comment_str+="\n";
         comment_str+="\n";
         comment_str+="\n";
         
     }else
        {
         
         
         comment_str="no order";
        
         
        }
           
}