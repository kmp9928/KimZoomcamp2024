if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    """
    Template code for a transformer block.
    """
    data.columns = (data.columns
                    .str.replace('(?<=[a-z])(?=[A-Z])', '_', regex=True)
                    .str.lower()
    )

    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date

    # col_vendorid_list = data['vendor_id'].unique().tolist()
    # print(f'\ncol_vendorid_list:\n{col_vendorid_list}')

    return data[(data['passenger_count'] > 0) & (data['trip_distance'] > 0)]


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert 'vendor_id' in output.columns, 'vendor_id is not one of the existing values in the column (currently)'
    assert output['passenger_count'].isin([0]).sum() == 0, 'There are rides with zero passengers'
    assert output['trip_distance'].isin([0]).sum() == 0, 'There are rides with zero distance'