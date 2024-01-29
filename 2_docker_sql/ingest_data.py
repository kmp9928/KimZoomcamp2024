#!/usr/bin/env python
# coding: utf-8

import argparse
import pandas as pd
from sqlalchemy import create_engine
from time import time

def main(params):

	user = params.user
	password = params.password
	host = params.host
	port = params.port
	db = params.db
	table_name = params.table_name

	df_iter = pd.read_csv('yellow_tripdata_2021-01.csv', iterator=True, chunksize=100000, low_memory=False)
	df = next(df_iter)
	engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

	df.head(n=0).to_sql(name=table_name, con=engine, if_exists='replace')
	df_iter = pd.read_csv('yellow_tripdata_2021-01.csv', iterator=True, chunksize=100000, low_memory=False)

	while True:
		try:
			t_start = time()
			df = next(df_iter)
		
			df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
			df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)
			
			df.to_sql(name=table_name, con=engine, if_exists='append')
		
			t_end = time()
			
		
			print('Inserted another chunk...took:',(t_end-t_start))
		except StopIteration:
			break

if __name__ == '__main__':

	parser = argparse.ArgumentParser(description='Ingest CSV data to postgres')

	parser.add_argument('--user', help='user name for postgres')
	parser.add_argument('--password', help='password for postgres')
	parser.add_argument('--host', help='host for postgres')
	parser.add_argument('--port', help='port for postgres')
	parser.add_argument('--db', help='database name for postgres')
	parser.add_argument('--table_name', help='table name where we will write the results to')

	args = parser.parse_args()

	main(args)