//+------------------------------------------------------------------+
//|                                                    EURUSD_EA.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict


//+------------------------------全局变量  begin ------------------------------------+

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

//+------------------------------全局变量  end ------------------------------------+



#import "QuantPrediction.dll"
string QuantPrediction_evaluate(string);
void   deletePchar(string);
#import



#include <WooInclude/GetDataH1.mqh>          //获取H1特征值数据
#include <WooInclude/GetDataH1_TXT.mqh>
#include <WooInclude/GetDataM30.mqh>         //获取M30分钟线特征数据
#include <WooInclude/GetDataM15.mqh>         //获取M15分钟线特征值数据
#include <WooInclude/GetDataM5.mqh>          //获取M5分钟线特征值数据
#include <WooInclude/Order_Accounting.mqh>   //订单计算
#include <WooInclude/Check_TimeFlag.mqh>     //函数 检查当前M5时间段是否执行过，是就返回true
#include <WooInclude/Check_HasOrder.mqh>     //检查是否已经有订单
#include <WooInclude/Strategy_Close.mqh>     //关单策略
#include <WooInclude/Strategy_Open.mqh>      //开单策略
#include <WooInclude/Trade_OpenOrder.mqh>    //开单
#include <WooInclude/Trade_CloseOrder.mqh>   //关单
#include <WooInclude/Strategy_Forecast.mqh>  //算法预测


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
   
   

//+------------------------------第一步，更新算法预测变量 ------------------------------------+

   if(Check_TimeFlag(dofore_flag))          //先检查算法预测的时间间隔，如果满足则执行预测
     {
         Strategy_Forecast();               //调算法预测，获取预测结构
         Print("预测 -> " + h1_3_fore_trend+" -> "+h1_3_up_trend_percent+" -> "+h1_3_na_trend_percent+" -> "+h1_3_down_trend_percent+" buy_open_flag -> "+ buy_open_flag + " sell_open_flag -> "+sell_open_flag);
         
         
         //log_txt=GetDataH1();
         
         //int file_handle=FileOpen("ea_log_ffff.txt",FILE_READ|FILE_WRITE|FILE_TXT|FILE_ANSI);
         //FileWriteString(file_handle,log_txt);
         //FileClose(file_handle);
     }


//+------------------------------第二步，更统计信息变量 --------------------------------------+


   Order_Accounting(has_order);


//+------------------------------第三步，做关单或者开单决策 --------------------------------------+

if(has_order)                                           //判断是否有订单
  {
   if(Strategy_Close())                                        //有订单，则执行关单策略，判断是否关单
   {
      if(Trade_CloseOrder())                                   //判断满足，执行关单
         {
            Print("关单成功");                                 //关单成功，打印成功信息到日志
         }
         else
           {
            Print("关单失败 --> ",GetLastError());             //关单失败，打印失败信息到日志
           }
           
      return;                                                  //返回
   }
  }else                                                        //没有定，则执行开单策略，判断是否开单
     {
      if(Strategy_Open())                                      //判断是否满足开单策略
         {
            if(Trade_OpenOrder()<0)                            //满足开单策略，开单并返回
                    {
                     Print("开单失败 --> ",GetLastError());    //打印失败开单信息
                    }
                    else
                      {
                       Print("开单成功");                      //打印成功开单信息
                      }
         }
         
       return;                                                 //返回
     }


  
  }
//+------------------------------------------------------------------+


