import re
import pandas as pd

def parse_table(txt):
    data = [
        [v.strip() for v in row.strip().split('|') if v != ''] 
        for row in txt.split('\n') if bool(re.search('\w+', row))
    ]
    return pd.DataFrame(data[1:], columns=data[0])