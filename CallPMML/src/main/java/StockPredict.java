/**
 * Created by jiagu.wu on 18/3/22.
 */
import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

import javax.xml.bind.JAXBException;

import org.dmg.pmml.FieldName;
import org.dmg.pmml.PMML;
import org.jpmml.evaluator.ModelEvaluator;
import org.jpmml.evaluator.ModelEvaluatorFactory;
import org.jpmml.model.PMMLUtil;
import org.xml.sax.SAXException;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.dmg.pmml.FieldName;

import java.io.File;
import java.io.InputStreamReader;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileWriter;

public class StockPredict {
    public  static String kv_predict(String kv_features){
        if(kv_features==null || kv_features.isEmpty()){
            System.out.println("null kv_input");
            return "null";
        }
        Map<FieldName,Object> map_features = new HashMap<FieldName, Object>();
        String paramLine = null;  //一行参数
        //循环读取  每次读取一行数据 k1:v1,k2:v2...
        Map<FieldName,Object> map_feature = new HashMap<FieldName, Object>();
        String[] paramLineArr = kv_features.split(",");
        for(int i=0; i<paramLineArr.length; i++){
            String[] pair  = paramLineArr[i].split(":");
            String key = pair[0];
            String value = pair[1];
            map_feature.put(new FieldName(key), value); //将表头和值组成map 加入list中
        }
        //加载模型
        String pmmlPath_h3 = "xlab_m_GBDT_LR_H3_v2.pmml";
        String result_h3 = model_predict(pmmlPath_h3,map_feature,"trend_h3");
        result_h3 = "trend_h3"+":"+result_h3;
/*
        String pmmlPath_M30 = "xlab_m_GBDT_LR_M30_3.pmml";
        String result_M30 = model_predict(pmmlPath_M30,map_feature,"trend_m30_3");

        String pmmlPath_M15 = "xlab_m_GBDT_LR_M15_3.pmml";
        String result_M15 = model_predict(pmmlPath_M15,map_feature,"trend_m15_3");

        String pmmlPath_M5 = "xlab_m_GBDT_LR_M5_3.pmml";
        String result_M5 = model_predict(pmmlPath_M5,map_feature,"trend_m5_3");

        return result_h3+"|"+result_M30+"|"+result_M15+"|"+result_M5;
        */
        return result_h3;

    }
    public static String model_predict(String pmmlPath, Map<FieldName,Object> map_feature,String label_name)
    {

        ModelInvoker invoker = new ModelInvoker(pmmlPath);
        Map<FieldName, ?> result = invoker.invoke(map_feature);
        Set<FieldName> keySet = result.keySet();  //获取结果的keySet
        for(FieldName fn : keySet){
            System.out.println(result.get(fn).toString());
        }
        FieldName label_field= new FieldName(label_name);  //按pmml中训练预测目标字段名称去拿到结果
        String model = result.get(label_field).toString();
        return model;
    }

    public static void main(String[] args) throws IOException {
  /*      String kv_features="";
        if(args.length<1 ){
            kv_features  = kv_predict("gapbid_pre_d1:0.0008,pricetimehour:16,downbar_d3:0,gapbid_pre_h3:0.0044,highlow_d7:0,gapbid_pre_h2:0.0037,downbar_d9:0,upbar_d13:0,downbar_d1:0,openclose_d12:0,downbar_d4:0");
        }
        else
            kv_features=args[0];
*/
        String pathname = "features.txt"; // 绝对路径或相对路径都可以，这里是绝对路径，写入文件时演示相对路径
        File filename = new File(pathname); // 要读取以上路径的input。txt文件
        InputStreamReader reader = new InputStreamReader(
                new FileInputStream(filename)); // 建立一个输入流对象reader
        BufferedReader br = new BufferedReader(reader); // 建立一个对象，它把文件内容转成计算机能读懂的语言
        String kv_features = "";
        String line = br.readLine();
        while (line != null) {
            kv_features = kv_features+line;
            line =br.readLine(); // 一次读入一行数据
        }
        //文件生成路径
        PrintStream ps=new PrintStream("predict.txt");
        System.setOut(ps);
        //Sepal.Length:5.1,Sepal.Width:3.5,Petal.Length:1.4,Petal.Width:0.2,Species:0,level:1,level1:1
        //String single = kv_predict("Sepal.Width:3.5,Sepal.Length:5.1,xxxx:2,Petal.Length:1.4,Petal.Width:0.2,Species:0,level:1,level1:1");
        String predict  = kv_predict(kv_features);
        System.out.println(predict);
        //args[0] = "/Users/jiagu.wu/Prediction/target/iris_rf.pmml";
        //args[1]  = "/Users/jiagu.wu/Prediction/target/irisv2.csv";

    }

    /**
     * 读取参数文件
     * @param filePath
     * @return
     * @throws IOException
     */
    private static List<Map<FieldName,Object>> readInParams(String filePath) throws IOException{
        BufferedReader br = new BufferedReader(new FileReader(filePath));
        String[] nameArr = br.readLine().split(",");  //读取表头的名字

        List<Map<FieldName,Object>> list = new ArrayList();
        String paramLine = null;  //一行参数
        //循环读取  每次读取一行数据
        while((paramLine = br.readLine()) != null){
            Map<FieldName,Object> map = new HashMap<FieldName, Object>();
            String[] paramLineArr = paramLine.split(",");
//          一次循环处理一行数据
            for(int i=0; i<paramLineArr.length; i++){
                map.put(new FieldName(nameArr[i]), paramLineArr[i]); //将表头和值组成map 加入list中
            }
            list.add(map);
        }
        return list;
    }

}