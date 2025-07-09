# churn_predictor.py
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
import pandas as pd
from rfm_processor import RFMAnalyzer

# 客户流失预警
class ChurnPredictor:
    def __init__(self, inactive_days=30):
        self.inactive_threshold = inactive_days
        self.model = LogisticRegression(class_weight='balanced')  # 自动平衡类别权重
    
    def prepare_features(self, clients, orders):
        # 计算最后活跃时间
        last_active = orders.groupby('client_id')['create_time'].max()
        
        # 构建特征矩阵
        features = clients.set_index('id').join(last_active.rename('last_active'))
        features['is_churn'] = (features['last_order_date'] - features['last_active']).dt.days > self.inactive_threshold
        
        rfm = RFMAnalyzer().calculate_rfm(clients, orders)
        return features.join(rfm).dropna()
    
    def train_predict(self, clients, orders):
        data = self.prepare_features(clients, orders)
        if len(data['is_churn'].unique()) < 2:
            raise ValueError("警告：数据中只存在一个类别，请调整时间阈值或检查数据")

        X_train, X_test, y_train, y_test = train_test_split(
            data[['Recency', 'Frequency', 'Monetary']], 
            data['is_churn']
        )
        self.model.fit(X_train, y_train)
        
        # 返回包含客户ID和流失概率的DataFrame
        predictions = pd.DataFrame({
            'client_id': data.index,
            'churn_risk': self.model.predict_proba(data[['Recency', 'Frequency', 'Monetary']])[:,1]
        })
        return predictions.set_index('client_id')['churn_risk']