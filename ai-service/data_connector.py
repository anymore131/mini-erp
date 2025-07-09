# data_connector.py
import pandas as pd
from sqlalchemy import create_engine
from urllib.parse import quote_plus

class ERPDataConnector:
    def __init__(self, config):
        encoded_pwd = quote_plus(config['password'])
        db_url = f"mysql+pymysql://{config['user']}:{encoded_pwd}@{config['host']}/{config['db']}"
        self.engine = create_engine(db_url)
        
    def fetch_clients(self):
        query = """SELECT id, name, last_time as last_order_date, sum as order_count 
                  FROM client WHERE status != 0 and is_delete=0"""
        return pd.read_sql(query, self.engine)

    def fetch_orders(self):
        query = """SELECT client_id, total_amount/100 as total_amount, create_time 
                  FROM orders WHERE status='COMPLETED'"""
        return pd.read_sql(query, self.engine)

    def fetch_client_by_user(self,user_id):
        query = """SELECT id, name, last_time as last_order_date, sum as order_count 
                  FROM client WHERE status != 0 and user_id = """ + str(user_id) + """ and is_delete=0"""
        return pd.read_sql(query, self.engine)

    def fetch_orders_by_clients(self,client_ids):
        query = """SELECT client_id, total_amount/100 as total_amount, create_time
                  FROM orders WHERE status='COMPLETED' AND client_id IN (""" + ','.join(map(str, client_ids)) + """)"""
        return pd.read_sql(query, self.engine)