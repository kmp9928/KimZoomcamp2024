import io
import glob
import os
import pandas as pd
import requests
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(*args, **kwargs):
    """
    Template for loading data from API
    """
    url = 'https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green'

    taxi_dtypes = {
        'VendorID': pd.Int64Dtype(),
        'store_and_fwd_flag':str,
        'RatecodeID':pd.Int64Dtype(),
        'PULocationID':pd.Int64Dtype(),
        'DOLocationID':pd.Int64Dtype(),
        'passenger_count': pd.Int64Dtype(),
        'trip_distance': float,
        'fare_amount': float,
        'extra':float,
        'mta_tax':float,
        'tip_amount':float,
        'tolls_amount':float,
        'improvement_surcharge':float,
        'total_amount':float,
        'payment_type': pd.Int64Dtype(),
        'trip_type':pd.Int64Dtype(),
        'congestion_surcharge':float
    }

    parse_dates = ['lpep_pickup_datetime', 'lpep_dropoff_datetime']

    all_df = []
    for month in range(10, 13):
        target_url = url + '/green_tripdata_2020-' + str(month) + '.csv.gz'
        df = pd.read_csv(target_url, sep=',', compression='gzip', dtype=taxi_dtypes, parse_dates=parse_dates)
        all_df.append(df)
    
    final_df = pd.concat(all_df, axis=0, ignore_index=True)
    
    return final_df