# anomaly_detector.py
from sklearn.ensemble import IsolationForest
import pandas as pd

# 异常消费检测
class AnomalyDetector:
    def __init__(self, contamination=0.05):
        self.model = IsolationForest(contamination=contamination)
    
    def detect(self, orders_data):
        # 特征工程：消费频率、单次金额分布、购买时间间隔
        features = orders_data.groupby('client_id').agg({
            'total_amount': ['mean', 'max', 'std'],
            'create_time': lambda x: (x.diff().dt.total_seconds().mean()/3600 if len(x) > 1 else 0)
        })
        features.columns = ['amount_mean', 'amount_max', 'amount_std', 'avg_hour_interval']
        
        # 检测异常
        is_anomaly = self.model.fit_predict(features.fillna(0))
        return pd.Series(is_anomaly, index=features.index).map({1:0, -1:1})