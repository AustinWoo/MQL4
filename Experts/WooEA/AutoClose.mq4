//+------------------------------------------------------------------+
//|                                                    AutoClose.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict




//交易过程控制信息
datetime dofore_flag;                     //最后一次执行时间标示

//订单基本信息
int      ticket_no;
string   order_symbol;
double   order_openprice;
int      order_type;         // 0 -> buy     1 -> sell
datetime order_opentime;
datetime current_time;
double   order_stoploss;
double   order_takeprofit;
double   order_lots;
int      order_magicnumber;
double   order_swap;
double   order_commission;
double   point_size;
double   minstoplevel;


//订单交易决策信息


double   order_profit;                    //当前利润
int      order_profit_point;              //当前利润(点数)
double   order_profit_max;                //最大利润
int      order_profit_max_point;          //最大利润(点数)
int      order_profit_retrace_point;      //当前最大利润回撤(点数)
double   order_profit_retrace_percent;    //当前最大利润回撤(百分比)
double   order_loss_max;                  //最大亏损
int      order_loss_max_point;            //最大亏损(点数)
int      order_opentime_gap;              //时间间隔(分钟)

int      h1_3_fore_trend;                   //h预测趋势 1->涨  0->平 2-> 跌
double   h1_3_up_trend_percent;             //涨趋势的预测百分比
double   h1_3_down_trend_percent;           //跌趋势的预测百分比
double   h1_3_na_trend_percent;             //水平趋势的预测百分比




string   buy_open_flag;                  //买单 开单时间标示
string   sell_open_flag;                 //卖单 开单时间标示

//显示信息
string   comment_str;
string   log_txt;


#include <WooInclude/Order_Accounting.mqh>   //订单计算
#include <WooInclude/Check_HasOrder.mqh>     //检查是否已经有订单
#include <WooInclude/Trade_CloseOrder.mqh>   //关单

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
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
   bool has_order = Check_HasOrder();        //是否有订单
   
   
   //+------------------------------第一步，更统计信息变量 --------------------------------------+

   Order_Accounting(has_order);

   //+------------------------------第二步，更新订单信息，并且决策关单 --------------------------------------+
   if(has_order)
     {
      //检查订单是否设定自动跟踪
      
      //判断是否关单
      
      if(order_profit_point>0 && order_opentime_gap>=300 && order_profit_retrace_percent>0.15)   //盈利情况下，开仓时间超过120分钟，并且摸高回撤10%
            {
             if(Trade_CloseOrder())                                   //执行关单
               {
                  Print("关单成功");                                 //关单成功，打印成功信息到日志
               }
               else
                 {
                  Print("关单失败 --> ",GetLastError());             //关单失败，打印失败信息到日志
                 }
            }
      
      
      //返回
      return;
      
     }else
        {
         return;
        }
  }
//+------------------------------------------------------------------+
