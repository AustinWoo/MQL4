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
datetime dt_m5_flag;       //当前5分钟线是否执行预测标示位
//bool     has_order;        //是否有订单标示位        
//int      order_count;      //当前账户总订单数

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

int      h3_fore_trend;                   //h3预测趋势 1->涨  0->跌
double   h3_up_trend_percent;             //涨趋势的预测百分比
double   h3_down_trend_percent;           //跌趋势的预测百分比

//显示信息
string   comment_str;


//+------------------------------全局变量  end ------------------------------------+



#import "QuantPrediction.dll"
string QuantPrediction_evaluate(string);
void   deletePchar(string);
#import



#include <WooInclude/GetDataH1.mqh>          //获取H1特征值数据
#include <WooInclude/GetDataM30.mqh>         //获取M30分钟线特征数据
#include <WooInclude/GetDataM15.mqh>         //获取M15分钟线特征值数据
#include <WooInclude/GetDataM5.mqh>          //获取M5分钟线特征值数据
#include <WooInclude/Order_Accounting.mqh>   //订单计算
#include <WooInclude/Check_TimeFlag.mqh>     //函数 检查当前M5时间段是否执行过，是就返回true
#include <WooInclude/Check_HasOrder.mqh>     //检查是否已经有订单
#include <WooInclude/Strategy_CloseAI.mqh>     //关单策略
#include <WooInclude/Strategy_OpenAI.mqh>      //开单策略
#include <WooInclude/Strategy_CloseRule.mqh>   //关单策略 人工规则
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


//+------------------------------人工策略(关单)  begin ------------------------------------+
   
   //人工规则检测是否关单(每次tick都执行)
   if(Check_HasOrder())                            //先检查是否有订单
     {
      Order_Accounting(true);                      //有订单，计算订单订单统计信息
      if(Strategy_CloseRule())                     //人工关单规则策略检查
        {
         if(Trade_CloseOrder())                    //如果规则满足，执行关单
         {
            Print("关单 -> 人工");            //关单成功，打印成功信息到日志
         }
         else
           {
            Print("关单失败 --> ",GetLastError());      //关单失败，打印失败信息到日志
           }
         ;
        }
     }else
        {
         Order_Accounting(false);                  //没有订单，重置订单统计信息
        }
   Comment(comment_str);                           //将订单统计信息输出到屏幕
//+------------------------------人工策略(关单)  end ------------------------------------+



//+------------------------------算法策略  begin ------------------------------------+ 
   if(Check_TimeFlag(dt_m5_flag))                  //先检查当前5分钟是否已经执行过算法策略
     {
      return;                                      //如果当前M5已经执行，直接返回
     }
     else                                          //如果当前M5还未执行，开始执行算法策略
        {
        Strategy_Forecast();                       //掉算法预测，获取预测结构
        
        
         if(Check_HasOrder())                      //先检查是否有订单，如果有则执行算法关单策略，如果没有则执行算法开单策略
           {
                                                   //有订单，执行关单策略
            if(Strategy_CloseAI())                 //检查算法关单策略是否满足
              {
              
              
               if(Trade_CloseOrder())              //满足关单策略，执行关单并返回
               {
                  Print("关单 -> 算法");      //关单成功，打印信息
               }
               else
                 {
                  Print("关单失败 --> ",GetLastError());   //关单失败，打印信息
                 }
               ;
               
               
               return;
              }else                                
                 {
                  return;                          //不满足关单策略，直接返回
                 }
           }else                                   //没有订单，执行开单策略
              {              
               if(Strategy_OpenAI())               //检查算法开单策略
                 {
                 if(Trade_OpenOrder()<0)           //满足开单策略，开单并返回
                 {
                  Print("开单失败 --> ",GetLastError()); //打印失败开单信息
                 }
                 else
                   {
                    Print("开单 -> 算法");          //打印成功开单信息
                   }
                 ;
                 return;
                 }else                             //不满足开单策略，直接返回
                    {
                     return;
                    }
              }
        }
//+------------------------------算法策略  begin ------------------------------------+

  
  }
//+------------------------------------------------------------------+


