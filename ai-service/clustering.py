# clustering.py
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import KMeans
import pandas as pd

class ClientSegmenter:
    def __init__(self, n_clusters=4):
        self.scaler = StandardScaler()
        self.model = KMeans(n_clusters=n_clusters)
        
    def fit_predict(self, rfm_data):
        # 确保使用数值列
        scaled_data = self.scaler.fit_transform(rfm_data)
        clusters = self.model.fit_predict(scaled_data)
        
        # 保留原始索引
        return pd.Series(clusters, index=rfm_data.index, name='Cluster')