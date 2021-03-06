//+------------------------------------------------------------------+
//|                                                    GetDateH1.mqh |
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

string GetDataH1_TXT()
{
   //返回字符串
   string rn_str;
   
   //取上一个小时的特征值
   datetime dt = iTime(Symbol(),PERIOD_H1,1);
   //rn_str+="dt:";
   //rn_str+=TimeToString(dt);
   //rn_str+=",";
   
   int pricedateweekday;
   pricedateweekday=TimeDayOfWeek(dt)+1;
   rn_str+="pricedateweekday_h:";
   rn_str+=IntegerToString(pricedateweekday);
   rn_str+=",";
   rn_str+="\n";
    
   int pricetimehour;
   pricetimehour=TimeHour(dt);
   rn_str+="pricetimehour_h:";
   rn_str+=IntegerToString(pricetimehour);
   rn_str+=",";
   rn_str+="\n";
   
   double closebid=iClose(Symbol(),PERIOD_H1,1);
   //double closebid_d=iClose(Symbol(),PERIOD_D1,1);
   rn_str+="closebid_h:";
   rn_str+=DoubleToString(closebid);
   rn_str+=",";
   rn_str+="\n";
   
   int trend;
   if(iClose(Symbol(),PERIOD_H1,1)>iClose(Symbol(),PERIOD_H1,2))
   {
      trend=1;
   }
   else if (iClose(Symbol(),PERIOD_H1,1)==iClose(Symbol(),PERIOD_H1,2))
   {
      trend=0;
   }
   else
   {
      trend=-1;
   };
   rn_str+="trend_h:";
   rn_str+=IntegerToString(trend);
   rn_str+=",";
   rn_str+="\n";
   
   
   //取gapbid_pre_h      系列特征值
   for(int i=1;i<=12;i++)
      {
         rn_str+="gapbid_pre_h"+IntegerToString(i)+":"+DoubleToString(closebid-iClose(Symbol(),PERIOD_H1,i+1));
         rn_str+=",";
         rn_str+="\n";
      }
   //取trend_pre_h       系列特征值
   for(int i=1;i<=12;i++)
     {
      int trend_pre_hi;
      if(iClose(Symbol(),PERIOD_H1,i)> (iClose(Symbol(),PERIOD_H1,i+1)))     //修正
        {
         trend_pre_hi=1;
        }
        else if(iClose(Symbol(),PERIOD_H1,i)<(iClose(Symbol(),PERIOD_H1,i+1)))
          {
           trend_pre_hi=0;
          }
        else
          {
           trend_pre_hi=0;
          };
          
          
         rn_str+="trend_pre_h"+IntegerToString(i)+":"+IntegerToString(trend_pre_hi);
         rn_str+=",";
         rn_str+="\n";
     }
   //取trend_gap_pre_h   系列特征值
   for(int i=1;i<=12;i++)
     {
      double trend_gap_pre_hi = iClose(Symbol(),PERIOD_H1,i)-iClose(Symbol(),PERIOD_H1,i+1);
      rn_str+="trend_gap_pre_h"+IntegerToString(i)+":"+DoubleToString(trend_gap_pre_hi);
      rn_str+=",";
      rn_str+="\n";
     }
   //取openclose_h       系列特征值
   for(int i=1;i<=12;i++)
     {
      double openclose_hi = iOpen(Symbol(),PERIOD_H1,i)-iClose(Symbol(),PERIOD_H1,i);
      rn_str+="openclose_h"+IntegerToString(i)+":"+DoubleToString(openclose_hi);
      rn_str+=",";
      rn_str+="\n";
     }
   //取highlow_h         系列特征值
   for(int i=1;i<=12;i++)
     {
      double highlow_hi = iHigh(Symbol(),PERIOD_H1,i)-iLow(Symbol(),PERIOD_H1,i);
      rn_str+="highlow_h"+IntegerToString(i)+":"+DoubleToString(highlow_hi);
      rn_str+=",";
      rn_str+="\n";
     }
     
   //取upbar_h           系列特征值
   for(int i=1;i<=12;i++)
     {
      double upbar_hi;
      if(iOpen(Symbol(),PERIOD_H1,i)>=iClose(Symbol(),PERIOD_H1,i) )
        {
         upbar_hi=iHigh(Symbol(),PERIOD_H1,i)-iOpen(Symbol(),PERIOD_H1,i);
        }
        else
          {
           upbar_hi=iHigh(Symbol(),PERIOD_H1,i)-iClose(Symbol(),PERIOD_H1,i);
          };
          
      rn_str+="upbar_h"+IntegerToString(i)+":"+DoubleToString(upbar_hi);
      rn_str+=",";
      rn_str+="\n";   
     }
   //取downbar_h         系列特征值
   for(int i=1;i<=12;i++)
     {
      double downbar_hi;
      if(iOpen(Symbol(),PERIOD_H1,i)>=iClose(Symbol(),PERIOD_H1,i)  )
        {
         downbar_hi=iClose(Symbol(),PERIOD_H1,i)-iLow(Symbol(),PERIOD_H1,i);
        }
        else
          {
           downbar_hi=iOpen(Symbol(),PERIOD_H1,i)-iLow(Symbol(),PERIOD_H1,i);
          };
      rn_str+="downbar_h"+IntegerToString(i)+":"+DoubleToString(downbar_hi);
      rn_str+=",";
      rn_str+="\n"; 
     }
   //取gapbid_pre_d      系列特征值
   for(int i=1;i<=14;i++)
     {
         rn_str+="gapbid_pre_d"+IntegerToString(i)+":"+DoubleToString(closebid-iClose(Symbol(),PERIOD_D1,i));   //上1个小时，跟上1天比，不是跟上2天
         rn_str+=",";
         rn_str+="\n";
     }
   //取trend_pre_d       系列特征值
   for(int i=1;i<=14;i++)
     {
      int trend_pre_di;
      if(iClose(Symbol(),PERIOD_D1,i)> (iClose(Symbol(),PERIOD_D1,i+1)))
        {
         trend_pre_di=1;
        }
        else if(iClose(Symbol(),PERIOD_D1,i)< (iClose(Symbol(),PERIOD_D1,i+1)))
          {
           trend_pre_di=0;
          }
        else
          {
           trend_pre_di=0;
          };
         rn_str+="trend_pre_d"+IntegerToString(i)+":"+IntegerToString(trend_pre_di);
         rn_str+=",";
         rn_str+="\n";
     }
   //取trend_gap_pre_d   系列特征值
   for(int i=1;i<=14;i++)
     {
      double trend_gap_pre_di = iClose(Symbol(),PERIOD_D1,i)-iClose(Symbol(),PERIOD_D1,i+1);
      rn_str+="trend_gap_pre_d"+IntegerToString(i)+":"+DoubleToString(trend_gap_pre_di);
      rn_str+=",";
      rn_str+="\n";
     }
   //取openclose_d       系列特征值
   for(int i=1;i<=14;i++)
     {
      double openclose_di = iOpen(Symbol(),PERIOD_D1,i)-iClose(Symbol(),PERIOD_D1,i);
      rn_str+="openclose_d"+IntegerToString(i)+":"+DoubleToString(openclose_di);
      rn_str+=",";
      rn_str+="\n";
     }
   //取highlow_d         系列特征值
   for(int i=1;i<=14;i++)
     {
      double highlow_di = iHigh(Symbol(),PERIOD_D1,i)-iLow(Symbol(),PERIOD_D1,i);
      rn_str+="highlow_d"+IntegerToString(i)+":"+DoubleToString(highlow_di);
      rn_str+=",";
      rn_str+="\n";
     }
   //取upbar_d           系列特征值
   for(int i=1;i<=14;i++)
     {
      double upbar_di;
      if(iOpen(Symbol(),PERIOD_D1,i)>=iClose(Symbol(),PERIOD_D1,i) )
        {
         upbar_di=iHigh(Symbol(),PERIOD_D1,i)-iOpen(Symbol(),PERIOD_D1,i);
        }
        else
          {
           upbar_di=iHigh(Symbol(),PERIOD_D1,i)-iClose(Symbol(),PERIOD_D1,i);
          };
          
      rn_str+="upbar_d"+IntegerToString(i)+":"+DoubleToString(upbar_di);
      rn_str+=",";
      rn_str+="\n"; 
     }
   //取downbar_d         系列特征值
   for(int i=1;i<=14;i++)
     {
      double downbar_di;
      if(iOpen(Symbol(),PERIOD_D1,i)>=iClose(Symbol(),PERIOD_D1,i)  )
        {
         downbar_di=iClose(Symbol(),PERIOD_D1,i)-iLow(Symbol(),PERIOD_D1,i);
        }
        else
          {
           downbar_di=iOpen(Symbol(),PERIOD_D1,i)-iLow(Symbol(),PERIOD_D1,i);
          };
      rn_str+="downbar_d"+IntegerToString(i)+":"+DoubleToString(downbar_di);
      rn_str+=",";
      rn_str+="\n"; 
     }
   
   
   
   return rn_str;
};