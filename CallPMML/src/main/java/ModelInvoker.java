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

public class ModelInvoker {
    private ModelEvaluator modelEvaluator;

    public ModelInvoker(String pmmlFileName) {
        PMML pmml = null;
        InputStream is = null;

        try {
            if(pmmlFileName != null) {
                is = ModelInvoker.class.getClassLoader().getResourceAsStream(pmmlFileName);
                pmml = PMMLUtil.unmarshal(is);
            }

            try {
                is.close();
            } catch (IOException var16) {
                ;
            }

            this.modelEvaluator = ModelEvaluatorFactory.newInstance().newModelEvaluator(pmml);
        } catch (SAXException var17) {
            pmml = null;
        } catch (JAXBException var18) {
            pmml = null;
        } finally {
            try {
                is.close();
            } catch (IOException var15) {
                ;
            }

        }

        this.modelEvaluator.verify();
        System.out.println("模型读取成功");
    }

    public ModelInvoker(InputStream is) {
        PMML pmml = null;

        try {
            pmml = PMMLUtil.unmarshal(is);

            try {
                is.close();
            } catch (IOException var15) {
                ;
            }

            this.modelEvaluator = ModelEvaluatorFactory.newInstance().newModelEvaluator(pmml);
        } catch (SAXException var16) {
            pmml = null;
        } catch (JAXBException var17) {
            pmml = null;
        } finally {
            try {
                is.close();
            } catch (IOException var14) {
                ;
            }

        }

        this.modelEvaluator.verify();
    }

    public Map<FieldName, ?> invoke(Map<FieldName, Object> paramsMap) {
        return this.modelEvaluator.evaluate(paramsMap);
    }
}
