//+------------------------------------------------------------------+
//|                                                    EURUSD_EA.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
//#property strict




datetime dt_m5_flag;

bool     has_order;
int      order_count;

//订单基本信息
int      ticket_no;
string   order_symbol;
double   order_openprice;
int      order_type;
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

int      order_opentime_gap;               //时间间隔(分钟)

//显示信息
string   comment_str;




#include <WooInclude/GetDataH1.mqh>
#include <WooInclude/GetDataM30.mqh>
#include <WooInclude/GetDataM15.mqh>
#include <WooInclude/GetDataM5.mqh>

#include <WooInclude/Order_Accounting.mqh>   //订单计算
#include <WooInclude/Check_TimeFlag.mqh>     //函数 检查当前M5时间段是否执行过，是就返回true
#include <WooInclude/Check_HasOrder.mqh>     //检查是否已经有订单
#include <WooInclude/Strategy_CloseAI.mqh>     //关单策略
#include <WooInclude/Strategy_OpenAI.mqh>      //开单策略
#include <WooInclude/Strategy_CloseRule.mqh>   //关单策略 人工规则
#include <WooInclude/Trade_OpenOrder.mqh>    //开单
#include <WooInclude/Trade_CloseOrder.mqh>   //关单



//#import "DLLSample.dll"
//int    GetIntValue(int);
//double GetDoubleValue(double);
//#import

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
   
   //人工规则检测是否关单(每次tick都执行)
   if(Check_HasOrder())
     {
      //有订单，计算订单最新情况
      Order_Accounting(true);
      //执行规则关单策略
     
      
      if(Strategy_CloseRule())
        {
         if(Trade_CloseOrder())
         {
            Print("close order ok!!!");
         }
         else
           {
            Print("close order error!!!",GetLastError());
           }
         ;
        }
     }else
        {
         //没有订单
         Order_Accounting(false);
         
        }

   //打印品目信息
   Comment(comment_str);

   
   //算法策略，每5分钟预测一次策略
   if(Check_TimeFlag(dt_m5_flag))
     {
      //当前M5已经执行过了，直接返回
      
      return;
     }else
        {
         //执行当前M5逻辑
        
         //检查是否有订单
         if(Check_HasOrder())
           {
            //有订单，执行关单策略
            if(Strategy_CloseAI())
              {
               //满足关单策略，关单并返回
               if(Trade_CloseOrder())
               {
                  Print("close order ok!!!");
               }
               else
                 {
                  Print("close order error!!!",GetLastError());
                 }
               ;
               return;
              }else
                 {
                  //不满足关单策略，直接返回
                  return;
                 }
           }else
              {
               //无订单，执行开单策略
               
               if(Strategy_OpenAI())
                 {
                  //满足开单策略，开单并返回
                 if(Trade_OpenOrder()<0)
                 {
                  Print("open order error!!!",GetLastError());
                 }
                 else
                   {
                    Print("open order successfully");
                   }
                 ;
                 return;
                 }else
                    {
                     //不满足开单策略，直接返回
                     return;
                    }
              }
        }
   
  
  }
//+------------------------------------------------------------------+


