# rfm_processor.py
from datetime import datetime
import pandas as pd

class RFMAnalyzer:
    def calculate_rfm(self, clients, orders):
        now = datetime.now()
        
        # 计算Recency（使用client表的last_order_date）
        rfm = clients[['id', 'last_order_date']].copy()
        rfm['Recency'] = (now - pd.to_datetime(rfm['last_order_date'])).dt.days
        
        # 计算Frequency（使用client表的sum字段）
        rfm['Frequency'] = clients['order_count']
        
        # 计算Monetary（从orders表聚合）
        monetary = orders.groupby('client_id')['total_amount'].sum().reset_index()
        monetary.columns = ['id', 'Monetary']
        
        # 合并结果
        rfm = pd.merge(rfm, monetary, on='id', how='left')
        rfm['Monetary'] = rfm['Monetary'].fillna(0)
        
        # 设置索引
        rfm.set_index('id', inplace=True)
        
        return rfm[['Recency', 'Frequency', 'Monetary']]
    
    def calculate_value_tier(self, rfm_data):
        """基于RFM百分位数划分客户价值层级"""
        quantiles = rfm_data.quantile(q=[0.2, 0.5, 0.8])
        
        def get_tier(row):
            if row['Monetary'] >= quantiles.loc[0.8, 'Monetary'] and \
               row['Frequency'] >= quantiles.loc[0.8, 'Frequency'] and \
               row['Recency'] <= quantiles.loc[0.2, 'Recency']:
                return '钻石'
            elif row['Monetary'] >= quantiles.loc[0.5, 'Monetary'] and \
                 row['Frequency'] >= quantiles.loc[0.5, 'Frequency']:
                return '黄金'
            elif row['Monetary'] >= quantiles.loc[0.2, 'Monetary']:
                return '白银'
            else:
                return '普通'
                
        return rfm_data.apply(get_tier, axis=1)