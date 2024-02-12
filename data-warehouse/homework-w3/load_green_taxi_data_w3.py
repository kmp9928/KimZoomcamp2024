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
def load_data(*args, **kwargs):

    url = 'https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2022-'

    # Unlike CSV files, parquet files store meta data with the type of each column
    # So we don't have to specify them (no taxi_dtypes needed)

    all_df = []
    for month in range(1, 13):
        if month < 10:
            target_url = url + '0' + str(month) + '.parquet'
        else:
            target_url = url + str(month) + '.parquet'

        df = pd.read_parquet(target_url)
        all_df.append(df)
    
    final_df = pd.concat(all_df, axis=0, ignore_index=True)
    
    return final_df