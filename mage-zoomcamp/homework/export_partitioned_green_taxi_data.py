if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter


@data_exporter
def export_data(data, *args, **kwargs):
    import pyarrow as pa
    import pyarrow.parquet as pq
    import os

    os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = "/home/src/coherent-ranger-412815-a13fb997441a.json"
    bucket_name = 'mage-zoomcamp-kim'
    project_id = 'coherent-ranger-412815'

    table_name = 'green_taxi_data'

    root_path = f'{bucket_name}/{table_name}'

    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date

    table = pa.Table.from_pandas(data)
    gcs = pa.fs.GcsFileSystem()

    pq.write_to_dataset(
        table,
        root_path=root_path,
        partition_cols=['lpep_pickup_date'],
        filesystem=gcs
    )