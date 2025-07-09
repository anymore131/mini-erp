# main.py
from fastapi import FastAPI
import numpy as np
import pandas as pd
from fastapi import HTTPException
from data_connector import ERPDataConnector
from anomaly_detector import AnomalyDetector
from churn_predictor import ChurnPredictor
from rfm_processor import RFMAnalyzer
from clustering import ClientSegmenter

app = FastAPI()

config = {
    'host': 'localhost:3306',
    'user': 'root',
    'password': '0408',
    'db': 'erp'
}

@app.get("/client-analysis/all")
def analyze_clients():
    connector = ERPDataConnector(config)
    clients = connector.fetch_clients()
    orders = connector.fetch_orders()
    
    rfm = RFMAnalyzer().calculate_rfm(clients, orders)
    tiers = RFMAnalyzer().calculate_value_tier(rfm)

    # 异常消费检测
    anomalies = AnomalyDetector().detect(orders)
    # 客户流失预警
    churn_risk = ChurnPredictor().train_predict(clients, orders)
    
    # 客户分群
    segmenter = ClientSegmenter()
    clusters = segmenter.fit_predict(rfm)
    
    # 准备结果数据
    result_df = rfm.copy()
    result_df['cluster'] = clusters
    result_df['client_id'] = result_df.index
    client_info = clients.set_index('id')[['name', 'last_order_date']]
    result_df = result_df.join(client_info)
    result_df['last_order_time'] = result_df['last_order_date']
    result_df['tier'] = tiers
    result_df['is_anomaly'] = anomalies.reindex(result_df.index, fill_value=0)
    result_df['churn_risk'] = churn_risk

    # 保存到client_rfm表
    result_df.reset_index(drop=True)[
        ['client_id', 'last_order_time', 'Frequency', 'Monetary', 'cluster', 'tier', 'is_anomaly', 'churn_risk']
    ].to_sql(
        'client_rfm',
        con=connector.engine,
        if_exists='replace',
        index=False
    )
    
    return {
        "value_tiers": tiers.value_counts().to_dict(),
        "cluster_distribution": clusters.value_counts().to_dict(),
        "rfm_stats": rfm.describe().to_dict(),
        "anomaly_count": int(anomalies.sum()),
        "churn_risk_distribution": {
            "high_risk": len(churn_risk[churn_risk > 0.7]),
            "medium_risk": len(churn_risk[(churn_risk > 0.3) & (churn_risk <= 0.7)]),
            "low_risk": len(churn_risk[churn_risk <= 0.3])
        },
        "client_details": result_df[[
            'client_id', 
            'name',
            'last_order_time',
            'Frequency',
            'Monetary',
            'cluster',
            'tier',
            'is_anomaly',
            'churn_risk'
        ]].replace([np.inf, -np.inf], 0)
        .astype(object).where(pd.notnull(result_df), None)
        .to_dict(orient='records')
    }
