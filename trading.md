## Pre-install packages
- Set default values:
  - Training Dates
  - Sock Symbols Allowed


```python
start_training_date = '2020-01-01'
symbols = {
    "AAPL": "Apple Inc.",
    "NET": "Cloudflare Inc.",
    "SNOW": "Snowflake Inc.",
    "MSFT": "Microsoft Corporation",
    "META": "Meta Platforms Inc.",
    "TSLA": "Tesla Inc.",
    "DOX": "Amdocs Ltd",
    "CRM": "Salesforce Inc.",
    "ADBE": "Adobe Inc.",
    "F": "Ford Motor Co.",
    "T": "AT&T Inc.",
    "VZ": "Verizon Communications",
    "DOX": "Amdocs Ltd",
    "NVDA": "Nvidia Corporation",
}
```


```python
%pip install yfinance 
%pip install pandas 
%pip install numpy 
%pip install scikit-learn 
%pip install matplotlib
%pip install holidays
%pip install yahoo_fin
%pip install boto3
%pip install sagemaker
```

    Requirement already satisfied: yfinance in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (0.2.50)
    Requirement already satisfied: pandas>=1.3.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from yfinance) (2.2.3)
    Requirement already satisfied: numpy>=1.16.5 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from yfinance) (1.26.4)
    Requirement already satisfied: requests>=2.31 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from yfinance) (2.31.0)
    Requirement already satisfied: multitasking>=0.0.7 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from yfinance) (0.0.11)
    Requirement already satisfied: lxml>=4.9.1 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from yfinance) (5.3.0)
    Requirement already satisfied: platformdirs>=2.0.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from yfinance) (4.2.0)
    Requirement already satisfied: pytz>=2022.5 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from yfinance) (2024.2)
    Requirement already satisfied: frozendict>=2.3.4 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from yfinance) (2.4.6)
    Requirement already satisfied: peewee>=3.16.2 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from yfinance) (3.17.8)
    Requirement already satisfied: beautifulsoup4>=4.11.1 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from yfinance) (4.12.3)
    Requirement already satisfied: html5lib>=1.1 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from yfinance) (1.1)
    Requirement already satisfied: soupsieve>1.2 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from beautifulsoup4>=4.11.1->yfinance) (2.6)
    Requirement already satisfied: six>=1.9 in /Users/luis_cardenas/.local/lib/python3.10/site-packages (from html5lib>=1.1->yfinance) (1.16.0)
    Requirement already satisfied: webencodings in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from html5lib>=1.1->yfinance) (0.5.1)
    Requirement already satisfied: python-dateutil>=2.8.2 in /Users/luis_cardenas/.local/lib/python3.10/site-packages (from pandas>=1.3.0->yfinance) (2.8.2)
    Requirement already satisfied: tzdata>=2022.7 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pandas>=1.3.0->yfinance) (2024.2)
    Requirement already satisfied: charset-normalizer<4,>=2 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from requests>=2.31->yfinance) (3.3.2)
    Requirement already satisfied: idna<4,>=2.5 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from requests>=2.31->yfinance) (3.6)
    Requirement already satisfied: urllib3<3,>=1.21.1 in /Users/luis_cardenas/.local/lib/python3.10/site-packages (from requests>=2.31->yfinance) (1.26.15)
    Requirement already satisfied: certifi>=2017.4.17 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from requests>=2.31->yfinance) (2024.8.30)
    Note: you may need to restart the kernel to use updated packages.
    Requirement already satisfied: pandas in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (2.2.3)
    Requirement already satisfied: numpy>=1.22.4 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pandas) (1.26.4)
    Requirement already satisfied: python-dateutil>=2.8.2 in /Users/luis_cardenas/.local/lib/python3.10/site-packages (from pandas) (2.8.2)
    Requirement already satisfied: pytz>=2020.1 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pandas) (2024.2)
    Requirement already satisfied: tzdata>=2022.7 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pandas) (2024.2)
    Requirement already satisfied: six>=1.5 in /Users/luis_cardenas/.local/lib/python3.10/site-packages (from python-dateutil>=2.8.2->pandas) (1.16.0)
    Note: you may need to restart the kernel to use updated packages.
    Requirement already satisfied: numpy in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (1.26.4)
    Note: you may need to restart the kernel to use updated packages.
    Requirement already satisfied: scikit-learn in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (1.5.2)
    Requirement already satisfied: numpy>=1.19.5 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from scikit-learn) (1.26.4)
    Requirement already satisfied: scipy>=1.6.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from scikit-learn) (1.14.1)
    Requirement already satisfied: joblib>=1.2.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from scikit-learn) (1.4.2)
    Requirement already satisfied: threadpoolctl>=3.1.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from scikit-learn) (3.5.0)
    Note: you may need to restart the kernel to use updated packages.
    Requirement already satisfied: matplotlib in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (3.9.3)
    Requirement already satisfied: contourpy>=1.0.1 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from matplotlib) (1.3.1)
    Requirement already satisfied: cycler>=0.10 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from matplotlib) (0.12.1)
    Requirement already satisfied: fonttools>=4.22.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from matplotlib) (4.55.1)
    Requirement already satisfied: kiwisolver>=1.3.1 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from matplotlib) (1.4.7)
    Requirement already satisfied: numpy>=1.23 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from matplotlib) (1.26.4)
    Requirement already satisfied: packaging>=20.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from matplotlib) (24.0)
    Requirement already satisfied: pillow>=8 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from matplotlib) (11.0.0)
    Requirement already satisfied: pyparsing>=2.3.1 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from matplotlib) (3.2.0)
    Requirement already satisfied: python-dateutil>=2.7 in /Users/luis_cardenas/.local/lib/python3.10/site-packages (from matplotlib) (2.8.2)
    Requirement already satisfied: six>=1.5 in /Users/luis_cardenas/.local/lib/python3.10/site-packages (from python-dateutil>=2.7->matplotlib) (1.16.0)
    Note: you may need to restart the kernel to use updated packages.
    Requirement already satisfied: holidays in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (0.62)
    Requirement already satisfied: python-dateutil in /Users/luis_cardenas/.local/lib/python3.10/site-packages (from holidays) (2.8.2)
    Requirement already satisfied: six>=1.5 in /Users/luis_cardenas/.local/lib/python3.10/site-packages (from python-dateutil->holidays) (1.16.0)
    Note: you may need to restart the kernel to use updated packages.
    Requirement already satisfied: yahoo_fin in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (0.8.9.1)
    Requirement already satisfied: requests-html in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from yahoo_fin) (0.10.0)
    Requirement already satisfied: feedparser in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from yahoo_fin) (6.0.11)
    Requirement already satisfied: requests in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from yahoo_fin) (2.31.0)
    Requirement already satisfied: pandas in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from yahoo_fin) (2.2.3)
    Requirement already satisfied: sgmllib3k in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from feedparser->yahoo_fin) (1.0.0)
    Requirement already satisfied: numpy>=1.22.4 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pandas->yahoo_fin) (1.26.4)
    Requirement already satisfied: python-dateutil>=2.8.2 in /Users/luis_cardenas/.local/lib/python3.10/site-packages (from pandas->yahoo_fin) (2.8.2)
    Requirement already satisfied: pytz>=2020.1 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pandas->yahoo_fin) (2024.2)
    Requirement already satisfied: tzdata>=2022.7 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pandas->yahoo_fin) (2024.2)
    Requirement already satisfied: charset-normalizer<4,>=2 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from requests->yahoo_fin) (3.3.2)
    Requirement already satisfied: idna<4,>=2.5 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from requests->yahoo_fin) (3.6)
    Requirement already satisfied: urllib3<3,>=1.21.1 in /Users/luis_cardenas/.local/lib/python3.10/site-packages (from requests->yahoo_fin) (1.26.15)
    Requirement already satisfied: certifi>=2017.4.17 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from requests->yahoo_fin) (2024.8.30)
    Requirement already satisfied: pyquery in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from requests-html->yahoo_fin) (2.0.1)
    Requirement already satisfied: fake-useragent in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from requests-html->yahoo_fin) (2.0.1)
    Requirement already satisfied: parse in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from requests-html->yahoo_fin) (1.20.2)
    Requirement already satisfied: bs4 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from requests-html->yahoo_fin) (0.0.2)
    Requirement already satisfied: w3lib in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from requests-html->yahoo_fin) (2.2.1)
    Requirement already satisfied: pyppeteer>=0.0.14 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from requests-html->yahoo_fin) (2.0.0)
    Requirement already satisfied: appdirs<2.0.0,>=1.4.3 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pyppeteer>=0.0.14->requests-html->yahoo_fin) (1.4.4)
    Requirement already satisfied: importlib-metadata>=1.4 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pyppeteer>=0.0.14->requests-html->yahoo_fin) (6.11.0)
    Requirement already satisfied: pyee<12.0.0,>=11.0.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pyppeteer>=0.0.14->requests-html->yahoo_fin) (11.1.1)
    Requirement already satisfied: tqdm<5.0.0,>=4.42.1 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pyppeteer>=0.0.14->requests-html->yahoo_fin) (4.66.2)
    Requirement already satisfied: websockets<11.0,>=10.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pyppeteer>=0.0.14->requests-html->yahoo_fin) (10.4)
    Requirement already satisfied: six>=1.5 in /Users/luis_cardenas/.local/lib/python3.10/site-packages (from python-dateutil>=2.8.2->pandas->yahoo_fin) (1.16.0)
    Requirement already satisfied: beautifulsoup4 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from bs4->requests-html->yahoo_fin) (4.12.3)
    Requirement already satisfied: importlib-resources>=6.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from fake-useragent->requests-html->yahoo_fin) (6.4.5)
    Requirement already satisfied: lxml>=2.1 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pyquery->requests-html->yahoo_fin) (5.3.0)
    Requirement already satisfied: cssselect>=1.2.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pyquery->requests-html->yahoo_fin) (1.2.0)
    Requirement already satisfied: zipp>=0.5 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from importlib-metadata>=1.4->pyppeteer>=0.0.14->requests-html->yahoo_fin) (3.21.0)
    Requirement already satisfied: typing-extensions in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pyee<12.0.0,>=11.0.0->pyppeteer>=0.0.14->requests-html->yahoo_fin) (4.12.2)
    Requirement already satisfied: soupsieve>1.2 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from beautifulsoup4->bs4->requests-html->yahoo_fin) (2.6)
    Note: you may need to restart the kernel to use updated packages.
    Requirement already satisfied: boto3 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (1.35.81)
    Requirement already satisfied: botocore<1.36.0,>=1.35.81 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from boto3) (1.35.81)
    Requirement already satisfied: jmespath<2.0.0,>=0.7.1 in /Users/luis_cardenas/.local/lib/python3.10/site-packages (from boto3) (1.0.1)
    Requirement already satisfied: s3transfer<0.11.0,>=0.10.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from boto3) (0.10.4)
    Requirement already satisfied: python-dateutil<3.0.0,>=2.1 in /Users/luis_cardenas/.local/lib/python3.10/site-packages (from botocore<1.36.0,>=1.35.81->boto3) (2.8.2)
    Requirement already satisfied: urllib3!=2.2.0,<3,>=1.25.4 in /Users/luis_cardenas/.local/lib/python3.10/site-packages (from botocore<1.36.0,>=1.35.81->boto3) (1.26.15)
    Requirement already satisfied: six>=1.5 in /Users/luis_cardenas/.local/lib/python3.10/site-packages (from python-dateutil<3.0.0,>=2.1->botocore<1.36.0,>=1.35.81->boto3) (1.16.0)
    Note: you may need to restart the kernel to use updated packages.
    Requirement already satisfied: sagemaker in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (2.237.1)
    Requirement already satisfied: attrs<24,>=23.1.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (23.2.0)
    Requirement already satisfied: boto3<2.0,>=1.35.75 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (1.35.81)
    Requirement already satisfied: cloudpickle==2.2.1 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (2.2.1)
    Requirement already satisfied: docker in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (7.1.0)
    Requirement already satisfied: fastapi in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (0.115.6)
    Requirement already satisfied: google-pasta in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (0.2.0)
    Requirement already satisfied: importlib-metadata<7.0,>=1.4.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (6.11.0)
    Requirement already satisfied: jsonschema in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (4.23.0)
    Requirement already satisfied: numpy<2.0,>=1.9.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (1.26.4)
    Requirement already satisfied: omegaconf<2.3,>=2.2 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (2.2.3)
    Requirement already satisfied: packaging>=20.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (24.0)
    Requirement already satisfied: pandas in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (2.2.3)
    Requirement already satisfied: pathos in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (0.3.3)
    Requirement already satisfied: platformdirs in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (4.2.0)
    Requirement already satisfied: protobuf<6.0,>=3.12 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (5.29.1)
    Requirement already satisfied: psutil in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (6.1.0)
    Requirement already satisfied: pyyaml~=6.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (6.0.2)
    Requirement already satisfied: requests in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (2.31.0)
    Requirement already satisfied: sagemaker-core<2.0.0,>=1.0.17 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (1.0.17)
    Requirement already satisfied: schema in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (0.7.7)
    Requirement already satisfied: smdebug-rulesconfig==1.0.1 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (1.0.1)
    Requirement already satisfied: tblib<4,>=1.7.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (3.0.0)
    Requirement already satisfied: tqdm in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (4.66.2)
    Requirement already satisfied: urllib3<3.0.0,>=1.26.8 in /Users/luis_cardenas/.local/lib/python3.10/site-packages (from sagemaker) (1.26.15)
    Requirement already satisfied: uvicorn in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker) (0.34.0)
    Requirement already satisfied: botocore<1.36.0,>=1.35.81 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from boto3<2.0,>=1.35.75->sagemaker) (1.35.81)
    Requirement already satisfied: jmespath<2.0.0,>=0.7.1 in /Users/luis_cardenas/.local/lib/python3.10/site-packages (from boto3<2.0,>=1.35.75->sagemaker) (1.0.1)
    Requirement already satisfied: s3transfer<0.11.0,>=0.10.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from boto3<2.0,>=1.35.75->sagemaker) (0.10.4)
    Requirement already satisfied: zipp>=0.5 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from importlib-metadata<7.0,>=1.4.0->sagemaker) (3.21.0)
    Requirement already satisfied: antlr4-python3-runtime==4.9.* in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from omegaconf<2.3,>=2.2->sagemaker) (4.9.3)
    Requirement already satisfied: pydantic<3.0.0,>=2.0.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker-core<2.0.0,>=1.0.17->sagemaker) (2.10.3)
    Requirement already satisfied: rich<14.0.0,>=13.0.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker-core<2.0.0,>=1.0.17->sagemaker) (13.9.4)
    Requirement already satisfied: mock<5.0,>4.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from sagemaker-core<2.0.0,>=1.0.17->sagemaker) (4.0.3)
    Requirement already satisfied: jsonschema-specifications>=2023.03.6 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from jsonschema->sagemaker) (2024.10.1)
    Requirement already satisfied: referencing>=0.28.4 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from jsonschema->sagemaker) (0.35.1)
    Requirement already satisfied: rpds-py>=0.7.1 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from jsonschema->sagemaker) (0.22.3)
    Requirement already satisfied: charset-normalizer<4,>=2 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from requests->sagemaker) (3.3.2)
    Requirement already satisfied: idna<4,>=2.5 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from requests->sagemaker) (3.6)
    Requirement already satisfied: certifi>=2017.4.17 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from requests->sagemaker) (2024.8.30)
    Requirement already satisfied: starlette<0.42.0,>=0.40.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from fastapi->sagemaker) (0.41.3)
    Requirement already satisfied: typing-extensions>=4.8.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from fastapi->sagemaker) (4.12.2)
    Requirement already satisfied: six in /Users/luis_cardenas/.local/lib/python3.10/site-packages (from google-pasta->sagemaker) (1.16.0)
    Requirement already satisfied: python-dateutil>=2.8.2 in /Users/luis_cardenas/.local/lib/python3.10/site-packages (from pandas->sagemaker) (2.8.2)
    Requirement already satisfied: pytz>=2020.1 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pandas->sagemaker) (2024.2)
    Requirement already satisfied: tzdata>=2022.7 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pandas->sagemaker) (2024.2)
    Requirement already satisfied: ppft>=1.7.6.9 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pathos->sagemaker) (1.7.6.9)
    Requirement already satisfied: dill>=0.3.9 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pathos->sagemaker) (0.3.9)
    Requirement already satisfied: pox>=0.3.5 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pathos->sagemaker) (0.3.5)
    Requirement already satisfied: multiprocess>=0.70.17 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pathos->sagemaker) (0.70.17)
    Requirement already satisfied: click>=7.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from uvicorn->sagemaker) (8.1.7)
    Requirement already satisfied: h11>=0.8 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from uvicorn->sagemaker) (0.14.0)
    Requirement already satisfied: annotated-types>=0.6.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pydantic<3.0.0,>=2.0.0->sagemaker-core<2.0.0,>=1.0.17->sagemaker) (0.7.0)
    Requirement already satisfied: pydantic-core==2.27.1 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from pydantic<3.0.0,>=2.0.0->sagemaker-core<2.0.0,>=1.0.17->sagemaker) (2.27.1)
    Requirement already satisfied: markdown-it-py>=2.2.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from rich<14.0.0,>=13.0.0->sagemaker-core<2.0.0,>=1.0.17->sagemaker) (3.0.0)
    Requirement already satisfied: pygments<3.0.0,>=2.13.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from rich<14.0.0,>=13.0.0->sagemaker-core<2.0.0,>=1.0.17->sagemaker) (2.18.0)
    Requirement already satisfied: anyio<5,>=3.4.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from starlette<0.42.0,>=0.40.0->fastapi->sagemaker) (4.7.0)
    Requirement already satisfied: exceptiongroup>=1.0.2 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from anyio<5,>=3.4.0->starlette<0.42.0,>=0.40.0->fastapi->sagemaker) (1.2.2)
    Requirement already satisfied: sniffio>=1.1 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from anyio<5,>=3.4.0->starlette<0.42.0,>=0.40.0->fastapi->sagemaker) (1.3.1)
    Requirement already satisfied: mdurl~=0.1 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from markdown-it-py>=2.2.0->rich<14.0.0,>=13.0.0->sagemaker-core<2.0.0,>=1.0.17->sagemaker) (0.1.2)
    Note: you may need to restart the kernel to use updated packages.
    Collecting nbformat
      Downloading nbformat-5.10.4-py3-none-any.whl.metadata (3.6 kB)
    Collecting fastjsonschema>=2.15 (from nbformat)
      Downloading fastjsonschema-2.21.1-py3-none-any.whl.metadata (2.2 kB)
    Requirement already satisfied: jsonschema>=2.6 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from nbformat) (4.23.0)
    Requirement already satisfied: jupyter-core!=5.0.*,>=4.12 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from nbformat) (5.7.2)
    Requirement already satisfied: traitlets>=5.1 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from nbformat) (5.14.3)
    Requirement already satisfied: attrs>=22.2.0 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from jsonschema>=2.6->nbformat) (23.2.0)
    Requirement already satisfied: jsonschema-specifications>=2023.03.6 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from jsonschema>=2.6->nbformat) (2024.10.1)
    Requirement already satisfied: referencing>=0.28.4 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from jsonschema>=2.6->nbformat) (0.35.1)
    Requirement already satisfied: rpds-py>=0.7.1 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from jsonschema>=2.6->nbformat) (0.22.3)
    Requirement already satisfied: platformdirs>=2.5 in /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages (from jupyter-core!=5.0.*,>=4.12->nbformat) (4.2.0)
    Downloading nbformat-5.10.4-py3-none-any.whl (78 kB)
    [2K   [90m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [32m78.5/78.5 kB[0m [31m1.3 MB/s[0m eta [36m0:00:00[0ma [36m0:00:01[0m
    [?25hDownloading fastjsonschema-2.21.1-py3-none-any.whl (23 kB)
    Installing collected packages: fastjsonschema, nbformat
    Successfully installed fastjsonschema-2.21.1 nbformat-5.10.4
    Note: you may need to restart the kernel to use updated packages.


## Data Collection


```python
import yfinance as yf

# Download stock data from a specific start date until today
data = yf.download(list(symbols.keys()), start="2018-01-01")
data.tail()
```

    [*********************100%***********************]  13 of 13 completed





<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead tr th {
        text-align: left;
    }

    .dataframe thead tr:last-of-type th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr>
      <th>Price</th>
      <th colspan="10" halign="left">Adj Close</th>
      <th>...</th>
      <th colspan="10" halign="left">Volume</th>
    </tr>
    <tr>
      <th>Ticker</th>
      <th>AAPL</th>
      <th>ADBE</th>
      <th>CRM</th>
      <th>DOX</th>
      <th>F</th>
      <th>META</th>
      <th>MSFT</th>
      <th>NET</th>
      <th>NVDA</th>
      <th>SNOW</th>
      <th>...</th>
      <th>DOX</th>
      <th>F</th>
      <th>META</th>
      <th>MSFT</th>
      <th>NET</th>
      <th>NVDA</th>
      <th>SNOW</th>
      <th>T</th>
      <th>TSLA</th>
      <th>VZ</th>
    </tr>
    <tr>
      <th>Date</th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2024-12-13</th>
      <td>248.130005</td>
      <td>465.690002</td>
      <td>353.906189</td>
      <td>87.300003</td>
      <td>10.39</td>
      <td>619.849976</td>
      <td>447.269989</td>
      <td>113.599998</td>
      <td>134.250000</td>
      <td>167.669998</td>
      <td>...</td>
      <td>554900</td>
      <td>40560700</td>
      <td>8453300</td>
      <td>20177800</td>
      <td>1927900.0</td>
      <td>231514900</td>
      <td>5516900.0</td>
      <td>33693900</td>
      <td>89000200</td>
      <td>13360400</td>
    </tr>
    <tr>
      <th>2024-12-16</th>
      <td>251.039993</td>
      <td>461.529999</td>
      <td>356.822876</td>
      <td>87.180000</td>
      <td>9.99</td>
      <td>624.239990</td>
      <td>451.589996</td>
      <td>114.650002</td>
      <td>132.000000</td>
      <td>172.470001</td>
      <td>...</td>
      <td>645700</td>
      <td>96264400</td>
      <td>10885600</td>
      <td>23598800</td>
      <td>2197600.0</td>
      <td>237951100</td>
      <td>6559300.0</td>
      <td>48018100</td>
      <td>114083800</td>
      <td>30228300</td>
    </tr>
    <tr>
      <th>2024-12-17</th>
      <td>253.479996</td>
      <td>455.230011</td>
      <td>350.570007</td>
      <td>86.919998</td>
      <td>9.97</td>
      <td>619.440002</td>
      <td>454.459991</td>
      <td>117.559998</td>
      <td>130.389999</td>
      <td>170.809998</td>
      <td>...</td>
      <td>600100</td>
      <td>76208600</td>
      <td>12897800</td>
      <td>22733500</td>
      <td>3870400.0</td>
      <td>259410300</td>
      <td>5162400.0</td>
      <td>39844700</td>
      <td>131223000</td>
      <td>15374000</td>
    </tr>
    <tr>
      <th>2024-12-18</th>
      <td>248.050003</td>
      <td>441.309998</td>
      <td>337.230011</td>
      <td>85.610001</td>
      <td>9.69</td>
      <td>597.190002</td>
      <td>437.390015</td>
      <td>109.099998</td>
      <td>128.910004</td>
      <td>162.589996</td>
      <td>...</td>
      <td>804500</td>
      <td>84199500</td>
      <td>17075500</td>
      <td>24444500</td>
      <td>3932100.0</td>
      <td>277444500</td>
      <td>5159300.0</td>
      <td>38897400</td>
      <td>149340800</td>
      <td>19199600</td>
    </tr>
    <tr>
      <th>2024-12-19</th>
      <td>249.789993</td>
      <td>437.390015</td>
      <td>336.230011</td>
      <td>86.150002</td>
      <td>9.74</td>
      <td>595.570007</td>
      <td>437.029999</td>
      <td>108.580002</td>
      <td>130.679993</td>
      <td>164.210007</td>
      <td>...</td>
      <td>919751</td>
      <td>63586415</td>
      <td>12932671</td>
      <td>21207330</td>
      <td>3146741.0</td>
      <td>203711460</td>
      <td>5239202.0</td>
      <td>43135568</td>
      <td>116759765</td>
      <td>13373054</td>
    </tr>
  </tbody>
</table>
<p>5 rows × 78 columns</p>
</div>




```python
# Reset the multi-index into a long-form DataFrame
# Reshape data: Stack and reset index
data_2D = (
    data.stack(level=1, future_stack=True)  # Stack the stock symbols
    .reset_index()
    .rename(columns={"level_1": "symbol"})  # Rename the stacked column to 'symbol'
)

data_2D.info()

```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 22802 entries, 0 to 22801
    Data columns (total 8 columns):
     #   Column     Non-Null Count  Dtype         
    ---  ------     --------------  -----         
     0   Date       22802 non-null  datetime64[ns]
     1   Ticker     22802 non-null  object        
     2   Adj Close  21694 non-null  float64       
     3   Close      21694 non-null  float64       
     4   High       21694 non-null  float64       
     5   Low        21694 non-null  float64       
     6   Open       21694 non-null  float64       
     7   Volume     21694 non-null  float64       
    dtypes: datetime64[ns](1), float64(6), object(1)
    memory usage: 1.4+ MB



```python
data_2D.columns = [col.replace(' ', '_') for col in data_2D.columns.values]
data_2D.columns
```




    Index(['Date', 'Ticker', 'Adj_Close', 'Close', 'High', 'Low', 'Open',
           'Volume'],
          dtype='object')



# Exploratory Data


```python
data_2D.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 22802 entries, 0 to 22801
    Data columns (total 8 columns):
     #   Column     Non-Null Count  Dtype         
    ---  ------     --------------  -----         
     0   Date       22802 non-null  datetime64[ns]
     1   Ticker     22802 non-null  object        
     2   Adj_Close  21694 non-null  float64       
     3   Close      21694 non-null  float64       
     4   High       21694 non-null  float64       
     5   Low        21694 non-null  float64       
     6   Open       21694 non-null  float64       
     7   Volume     21694 non-null  float64       
    dtypes: datetime64[ns](1), float64(6), object(1)
    memory usage: 1.4+ MB



```python
data_2D.describe()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Date</th>
      <th>Adj_Close</th>
      <th>Close</th>
      <th>High</th>
      <th>Low</th>
      <th>Open</th>
      <th>Volume</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>22802</td>
      <td>21694.000000</td>
      <td>21694.000000</td>
      <td>21694.000000</td>
      <td>21694.000000</td>
      <td>21694.000000</td>
      <td>2.169400e+04</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>2021-06-26 13:39:20.319270144</td>
      <td>139.921756</td>
      <td>142.324834</td>
      <td>144.300724</td>
      <td>140.257214</td>
      <td>142.300640</td>
      <td>7.157686e+07</td>
    </tr>
    <tr>
      <th>min</th>
      <td>2018-01-02 00:00:00</td>
      <td>3.151429</td>
      <td>3.177000</td>
      <td>3.249500</td>
      <td>3.111500</td>
      <td>3.162250</td>
      <td>2.001000e+05</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>2019-09-30 00:00:00</td>
      <td>26.481298</td>
      <td>28.686000</td>
      <td>28.972811</td>
      <td>28.246434</td>
      <td>28.651812</td>
      <td>4.731325e+06</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>2021-06-26 12:00:00</td>
      <td>89.930496</td>
      <td>92.334999</td>
      <td>93.465000</td>
      <td>91.116333</td>
      <td>92.404999</td>
      <td>2.256285e+07</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>2023-03-24 00:00:00</td>
      <td>214.882294</td>
      <td>216.397495</td>
      <td>219.732506</td>
      <td>212.815006</td>
      <td>216.100006</td>
      <td>6.523507e+07</td>
    </tr>
    <tr>
      <th>max</th>
      <td>2024-12-19 00:00:00</td>
      <td>688.369995</td>
      <td>688.369995</td>
      <td>699.539978</td>
      <td>678.909973</td>
      <td>696.280029</td>
      <td>2.511528e+09</td>
    </tr>
    <tr>
      <th>std</th>
      <td>NaN</td>
      <td>137.329009</td>
      <td>136.458896</td>
      <td>138.202281</td>
      <td>134.635503</td>
      <td>136.472196</td>
      <td>1.397335e+08</td>
    </tr>
  </tbody>
</table>
</div>




```python

# Check for missing values
print("From multi-index data \n", data.isnull().sum())
print("From data_2D \n", data_2D.isnull().sum())

# Visualize the distribution of the target variable (e.g., Adj_Close)
import matplotlib.pyplot as plt

data_2D['Adj_Close'].hist(bins=50, figsize=(10, 6))
plt.title('Distribution of Adjusted Close Prices')
plt.show()
```

    From multi-index data 
     Price      Ticker
    Adj Close  AAPL        0
               ADBE        0
               CRM         0
               DOX         0
               F           0
                        ... 
    Volume     NVDA        0
               SNOW      681
               T           0
               TSLA        0
               VZ          0
    Length: 78, dtype: int64
    From data_2D 
     Date            0
    Ticker          0
    Adj_Close    1108
    Close        1108
    High         1108
    Low          1108
    Open         1108
    Volume       1108
    dtype: int64



    
![png](trading_files/trading_10_1.png)
    



```python
# Drop rows with any NaN values
data_2D = data_2D.dropna()

print(data_2D.isnull().sum())  # Ensure no NaNs remain
print(data_2D.head())
```

    Date         0
    Ticker       0
    Adj_Close    0
    Close        0
    High         0
    Low          0
    Open         0
    Volume       0
    dtype: int64
            Date Ticker   Adj_Close       Close        High         Low  \
    0 2018-01-02   AAPL   40.524349   43.064999   43.075001   42.314999   
    1 2018-01-02   ADBE  177.699997  177.699997  177.800003  175.259995   
    2 2018-01-02    CRM  103.830070  104.410004  104.699997  102.269997   
    3 2018-01-02    DOX   58.145020   66.180000   66.250000   65.440002   
    4 2018-01-02      F    8.875399   12.660000   12.660000   12.500000   
    
             Open       Volume  
    0   42.540001  102223600.0  
    1  175.850006    2432800.0  
    2  102.879997    4669200.0  
    3   65.500000     525300.0  
    4   12.520000   20773300.0  



```python
import matplotlib.pyplot as plt

# Group data by 'Ticker'
grouped = data_2D.groupby('Ticker')

# Iterate through each ticker and plot its data
for ticker, group in grouped:
    plt.figure(figsize=(8, 5))
    plt.plot(group['Date'], group['Adj_Close'], label='Adj Close', color='blue')
    plt.plot(group['Date'], group['Close'], label='Close', color='orange')
    plt.title(f'Comparison of Close and Adjusted Close Prices for {ticker}')
    plt.xlabel('Date')
    plt.ylabel('Price')
    plt.legend()
    plt.grid()
    plt.show()
        
```


    
![png](trading_files/trading_12_0.png)
    



    
![png](trading_files/trading_12_1.png)
    



    
![png](trading_files/trading_12_2.png)
    



    
![png](trading_files/trading_12_3.png)
    



    
![png](trading_files/trading_12_4.png)
    



    
![png](trading_files/trading_12_5.png)
    



    
![png](trading_files/trading_12_6.png)
    



    
![png](trading_files/trading_12_7.png)
    



    
![png](trading_files/trading_12_8.png)
    



    
![png](trading_files/trading_12_9.png)
    



    
![png](trading_files/trading_12_10.png)
    



    
![png](trading_files/trading_12_11.png)
    



    
![png](trading_files/trading_12_12.png)
    


# Data Transform - Add feaures
- Encode tickers so I can keep adding tickers without adding complexity and keeping dataset compact
- Add Features
  - Date Features
    - day of the week
    - day of the month
    - is_holiday the day after
    - is_holiday the day before
    - year, month, day

  - Can I get the earnings reports?
    - days to the earning reports
    - days after the earning reporst
    - forecast?


```python
data_transformed = data_2D.copy()

from sklearn.preprocessing import LabelEncoder
import pandas as pd

encoder = LabelEncoder()
data_transformed['Ticker_Encoded'] = encoder.fit_transform(data_transformed['Ticker'])
ticker_mapping = dict(zip(encoder.classes_, encoder.transform(encoder.classes_)))

```


```python
from utils import transform_date
data_transformed = pd.concat([data_transformed, data_transformed['Date'].apply(transform_date).apply(pd.Series)], axis=1)
data_transformed.tail()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Date</th>
      <th>Ticker</th>
      <th>Adj_Close</th>
      <th>Close</th>
      <th>High</th>
      <th>Low</th>
      <th>Open</th>
      <th>Volume</th>
      <th>Ticker_Encoded</th>
      <th>year</th>
      <th>month</th>
      <th>day</th>
      <th>weekday</th>
      <th>is_day_before_a_holiday</th>
      <th>is_day_after_a_holiday</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>22797</th>
      <td>2024-12-19</td>
      <td>NVDA</td>
      <td>130.679993</td>
      <td>130.679993</td>
      <td>134.029999</td>
      <td>129.550003</td>
      <td>131.720001</td>
      <td>203711460.0</td>
      <td>8</td>
      <td>2024</td>
      <td>12</td>
      <td>19</td>
      <td>3</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>22798</th>
      <td>2024-12-19</td>
      <td>SNOW</td>
      <td>164.210007</td>
      <td>164.210007</td>
      <td>165.751404</td>
      <td>160.649994</td>
      <td>164.500000</td>
      <td>5239202.0</td>
      <td>9</td>
      <td>2024</td>
      <td>12</td>
      <td>19</td>
      <td>3</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>22799</th>
      <td>2024-12-19</td>
      <td>T</td>
      <td>22.570000</td>
      <td>22.570000</td>
      <td>22.680000</td>
      <td>22.410000</td>
      <td>22.504999</td>
      <td>43135568.0</td>
      <td>10</td>
      <td>2024</td>
      <td>12</td>
      <td>19</td>
      <td>3</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>22800</th>
      <td>2024-12-19</td>
      <td>TSLA</td>
      <td>436.170013</td>
      <td>436.170013</td>
      <td>456.359985</td>
      <td>420.019989</td>
      <td>451.920013</td>
      <td>116759765.0</td>
      <td>11</td>
      <td>2024</td>
      <td>12</td>
      <td>19</td>
      <td>3</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>22801</th>
      <td>2024-12-19</td>
      <td>VZ</td>
      <td>39.970001</td>
      <td>39.970001</td>
      <td>40.459999</td>
      <td>39.932800</td>
      <td>40.049999</td>
      <td>13373054.0</td>
      <td>12</td>
      <td>2024</td>
      <td>12</td>
      <td>19</td>
      <td>3</td>
      <td>0</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div>




```python
from sklearn.preprocessing import LabelEncoder
import pandas as pd

encoder = LabelEncoder()
data_transformed['Ticker_Encoded'] = encoder.fit_transform(data_transformed['Ticker'])
ticker_mapping = dict(zip(encoder.classes_, encoder.transform(encoder.classes_)))
data_transformed

```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Date</th>
      <th>Ticker</th>
      <th>Adj_Close</th>
      <th>Close</th>
      <th>High</th>
      <th>Low</th>
      <th>Open</th>
      <th>Volume</th>
      <th>Ticker_Encoded</th>
      <th>year</th>
      <th>month</th>
      <th>day</th>
      <th>weekday</th>
      <th>is_day_before_a_holiday</th>
      <th>is_day_after_a_holiday</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2018-01-02</td>
      <td>AAPL</td>
      <td>40.524349</td>
      <td>43.064999</td>
      <td>43.075001</td>
      <td>42.314999</td>
      <td>42.540001</td>
      <td>102223600.0</td>
      <td>0</td>
      <td>2018</td>
      <td>1</td>
      <td>2</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2018-01-02</td>
      <td>ADBE</td>
      <td>177.699997</td>
      <td>177.699997</td>
      <td>177.800003</td>
      <td>175.259995</td>
      <td>175.850006</td>
      <td>2432800.0</td>
      <td>1</td>
      <td>2018</td>
      <td>1</td>
      <td>2</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2018-01-02</td>
      <td>CRM</td>
      <td>103.830070</td>
      <td>104.410004</td>
      <td>104.699997</td>
      <td>102.269997</td>
      <td>102.879997</td>
      <td>4669200.0</td>
      <td>2</td>
      <td>2018</td>
      <td>1</td>
      <td>2</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2018-01-02</td>
      <td>DOX</td>
      <td>58.145020</td>
      <td>66.180000</td>
      <td>66.250000</td>
      <td>65.440002</td>
      <td>65.500000</td>
      <td>525300.0</td>
      <td>3</td>
      <td>2018</td>
      <td>1</td>
      <td>2</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2018-01-02</td>
      <td>F</td>
      <td>8.875399</td>
      <td>12.660000</td>
      <td>12.660000</td>
      <td>12.500000</td>
      <td>12.520000</td>
      <td>20773300.0</td>
      <td>4</td>
      <td>2018</td>
      <td>1</td>
      <td>2</td>
      <td>1</td>
      <td>1</td>
      <td>0</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>22797</th>
      <td>2024-12-19</td>
      <td>NVDA</td>
      <td>130.679993</td>
      <td>130.679993</td>
      <td>134.029999</td>
      <td>129.550003</td>
      <td>131.720001</td>
      <td>203711460.0</td>
      <td>8</td>
      <td>2024</td>
      <td>12</td>
      <td>19</td>
      <td>3</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>22798</th>
      <td>2024-12-19</td>
      <td>SNOW</td>
      <td>164.210007</td>
      <td>164.210007</td>
      <td>165.751404</td>
      <td>160.649994</td>
      <td>164.500000</td>
      <td>5239202.0</td>
      <td>9</td>
      <td>2024</td>
      <td>12</td>
      <td>19</td>
      <td>3</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>22799</th>
      <td>2024-12-19</td>
      <td>T</td>
      <td>22.570000</td>
      <td>22.570000</td>
      <td>22.680000</td>
      <td>22.410000</td>
      <td>22.504999</td>
      <td>43135568.0</td>
      <td>10</td>
      <td>2024</td>
      <td>12</td>
      <td>19</td>
      <td>3</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>22800</th>
      <td>2024-12-19</td>
      <td>TSLA</td>
      <td>436.170013</td>
      <td>436.170013</td>
      <td>456.359985</td>
      <td>420.019989</td>
      <td>451.920013</td>
      <td>116759765.0</td>
      <td>11</td>
      <td>2024</td>
      <td>12</td>
      <td>19</td>
      <td>3</td>
      <td>0</td>
      <td>0</td>
    </tr>
    <tr>
      <th>22801</th>
      <td>2024-12-19</td>
      <td>VZ</td>
      <td>39.970001</td>
      <td>39.970001</td>
      <td>40.459999</td>
      <td>39.932800</td>
      <td>40.049999</td>
      <td>13373054.0</td>
      <td>12</td>
      <td>2024</td>
      <td>12</td>
      <td>19</td>
      <td>3</td>
      <td>0</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
<p>21694 rows × 15 columns</p>
</div>




```python
# Get historical earnings for AAPL
ticker = yf.Ticker("AAPL")
earnings = ticker.income_stmt  # Annual earnings
earnings

```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>2024-09-30</th>
      <th>2023-09-30</th>
      <th>2022-09-30</th>
      <th>2021-09-30</th>
      <th>2020-09-30</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Tax Effect Of Unusual Items</th>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>0.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Tax Rate For Calcs</th>
      <td>0.240912</td>
      <td>0.147192</td>
      <td>0.162</td>
      <td>0.133</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Normalized EBITDA</th>
      <td>134661000000.0</td>
      <td>125820000000.0</td>
      <td>130541000000.0</td>
      <td>123136000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Net Income From Continuing Operation Net Minority Interest</th>
      <td>93736000000.0</td>
      <td>96995000000.0</td>
      <td>99803000000.0</td>
      <td>94680000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Reconciled Depreciation</th>
      <td>11445000000.0</td>
      <td>11519000000.0</td>
      <td>11104000000.0</td>
      <td>11284000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Reconciled Cost Of Revenue</th>
      <td>210352000000.0</td>
      <td>214137000000.0</td>
      <td>223546000000.0</td>
      <td>212981000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>EBITDA</th>
      <td>134661000000.0</td>
      <td>125820000000.0</td>
      <td>130541000000.0</td>
      <td>123136000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>EBIT</th>
      <td>123216000000.0</td>
      <td>114301000000.0</td>
      <td>119437000000.0</td>
      <td>111852000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Net Interest Income</th>
      <td>NaN</td>
      <td>-183000000.0</td>
      <td>-106000000.0</td>
      <td>198000000.0</td>
      <td>890000000.0</td>
    </tr>
    <tr>
      <th>Interest Expense</th>
      <td>NaN</td>
      <td>3933000000.0</td>
      <td>2931000000.0</td>
      <td>2645000000.0</td>
      <td>2873000000.0</td>
    </tr>
    <tr>
      <th>Interest Income</th>
      <td>NaN</td>
      <td>3750000000.0</td>
      <td>2825000000.0</td>
      <td>2843000000.0</td>
      <td>3763000000.0</td>
    </tr>
    <tr>
      <th>Normalized Income</th>
      <td>93736000000.0</td>
      <td>96995000000.0</td>
      <td>99803000000.0</td>
      <td>94680000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Net Income From Continuing And Discontinued Operation</th>
      <td>93736000000.0</td>
      <td>96995000000.0</td>
      <td>99803000000.0</td>
      <td>94680000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Total Expenses</th>
      <td>267819000000.0</td>
      <td>268984000000.0</td>
      <td>274891000000.0</td>
      <td>256868000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Total Operating Income As Reported</th>
      <td>123216000000.0</td>
      <td>114301000000.0</td>
      <td>119437000000.0</td>
      <td>108949000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Diluted Average Shares</th>
      <td>NaN</td>
      <td>15812547000.0</td>
      <td>16325819000.0</td>
      <td>16864919000.0</td>
      <td>17528214000.0</td>
    </tr>
    <tr>
      <th>Basic Average Shares</th>
      <td>NaN</td>
      <td>15744231000.0</td>
      <td>16215963000.0</td>
      <td>16701272000.0</td>
      <td>17352119000.0</td>
    </tr>
    <tr>
      <th>Diluted EPS</th>
      <td>NaN</td>
      <td>6.13</td>
      <td>6.11</td>
      <td>5.61</td>
      <td>3.28</td>
    </tr>
    <tr>
      <th>Basic EPS</th>
      <td>NaN</td>
      <td>6.16</td>
      <td>6.15</td>
      <td>5.67</td>
      <td>3.31</td>
    </tr>
    <tr>
      <th>Diluted NI Availto Com Stockholders</th>
      <td>93736000000.0</td>
      <td>96995000000.0</td>
      <td>99803000000.0</td>
      <td>94680000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Net Income Common Stockholders</th>
      <td>93736000000.0</td>
      <td>96995000000.0</td>
      <td>99803000000.0</td>
      <td>94680000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Net Income</th>
      <td>93736000000.0</td>
      <td>96995000000.0</td>
      <td>99803000000.0</td>
      <td>94680000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Net Income Including Noncontrolling Interests</th>
      <td>93736000000.0</td>
      <td>96995000000.0</td>
      <td>99803000000.0</td>
      <td>94680000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Net Income Continuous Operations</th>
      <td>93736000000.0</td>
      <td>96995000000.0</td>
      <td>99803000000.0</td>
      <td>94680000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Tax Provision</th>
      <td>29749000000.0</td>
      <td>16741000000.0</td>
      <td>19300000000.0</td>
      <td>14527000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Pretax Income</th>
      <td>123485000000.0</td>
      <td>113736000000.0</td>
      <td>119103000000.0</td>
      <td>109207000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Other Income Expense</th>
      <td>269000000.0</td>
      <td>-565000000.0</td>
      <td>-334000000.0</td>
      <td>60000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Other Non Operating Income Expenses</th>
      <td>269000000.0</td>
      <td>-565000000.0</td>
      <td>-334000000.0</td>
      <td>60000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Net Non Operating Interest Income Expense</th>
      <td>NaN</td>
      <td>-183000000.0</td>
      <td>-106000000.0</td>
      <td>198000000.0</td>
      <td>890000000.0</td>
    </tr>
    <tr>
      <th>Interest Expense Non Operating</th>
      <td>NaN</td>
      <td>3933000000.0</td>
      <td>2931000000.0</td>
      <td>2645000000.0</td>
      <td>2873000000.0</td>
    </tr>
    <tr>
      <th>Interest Income Non Operating</th>
      <td>NaN</td>
      <td>3750000000.0</td>
      <td>2825000000.0</td>
      <td>2843000000.0</td>
      <td>3763000000.0</td>
    </tr>
    <tr>
      <th>Operating Income</th>
      <td>123216000000.0</td>
      <td>114301000000.0</td>
      <td>119437000000.0</td>
      <td>108949000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Operating Expense</th>
      <td>57467000000.0</td>
      <td>54847000000.0</td>
      <td>51345000000.0</td>
      <td>43887000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Research And Development</th>
      <td>31370000000.0</td>
      <td>29915000000.0</td>
      <td>26251000000.0</td>
      <td>21914000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Selling General And Administration</th>
      <td>26097000000.0</td>
      <td>24932000000.0</td>
      <td>25094000000.0</td>
      <td>21973000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Gross Profit</th>
      <td>180683000000.0</td>
      <td>169148000000.0</td>
      <td>170782000000.0</td>
      <td>152836000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Cost Of Revenue</th>
      <td>210352000000.0</td>
      <td>214137000000.0</td>
      <td>223546000000.0</td>
      <td>212981000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Total Revenue</th>
      <td>391035000000.0</td>
      <td>383285000000.0</td>
      <td>394328000000.0</td>
      <td>365817000000.0</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>Operating Revenue</th>
      <td>391035000000.0</td>
      <td>383285000000.0</td>
      <td>394328000000.0</td>
      <td>365817000000.0</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>



**Note**: As yfinance was giving errors while trying to pull the earning reports, I swithched to use `Alpha Vantage`, this data source requires `API_KEY` which can be retrivable from their website: https://www.alphavantage.co/support/#api-key

Im only going to use it to recreate historical data, we will continue using `yfinance` for future earnings


```python
from earnings import load_all_historical_earnings_to_dataframe

unique_tickers = data_transformed['Ticker'].unique()
past_earnings = load_all_historical_earnings_to_dataframe(symbols=unique_tickers)

past_earnings
# unique_tickers
```

    LEGC: Loading historical data for T...
    LEGC: Loading historical data for MSFT...
    LEGC: Loading historical data for F...
    LEGC: Loading historical data for TSLA...
    LEGC: Loading historical data for AAPL...
    LEGC: Loading historical data for DOX...
    LEGC: Loading historical data for VZ...
    LEGC: Loading historical data for CRM...
    LEGC: Loading historical data for SNOW...
    LEGC: Loading historical data for ADBE...
    LEGC: Loading historical data for NET...
    LEGC: Loading historical data for NVDA...
    LEGC: Loading historical data for META...
    LEGC: Combined historical earnings data into a single DataFrame.





<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>fiscalDateEnding</th>
      <th>reportedDate</th>
      <th>reportedEPS</th>
      <th>estimatedEPS</th>
      <th>surprise</th>
      <th>surprisePercentage</th>
      <th>reportTime</th>
      <th>symbol</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2024-09-30</td>
      <td>2024-10-23</td>
      <td>0.6</td>
      <td>0.57</td>
      <td>0.03</td>
      <td>5.2632</td>
      <td>pre-market</td>
      <td>T</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2024-06-30</td>
      <td>2024-07-24</td>
      <td>0.57</td>
      <td>0.57</td>
      <td>0</td>
      <td>0</td>
      <td>pre-market</td>
      <td>T</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2024-03-31</td>
      <td>2024-04-24</td>
      <td>0.55</td>
      <td>0.54</td>
      <td>0.01</td>
      <td>1.8519</td>
      <td>pre-market</td>
      <td>T</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2023-12-31</td>
      <td>2024-01-24</td>
      <td>0.54</td>
      <td>0.56</td>
      <td>-0.02</td>
      <td>-3.5714</td>
      <td>pre-market</td>
      <td>T</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2023-09-30</td>
      <td>2023-10-19</td>
      <td>0.64</td>
      <td>0.62</td>
      <td>0.02</td>
      <td>3.2258</td>
      <td>pre-market</td>
      <td>T</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>1125</th>
      <td>2013-03-31</td>
      <td>2013-05-01</td>
      <td>0.12</td>
      <td>0.13</td>
      <td>-0.01</td>
      <td>-7.6923</td>
      <td>pre-market</td>
      <td>META</td>
    </tr>
    <tr>
      <th>1126</th>
      <td>2012-12-31</td>
      <td>2013-01-30</td>
      <td>0.17</td>
      <td>0.15</td>
      <td>0.02</td>
      <td>13.3333</td>
      <td>pre-market</td>
      <td>META</td>
    </tr>
    <tr>
      <th>1127</th>
      <td>2012-09-30</td>
      <td>2012-10-23</td>
      <td>0.12</td>
      <td>0.11</td>
      <td>0.01</td>
      <td>9.0909</td>
      <td>pre-market</td>
      <td>META</td>
    </tr>
    <tr>
      <th>1128</th>
      <td>2012-06-30</td>
      <td>2012-07-26</td>
      <td>0.12</td>
      <td>0.12</td>
      <td>0</td>
      <td>0</td>
      <td>pre-market</td>
      <td>META</td>
    </tr>
    <tr>
      <th>1129</th>
      <td>2012-03-31</td>
      <td>2012-05-30</td>
      <td>0.0645</td>
      <td>None</td>
      <td>None</td>
      <td>None</td>
      <td>pre-market</td>
      <td>META</td>
    </tr>
  </tbody>
</table>
<p>1130 rows × 8 columns</p>
</div>




```python
past_earnings.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 1130 entries, 0 to 1129
    Data columns (total 8 columns):
     #   Column              Non-Null Count  Dtype 
    ---  ------              --------------  ----- 
     0   fiscalDateEnding    1130 non-null   object
     1   reportedDate        1130 non-null   object
     2   reportedEPS         1130 non-null   object
     3   estimatedEPS        1130 non-null   object
     4   surprise            1130 non-null   object
     5   surprisePercentage  1130 non-null   object
     6   reportTime          1130 non-null   object
     7   symbol              1130 non-null   object
    dtypes: object(8)
    memory usage: 70.8+ KB



```python
past_earnings['reportedDate'] = pd.to_datetime(past_earnings['reportedDate'])
past_earnings['fiscalDateEnding'] = pd.to_datetime(past_earnings['fiscalDateEnding'])
past_earnings.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>fiscalDateEnding</th>
      <th>reportedDate</th>
      <th>reportedEPS</th>
      <th>estimatedEPS</th>
      <th>surprise</th>
      <th>surprisePercentage</th>
      <th>reportTime</th>
      <th>symbol</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2024-09-30</td>
      <td>2024-10-23</td>
      <td>0.6</td>
      <td>0.57</td>
      <td>0.03</td>
      <td>5.2632</td>
      <td>pre-market</td>
      <td>T</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2024-06-30</td>
      <td>2024-07-24</td>
      <td>0.57</td>
      <td>0.57</td>
      <td>0</td>
      <td>0</td>
      <td>pre-market</td>
      <td>T</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2024-03-31</td>
      <td>2024-04-24</td>
      <td>0.55</td>
      <td>0.54</td>
      <td>0.01</td>
      <td>1.8519</td>
      <td>pre-market</td>
      <td>T</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2023-12-31</td>
      <td>2024-01-24</td>
      <td>0.54</td>
      <td>0.56</td>
      <td>-0.02</td>
      <td>-3.5714</td>
      <td>pre-market</td>
      <td>T</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2023-09-30</td>
      <td>2023-10-19</td>
      <td>0.64</td>
      <td>0.62</td>
      <td>0.02</td>
      <td>3.2258</td>
      <td>pre-market</td>
      <td>T</td>
    </tr>
  </tbody>
</table>
</div>




```python
from earnings import load_all_upcoming_earnings_to_dataframe

unique_tickers = data_transformed['Ticker'].unique()
future_earnings = load_all_upcoming_earnings_to_dataframe(symbols=unique_tickers)

future_earnings
```

    LEGC: Loading upcoming data for T from T.json...
    LEGC: Loading upcoming data for MSFT from MSFT.json...
    LEGC: Loading upcoming data for F from F.json...
    LEGC: Loading upcoming data for TSLA from TSLA.json...
    LEGC: Loading upcoming data for AAPL from AAPL.json...
    LEGC: Loading upcoming data for DOX from DOX.json...
    LEGC: Loading upcoming data for VZ from VZ.json...
    LEGC: Loading upcoming data for CRM from CRM.json...
    LEGC: Loading upcoming data for SNOW from SNOW.json...
    LEGC: Loading upcoming data for ADBE from ADBE.json...
    LEGC: Loading upcoming data for NET from NET.json...
    LEGC: Loading upcoming data for NVDA from NVDA.json...
    LEGC: Loading upcoming data for META from META.json...
    LEGC: Combined upcoming earnings data loaded. Shape: (13, 9)





<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Earnings Date Start</th>
      <th>Earnings Date End</th>
      <th>Earnings High</th>
      <th>Earnings Low</th>
      <th>Earnings Average</th>
      <th>Revenue High</th>
      <th>Revenue Low</th>
      <th>Revenue Average</th>
      <th>symbol</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>2025-01-27</td>
      <td>2025-01-27</td>
      <td>0.56</td>
      <td>0.47000</td>
      <td>0.50678</td>
      <td>32295000000</td>
      <td>31427000000</td>
      <td>31950874740</td>
      <td>T</td>
    </tr>
    <tr>
      <th>1</th>
      <td>2025-01-28</td>
      <td>2025-02-03</td>
      <td>3.47</td>
      <td>3.02000</td>
      <td>3.14194</td>
      <td>70520000000</td>
      <td>68488700000</td>
      <td>68875138460</td>
      <td>MSFT</td>
    </tr>
    <tr>
      <th>2</th>
      <td>2025-02-04</td>
      <td>2025-02-10</td>
      <td>0.43</td>
      <td>0.31000</td>
      <td>0.34528</td>
      <td>46922000000</td>
      <td>41946000000</td>
      <td>43889075000</td>
      <td>F</td>
    </tr>
    <tr>
      <th>3</th>
      <td>2025-01-24</td>
      <td>2025-02-03</td>
      <td>0.96</td>
      <td>0.59000</td>
      <td>0.76149</td>
      <td>28928100000</td>
      <td>25293000000</td>
      <td>27418870650</td>
      <td>TSLA</td>
    </tr>
    <tr>
      <th>4</th>
      <td>2025-01-30</td>
      <td>2025-02-03</td>
      <td>2.50</td>
      <td>2.19000</td>
      <td>2.35640</td>
      <td>129887000000</td>
      <td>119563000000</td>
      <td>124410526290</td>
      <td>AAPL</td>
    </tr>
    <tr>
      <th>5</th>
      <td>2025-02-04</td>
      <td>2025-02-10</td>
      <td>1.67</td>
      <td>1.60000</td>
      <td>1.63760</td>
      <td>1116368000</td>
      <td>1112200000</td>
      <td>1114785960</td>
      <td>DOX</td>
    </tr>
    <tr>
      <th>6</th>
      <td>2025-01-24</td>
      <td>2025-01-24</td>
      <td>1.17</td>
      <td>1.05925</td>
      <td>1.10736</td>
      <td>36050000000</td>
      <td>34926000000</td>
      <td>35333948360</td>
      <td>VZ</td>
    </tr>
    <tr>
      <th>7</th>
      <td>2025-02-26</td>
      <td>2025-03-03</td>
      <td>2.72</td>
      <td>2.48000</td>
      <td>2.61467</td>
      <td>10178707000</td>
      <td>9964635000</td>
      <td>10036585380</td>
      <td>CRM</td>
    </tr>
    <tr>
      <th>8</th>
      <td>2025-02-26</td>
      <td>2025-03-03</td>
      <td>0.27</td>
      <td>0.12000</td>
      <td>0.17585</td>
      <td>984000000</td>
      <td>948900000</td>
      <td>955732650</td>
      <td>SNOW</td>
    </tr>
    <tr>
      <th>9</th>
      <td>2025-03-12</td>
      <td>2025-03-17</td>
      <td>5.03</td>
      <td>4.93000</td>
      <td>4.97224</td>
      <td>5730000000</td>
      <td>5633000000</td>
      <td>5664047550</td>
      <td>ADBE</td>
    </tr>
    <tr>
      <th>10</th>
      <td>2025-02-06</td>
      <td>2025-02-10</td>
      <td>0.22</td>
      <td>0.16000</td>
      <td>0.18064</td>
      <td>460038000</td>
      <td>451000000</td>
      <td>452064040</td>
      <td>NET</td>
    </tr>
    <tr>
      <th>11</th>
      <td>2025-02-26</td>
      <td>2025-02-26</td>
      <td>0.98</td>
      <td>0.82000</td>
      <td>0.84555</td>
      <td>42076710000</td>
      <td>36348000000</td>
      <td>38025959860</td>
      <td>NVDA</td>
    </tr>
    <tr>
      <th>12</th>
      <td>2025-01-30</td>
      <td>2025-02-03</td>
      <td>7.29</td>
      <td>6.15000</td>
      <td>6.73977</td>
      <td>47924201590</td>
      <td>45733000000</td>
      <td>46978328180</td>
      <td>META</td>
    </tr>
  </tbody>
</table>
</div>



### Matching Fields Between Historical and Future Earnings

| **Field in Historical Data** | **Field in Future Data** | **Description**                                      |
|-------------------------------|--------------------------|------------------------------------------------------|
| `fiscalDateEnding`            | `Earnings Date`          | The date of the earnings report. Historical is actual; future is estimated. |
| `reportedEPS`                 | `Earnings Average`       | Earnings Per Share (EPS). Historical is reported; future is the average estimate. |
| `totalRevenue`                | `Revenue Average`        | Total revenue reported/estimated for the fiscal period. |

### Notes
- These fields are directly comparable across historical and future earnings data.
- Fields such as `Earnings High`, `Earnings Low`, `Revenue High`, and `Revenue Low` exist only in future data and may be added later for extended analysis.


```python
# Unify the date (incomming and history earnings)
import pandas as pd

# Example historical and future dataframes
historical_df = past_earnings.copy()
future_df = future_earnings.copy()
data_df = data_transformed.copy()

print(future_df.info())
print(historical_df.info())
print(data_transformed.info())

```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 13 entries, 0 to 12
    Data columns (total 9 columns):
     #   Column               Non-Null Count  Dtype  
    ---  ------               --------------  -----  
     0   Earnings Date Start  13 non-null     object 
     1   Earnings Date End    13 non-null     object 
     2   Earnings High        13 non-null     float64
     3   Earnings Low         13 non-null     float64
     4   Earnings Average     13 non-null     float64
     5   Revenue High         13 non-null     int64  
     6   Revenue Low          13 non-null     int64  
     7   Revenue Average      13 non-null     int64  
     8   symbol               13 non-null     object 
    dtypes: float64(3), int64(3), object(3)
    memory usage: 1.0+ KB
    None
    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 1130 entries, 0 to 1129
    Data columns (total 8 columns):
     #   Column              Non-Null Count  Dtype         
    ---  ------              --------------  -----         
     0   fiscalDateEnding    1130 non-null   datetime64[ns]
     1   reportedDate        1130 non-null   datetime64[ns]
     2   reportedEPS         1130 non-null   object        
     3   estimatedEPS        1130 non-null   object        
     4   surprise            1130 non-null   object        
     5   surprisePercentage  1130 non-null   object        
     6   reportTime          1130 non-null   object        
     7   symbol              1130 non-null   object        
    dtypes: datetime64[ns](2), object(6)
    memory usage: 70.8+ KB
    None
    <class 'pandas.core.frame.DataFrame'>
    Index: 21694 entries, 0 to 22801
    Data columns (total 15 columns):
     #   Column                   Non-Null Count  Dtype         
    ---  ------                   --------------  -----         
     0   Date                     21694 non-null  datetime64[ns]
     1   Ticker                   21694 non-null  object        
     2   Adj_Close                21694 non-null  float64       
     3   Close                    21694 non-null  float64       
     4   High                     21694 non-null  float64       
     5   Low                      21694 non-null  float64       
     6   Open                     21694 non-null  float64       
     7   Volume                   21694 non-null  float64       
     8   Ticker_Encoded           21694 non-null  int64         
     9   year                     21694 non-null  int64         
     10  month                    21694 non-null  int64         
     11  day                      21694 non-null  int64         
     12  weekday                  21694 non-null  int64         
     13  is_day_before_a_holiday  21694 non-null  int64         
     14  is_day_after_a_holiday   21694 non-null  int64         
    dtypes: datetime64[ns](1), float64(6), int64(7), object(1)
    memory usage: 2.6+ MB
    None



```python
import pandas as pd

# Ensure proper column renaming and date formats
future_df.rename(columns={'symbol': 'Ticker'}, inplace=True)
historical_df.rename(columns={'symbol': 'Ticker'}, inplace=True)

future_df['Earnings Date Start'] = pd.to_datetime(future_df['Earnings Date Start'])
future_df['Earnings Date End'] = pd.to_datetime(future_df['Earnings Date End'])
historical_df['reportedDate'] = pd.to_datetime(historical_df['reportedDate'])
data_df['Date'] = pd.to_datetime(data_df['Date'])

# Step 1: Merge historical earnings into stock prices
merged_historical = pd.merge_asof(
    data_df.sort_values('Date'),
    historical_df.sort_values('reportedDate'),
    left_on='Date',
    right_on='reportedDate',
    by='Ticker',
    direction='backward'  # Matches the most recent past earnings report
)

# Calculate days after previous earnings
merged_historical['days_after_previous_earning'] = (
    merged_historical['Date'] - merged_historical['reportedDate']
).dt.days

# Step 2: Merge future earnings into stock prices
merged_future = pd.merge_asof(
    data_df.sort_values('Date'),
    future_df.sort_values('Earnings Date Start'),
    left_on='Date',
    right_on='Earnings Date Start',
    by='Ticker',
    direction='forward'  # Matches the closest upcoming earnings
)

# Calculate days to next earnings
merged_future['days_to_next_earning'] = (
    merged_future['Earnings Date Start'] - merged_future['Date']
).dt.days

# Step 3: Combine historical and future earnings data
final_merged = pd.merge(
    merged_historical,
    merged_future[['Date', 'Ticker', 'days_to_next_earning']],
    on=['Date', 'Ticker'],
    how='left'
)

# Clean up columns:
final_merged.drop(columns=['reportTime'], inplace=True)

# Convert object columns to float
columns_to_convert = ['reportedEPS', 'estimatedEPS', 'surprise', 'surprisePercentage']

for col in columns_to_convert:
    final_merged[col] = pd.to_numeric(final_merged[col], errors='coerce')  # Converts invalid entries to NaN

# Check the data types and any potential NaN values
print("\nUpdated Data Types:")
print(final_merged.dtypes)

print("\nSummary of Null Values After Conversion:")
print(final_merged.isnull().sum())

# Optional: Handle NaN values (if needed)
# Example: Fill with a default value or interpolate
final_merged[columns_to_convert] = final_merged[columns_to_convert].fillna(0)  # Replace NaN with 0

# Final structure
print("\nFinal Merged DataFrame Info:")
final_merged.info()

# Check for null values (optional)
null_summary = final_merged.isnull().sum()
print("\nNull Values Summary:")
print(null_summary)

# Sample rows for validation
print("\nSample Rows:")
print(final_merged.head())
```

    
    Updated Data Types:
    Date                           datetime64[ns]
    Ticker                                 object
    Adj_Close                             float64
    Close                                 float64
    High                                  float64
    Low                                   float64
    Open                                  float64
    Volume                                float64
    Ticker_Encoded                          int64
    year                                    int64
    month                                   int64
    day                                     int64
    weekday                                 int64
    is_day_before_a_holiday                 int64
    is_day_after_a_holiday                  int64
    fiscalDateEnding               datetime64[ns]
    reportedDate                   datetime64[ns]
    reportedEPS                           float64
    estimatedEPS                          float64
    surprise                              float64
    surprisePercentage                    float64
    days_after_previous_earning             int64
    days_to_next_earning                    int64
    dtype: object
    
    Summary of Null Values After Conversion:
    Date                            0
    Ticker                          0
    Adj_Close                       0
    Close                           0
    High                            0
    Low                             0
    Open                            0
    Volume                          0
    Ticker_Encoded                  0
    year                            0
    month                           0
    day                             0
    weekday                         0
    is_day_before_a_holiday         0
    is_day_after_a_holiday          0
    fiscalDateEnding                0
    reportedDate                    0
    reportedEPS                     0
    estimatedEPS                    0
    surprise                        0
    surprisePercentage             39
    days_after_previous_earning     0
    days_to_next_earning            0
    dtype: int64
    
    Final Merged DataFrame Info:
    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 21694 entries, 0 to 21693
    Data columns (total 23 columns):
     #   Column                       Non-Null Count  Dtype         
    ---  ------                       --------------  -----         
     0   Date                         21694 non-null  datetime64[ns]
     1   Ticker                       21694 non-null  object        
     2   Adj_Close                    21694 non-null  float64       
     3   Close                        21694 non-null  float64       
     4   High                         21694 non-null  float64       
     5   Low                          21694 non-null  float64       
     6   Open                         21694 non-null  float64       
     7   Volume                       21694 non-null  float64       
     8   Ticker_Encoded               21694 non-null  int64         
     9   year                         21694 non-null  int64         
     10  month                        21694 non-null  int64         
     11  day                          21694 non-null  int64         
     12  weekday                      21694 non-null  int64         
     13  is_day_before_a_holiday      21694 non-null  int64         
     14  is_day_after_a_holiday       21694 non-null  int64         
     15  fiscalDateEnding             21694 non-null  datetime64[ns]
     16  reportedDate                 21694 non-null  datetime64[ns]
     17  reportedEPS                  21694 non-null  float64       
     18  estimatedEPS                 21694 non-null  float64       
     19  surprise                     21694 non-null  float64       
     20  surprisePercentage           21694 non-null  float64       
     21  days_after_previous_earning  21694 non-null  int64         
     22  days_to_next_earning         21694 non-null  int64         
    dtypes: datetime64[ns](3), float64(10), int64(9), object(1)
    memory usage: 3.8+ MB
    
    Null Values Summary:
    Date                           0
    Ticker                         0
    Adj_Close                      0
    Close                          0
    High                           0
    Low                            0
    Open                           0
    Volume                         0
    Ticker_Encoded                 0
    year                           0
    month                          0
    day                            0
    weekday                        0
    is_day_before_a_holiday        0
    is_day_after_a_holiday         0
    fiscalDateEnding               0
    reportedDate                   0
    reportedEPS                    0
    estimatedEPS                   0
    surprise                       0
    surprisePercentage             0
    days_after_previous_earning    0
    days_to_next_earning           0
    dtype: int64
    
    Sample Rows:
            Date Ticker   Adj_Close       Close        High         Low  \
    0 2018-01-02   AAPL   40.524349   43.064999   43.075001   42.314999   
    1 2018-01-02   ADBE  177.699997  177.699997  177.800003  175.259995   
    2 2018-01-02    CRM  103.830070  104.410004  104.699997  102.269997   
    3 2018-01-02    DOX   58.145020   66.180000   66.250000   65.440002   
    4 2018-01-02      F    8.875399   12.660000   12.660000   12.500000   
    
             Open       Volume  Ticker_Encoded  year  ...  \
    0   42.540001  102223600.0               0  2018  ...   
    1  175.850006    2432800.0               1  2018  ...   
    2  102.879997    4669200.0               2  2018  ...   
    3   65.500000     525300.0               3  2018  ...   
    4   12.520000   20773300.0               4  2018  ...   
    
       is_day_before_a_holiday  is_day_after_a_holiday  fiscalDateEnding  \
    0                        1                       0        2017-09-30   
    1                        1                       0        2017-11-30   
    2                        1                       0        2017-10-31   
    3                        1                       0        2017-09-30   
    4                        1                       0        2017-09-30   
    
       reportedDate  reportedEPS estimatedEPS surprise  surprisePercentage  \
    0    2017-11-02       0.5175       0.4675     0.05             10.6952   
    1    2017-12-14       1.2600       1.1600     0.10              8.6207   
    2    2017-11-21       0.3900       0.3700     0.02              5.4054   
    3    2017-11-08       0.9400       0.9500    -0.01             -1.0526   
    4    2017-10-26       0.4300       0.3200     0.11             34.3750   
    
       days_after_previous_earning  days_to_next_earning  
    0                           61                  2585  
    1                           19                  2626  
    2                           42                  2612  
    3                           55                  2590  
    4                           68                  2590  
    
    [5 rows x 23 columns]



```python
# Create moving averages for Adj_Close
window_sizes = [5, 10, 20]  # You can adjust the window sizes as needed
for window in window_sizes:
    final_merged[f'ma_{window}'] = final_merged.groupby('Ticker')['Adj_Close'].transform(lambda x: x.rolling(window).mean())
    final_merged[f'volatility_{window}'] = final_merged.groupby('Ticker')['Adj_Close'].transform(lambda x: x.rolling(window).std())
    
final_merged['pct_change'] = final_merged.groupby('Ticker')['Adj_Close'].transform(lambda x: x.pct_change())
final_merged['high_low_spread'] = (final_merged['High'] - final_merged['Low']) / final_merged['Low']
  
final_merged.tail()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Date</th>
      <th>Ticker</th>
      <th>Adj_Close</th>
      <th>Close</th>
      <th>High</th>
      <th>Low</th>
      <th>Open</th>
      <th>Volume</th>
      <th>Ticker_Encoded</th>
      <th>year</th>
      <th>...</th>
      <th>days_after_previous_earning</th>
      <th>days_to_next_earning</th>
      <th>ma_5</th>
      <th>volatility_5</th>
      <th>ma_10</th>
      <th>volatility_10</th>
      <th>ma_20</th>
      <th>volatility_20</th>
      <th>pct_change</th>
      <th>high_low_spread</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>21689</th>
      <td>2024-12-19</td>
      <td>CRM</td>
      <td>336.230011</td>
      <td>336.230011</td>
      <td>343.424988</td>
      <td>335.429993</td>
      <td>341.695007</td>
      <td>7414322.0</td>
      <td>2</td>
      <td>2024</td>
      <td>...</td>
      <td>16</td>
      <td>69</td>
      <td>346.951819</td>
      <td>9.596393</td>
      <td>350.799582</td>
      <td>8.327843</td>
      <td>345.794371</td>
      <td>11.983721</td>
      <td>-0.002965</td>
      <td>0.023835</td>
    </tr>
    <tr>
      <th>21690</th>
      <td>2024-12-19</td>
      <td>ADBE</td>
      <td>437.390015</td>
      <td>437.390015</td>
      <td>448.950012</td>
      <td>437.109985</td>
      <td>443.269989</td>
      <td>4912347.0</td>
      <td>1</td>
      <td>2024</td>
      <td>...</td>
      <td>8</td>
      <td>83</td>
      <td>452.230005</td>
      <td>12.411017</td>
      <td>493.365002</td>
      <td>49.484177</td>
      <td>506.552499</td>
      <td>37.372900</td>
      <td>-0.008883</td>
      <td>0.027087</td>
    </tr>
    <tr>
      <th>21691</th>
      <td>2024-12-19</td>
      <td>AAPL</td>
      <td>249.789993</td>
      <td>249.789993</td>
      <td>251.850006</td>
      <td>247.094894</td>
      <td>247.460007</td>
      <td>58911560.0</td>
      <td>0</td>
      <td>2024</td>
      <td>...</td>
      <td>49</td>
      <td>42</td>
      <td>250.097998</td>
      <td>2.263151</td>
      <td>248.230000</td>
      <td>2.838018</td>
      <td>242.458498</td>
      <td>7.243537</td>
      <td>0.007015</td>
      <td>0.019244</td>
    </tr>
    <tr>
      <th>21692</th>
      <td>2024-12-19</td>
      <td>META</td>
      <td>595.570007</td>
      <td>595.570007</td>
      <td>611.520020</td>
      <td>595.000000</td>
      <td>610.390015</td>
      <td>12932671.0</td>
      <td>5</td>
      <td>2024</td>
      <td>...</td>
      <td>50</td>
      <td>42</td>
      <td>611.257996</td>
      <td>13.723346</td>
      <td>617.390521</td>
      <td>12.388054</td>
      <td>600.139682</td>
      <td>24.731882</td>
      <td>-0.002713</td>
      <td>0.027765</td>
    </tr>
    <tr>
      <th>21693</th>
      <td>2024-12-19</td>
      <td>VZ</td>
      <td>39.970001</td>
      <td>39.970001</td>
      <td>40.459999</td>
      <td>39.932800</td>
      <td>40.049999</td>
      <td>13373054.0</td>
      <td>12</td>
      <td>2024</td>
      <td>...</td>
      <td>58</td>
      <td>36</td>
      <td>40.830000</td>
      <td>0.893755</td>
      <td>41.525000</td>
      <td>0.951399</td>
      <td>42.536000</td>
      <td>1.342638</td>
      <td>-0.006710</td>
      <td>0.013202</td>
    </tr>
  </tbody>
</table>
<p>5 rows × 31 columns</p>
</div>




```python
final_merged.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 21694 entries, 0 to 21693
    Data columns (total 31 columns):
     #   Column                       Non-Null Count  Dtype         
    ---  ------                       --------------  -----         
     0   Date                         21694 non-null  datetime64[ns]
     1   Ticker                       21694 non-null  object        
     2   Adj_Close                    21694 non-null  float64       
     3   Close                        21694 non-null  float64       
     4   High                         21694 non-null  float64       
     5   Low                          21694 non-null  float64       
     6   Open                         21694 non-null  float64       
     7   Volume                       21694 non-null  float64       
     8   Ticker_Encoded               21694 non-null  int64         
     9   year                         21694 non-null  int64         
     10  month                        21694 non-null  int64         
     11  day                          21694 non-null  int64         
     12  weekday                      21694 non-null  int64         
     13  is_day_before_a_holiday      21694 non-null  int64         
     14  is_day_after_a_holiday       21694 non-null  int64         
     15  fiscalDateEnding             21694 non-null  datetime64[ns]
     16  reportedDate                 21694 non-null  datetime64[ns]
     17  reportedEPS                  21694 non-null  float64       
     18  estimatedEPS                 21694 non-null  float64       
     19  surprise                     21694 non-null  float64       
     20  surprisePercentage           21694 non-null  float64       
     21  days_after_previous_earning  21694 non-null  int64         
     22  days_to_next_earning         21694 non-null  int64         
     23  ma_5                         21642 non-null  float64       
     24  volatility_5                 21642 non-null  float64       
     25  ma_10                        21577 non-null  float64       
     26  volatility_10                21577 non-null  float64       
     27  ma_20                        21447 non-null  float64       
     28  volatility_20                21447 non-null  float64       
     29  pct_change                   21681 non-null  float64       
     30  high_low_spread              21694 non-null  float64       
    dtypes: datetime64[ns](3), float64(18), int64(9), object(1)
    memory usage: 5.1+ MB




# Train - Test Split


```python
""" 
valid_data = 15%
test_data = 15%
train_data = 70%
"""

train_split = int(0.7 * len(final_merged))  # 70% for training
valid_split = int(0.85 * len(final_merged))  # 15% for validation (remaining half of the 30% split)

# Perform splits based on index ranges (no shuffling)
train_data = final_merged.iloc[:train_split]
validation_data = final_merged.iloc[train_split:valid_split]
test_data = final_merged.iloc[valid_split:]

# Separate features and target for all splits
X_train = train_data.drop(columns=['Adj_Close', 'Date', 'Ticker', 'fiscalDateEnding', 'reportedDate'])
y_train = train_data['Adj_Close']

X_valid = validation_data.drop(columns=['Adj_Close', 'Date', 'Ticker', 'fiscalDateEnding', 'reportedDate'])
y_valid = validation_data['Adj_Close']

X_test = test_data.drop(columns=['Adj_Close', 'Date', 'Ticker', 'fiscalDateEnding', 'reportedDate'])
y_test = test_data['Adj_Close']

# Handle missing values
for column in X_train.columns:
    X_train[column].fillna(X_train[column].mean(), inplace=True)
    X_valid[column].fillna(X_train[column].mean(), inplace=True)
    X_test[column].fillna(X_train[column].mean(), inplace=True)
```

    /var/folders/sl/kpl6n5j90zg8bxc7vtmmktdc0000gn/T/ipykernel_50037/1577522863.py:27: FutureWarning: A value is trying to be set on a copy of a DataFrame or Series through chained assignment using an inplace method.
    The behavior will change in pandas 3.0. This inplace method will never work because the intermediate object on which we are setting values always behaves as a copy.
    
    For example, when doing 'df[col].method(value, inplace=True)', try using 'df.method({col: value}, inplace=True)' or df[col] = df[col].method(value) instead, to perform the operation inplace on the original object.
    
    
      X_train[column].fillna(X_train[column].mean(), inplace=True)
    /var/folders/sl/kpl6n5j90zg8bxc7vtmmktdc0000gn/T/ipykernel_50037/1577522863.py:28: FutureWarning: A value is trying to be set on a copy of a DataFrame or Series through chained assignment using an inplace method.
    The behavior will change in pandas 3.0. This inplace method will never work because the intermediate object on which we are setting values always behaves as a copy.
    
    For example, when doing 'df[col].method(value, inplace=True)', try using 'df.method({col: value}, inplace=True)' or df[col] = df[col].method(value) instead, to perform the operation inplace on the original object.
    
    
      X_valid[column].fillna(X_train[column].mean(), inplace=True)
    /var/folders/sl/kpl6n5j90zg8bxc7vtmmktdc0000gn/T/ipykernel_50037/1577522863.py:29: FutureWarning: A value is trying to be set on a copy of a DataFrame or Series through chained assignment using an inplace method.
    The behavior will change in pandas 3.0. This inplace method will never work because the intermediate object on which we are setting values always behaves as a copy.
    
    For example, when doing 'df[col].method(value, inplace=True)', try using 'df.method({col: value}, inplace=True)' or df[col] = df[col].method(value) instead, to perform the operation inplace on the original object.
    
    
      X_test[column].fillna(X_train[column].mean(), inplace=True)



```python
print(X_train.dtypes)
```

    Close                          float64
    High                           float64
    Low                            float64
    Open                           float64
    Volume                         float64
    Ticker_Encoded                   int64
    year                             int64
    month                            int64
    day                              int64
    weekday                          int64
    is_day_before_a_holiday          int64
    is_day_after_a_holiday           int64
    reportedEPS                    float64
    estimatedEPS                   float64
    surprise                       float64
    surprisePercentage             float64
    days_after_previous_earning      int64
    days_to_next_earning             int64
    ma_5                           float64
    volatility_5                   float64
    ma_10                          float64
    volatility_10                  float64
    ma_20                          float64
    volatility_20                  float64
    pct_change                     float64
    high_low_spread                float64
    dtype: object



```python
import json

# Save X_train columns into a JSON file in order
columns = list(X_train.columns)  # Convert the column names to a list

# Specify the file name
file_name = "X_train_columns.json"

# Save to JSON
with open(file_name, "w") as file:
    json.dump(columns, file, indent=4)

print(f"Columns saved to {file_name}.")
```

    Columns saved to X_train_columns.json.



```python
from sklearn.preprocessing import StandardScaler
import joblib

scaler = StandardScaler()

# Fit scaler on training data
X_train_scaled = scaler.fit_transform(X_train)

# Transform validation and test data
X_valid_scaled = scaler.transform(X_valid)
X_test_scaled = scaler.transform(X_test)

joblib.dump(scaler, "scaler.pkl")
```




    ['scaler.pkl']



# Baseline


```python
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score

# Initialize the model
model = LinearRegression()

# Train the model
model.fit(X_train_scaled, y_train)

# Predict on the test set
y_pred = model.predict(X_test_scaled)

# Evaluate the model
mae = mean_absolute_error(y_test, y_pred)
mse = mean_squared_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)

print(f"MAE: {mae}")
print(f"MSE: {mse}")
print(f"R2 Score: {r2}")
```

    MAE: 1.9336402993575565
    MSE: 6.132892448697202
    R2 Score: 0.9998002214862196



```python
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score

# Initialize the model
model_r = LinearRegression()

# Train the model
model_r.fit(X_train_scaled, y_train)

# Predict on the test set
y_pred = model_r.predict(X_test_scaled)

# Evaluate the model
mae = mean_absolute_error(y_test, y_pred)
mse = mean_squared_error(y_test, y_pred)
r2 = r2_score(y_test, y_pred)

print(f"MAE: {mae}")
print(f"MSE: {mse}")
print(f"R2 Score: {r2}")

```

    MAE: 1.9336402993575565
    MSE: 6.132892448697202
    R2 Score: 0.9998002214862196


	•	MAE (Mean Absolute Error): 1.90 – On average, the model’s predictions deviate by approximately 2 units from the actual adjusted close prices.
	•	MSE (Mean Squared Error): 6.06 – The squared error (penalizing larger deviations more heavily) is still quite low.
	•	R² Score: 0.9998 – Your model explains nearly all the variability in the target variable.




```python
# Lets Validate the model against unseen data:

# Predict on the validation set
y_valid_pred = model.predict(X_valid_scaled)

# Evaluate the model on validation data
mae_valid = mean_absolute_error(y_valid, y_valid_pred)
mse_valid = mean_squared_error(y_valid, y_valid_pred)
r2_valid = r2_score(y_valid, y_valid_pred)

print(f"Validation MAE: {mae_valid}")
print(f"Validation MSE: {mse_valid}")
print(f"Validation R2 Score: {r2_valid}")
```

    Validation MAE: 1.4397610162316246
    Validation MSE: 3.5859975199158134
    Validation R2 Score: 0.9997996849086161


	1.	Validation MAE (1.48):
	•	This means the average absolute difference between the predicted and actual Adjusted Close prices is about 1.63. For stock prices, this level of error is quite low, depending on the price ranges in your dataset.
	2.	Validation MSE (3.63):
	•	The Mean Squared Error measures the average squared difference between predicted and actual values. A lower MSE indicates fewer large errors, which is crucial in stock price prediction.
	3.	Validation R² (0.9997):
	•	An R² score very close to 1 indicates that the model explains almost all the variance in the validation data. This is a sign of an excellent fit.

# Introducing Ramdon Forest


```python
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score

# Initialize Random Forest Regressor
rf_model = RandomForestRegressor(
    n_estimators=100,  # Number of trees
    max_depth=None,    # Maximum depth of the tree
    random_state=42,   # Ensures reproducibility
    n_jobs=-1          # Use all CPU cores
)

# Train Random Forest on raw training data (no scaling)
rf_model.fit(X_train, y_train)

# Predict on validation set
rf_y_valid_pred = rf_model.predict(X_valid)

# Evaluate Random Forest model
valid_mae = mean_absolute_error(y_valid, rf_y_valid_pred)
valid_mse = mean_squared_error(y_valid, rf_y_valid_pred)
valid_r2 = r2_score(y_valid, rf_y_valid_pred)

print(f"Validation MAE: {valid_mae}")
print(f"Validation MSE: {valid_mse}")
print(f"Validation R2 Score: {valid_r2}")
```

    Validation MAE: 0.8606795877786086
    Validation MSE: 1.540423956395289
    Validation R2 Score: 0.9999139513722802


### Compare results:

| **Metric**         | **Linear Regression** | **Random Forest**   |
|---------------------|-----------------------|---------------------|
| **Validation MAE**  | 1.48                  | **0.877**           |
| **Validation MSE**  | 3.63                  | **1.4973**          |
| **Validation R²**   | 0.99976               | **0.99991**         |

Key Takeaways
1.	Lower MAE and MSE:
Random Forest has substantially reduced the mean absolute and mean squared errors, indicating better prediction accuracy.
2.	Higher R² Score:
The higher R² score indicates that the Random Forest model is explaining more variability in the data.
3.	Handling Complexity:
Random Forest captures non-linear relationships and interactions between features better than Linear Regression, which assumes linear relationships.


```python
validation_data.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 3254 entries, 15185 to 18438
    Data columns (total 31 columns):
     #   Column                       Non-Null Count  Dtype         
    ---  ------                       --------------  -----         
     0   Date                         3254 non-null   datetime64[ns]
     1   Ticker                       3254 non-null   object        
     2   Adj_Close                    3254 non-null   float64       
     3   Close                        3254 non-null   float64       
     4   High                         3254 non-null   float64       
     5   Low                          3254 non-null   float64       
     6   Open                         3254 non-null   float64       
     7   Volume                       3254 non-null   float64       
     8   Ticker_Encoded               3254 non-null   int64         
     9   year                         3254 non-null   int64         
     10  month                        3254 non-null   int64         
     11  day                          3254 non-null   int64         
     12  weekday                      3254 non-null   int64         
     13  is_day_before_a_holiday      3254 non-null   int64         
     14  is_day_after_a_holiday       3254 non-null   int64         
     15  fiscalDateEnding             3254 non-null   datetime64[ns]
     16  reportedDate                 3254 non-null   datetime64[ns]
     17  reportedEPS                  3254 non-null   float64       
     18  estimatedEPS                 3254 non-null   float64       
     19  surprise                     3254 non-null   float64       
     20  surprisePercentage           3254 non-null   float64       
     21  days_after_previous_earning  3254 non-null   int64         
     22  days_to_next_earning         3254 non-null   int64         
     23  ma_5                         3254 non-null   float64       
     24  volatility_5                 3254 non-null   float64       
     25  ma_10                        3254 non-null   float64       
     26  volatility_10                3254 non-null   float64       
     27  ma_20                        3254 non-null   float64       
     28  volatility_20                3254 non-null   float64       
     29  pct_change                   3254 non-null   float64       
     30  high_low_spread              3254 non-null   float64       
    dtypes: datetime64[ns](3), float64(18), int64(9), object(1)
    memory usage: 788.2+ KB



```python
import matplotlib.pyplot as plt

# Use the validation data instead of last 6 months data
graph_data = validation_data.copy()

# Ensure the validation data has no missing values
validation_data = validation_data.dropna()

# Separate features and target from the validation data
X_valid = validation_data.drop(columns=['Adj_Close', 'Date', 'Ticker', 'fiscalDateEnding', 'reportedDate'])
X_valid_scaled = scaler.transform(X_valid)

# Make predictions on the validation set
linear_valid_pred = model.predict(X_valid_scaled)  # Linear Regression predictions
rf_valid_pred = rf_model.predict(X_valid)         # Random Forest predictions (no scaling applied)

# Add predictions to the validation DataFrame
graph_data['Linear_Regression_Pred'] = linear_valid_pred
graph_data['Random_Forest_Pred'] = rf_valid_pred

# Group by ticker
grouped = graph_data.groupby('Ticker')

# Plot for each ticker
for ticker, group in grouped:
    plt.figure(figsize=(12, 6))
    
    # Plot actual prices
    plt.plot(group['Date'], group['Adj_Close'], label='Actual Price', color='blue')
    
    # Plot Linear Regression predictions
    plt.plot(group['Date'], group['Linear_Regression_Pred'], label='Linear Regression Prediction', color='orange')
    
    # Plot Random Forest predictions
    plt.plot(group['Date'], group['Random_Forest_Pred'], label='Random Forest Prediction', color='green')
    
    # Add title and labels
    plt.title(f'Price Predictions for Validation Data - {ticker}')
    plt.xlabel('Date')
    plt.ylabel('Price')
    plt.legend()
    plt.grid()
    plt.show()
```


    
![png](trading_files/trading_45_0.png)
    



    
![png](trading_files/trading_45_1.png)
    



    
![png](trading_files/trading_45_2.png)
    



    
![png](trading_files/trading_45_3.png)
    



    
![png](trading_files/trading_45_4.png)
    



    
![png](trading_files/trading_45_5.png)
    



    
![png](trading_files/trading_45_6.png)
    



    
![png](trading_files/trading_45_7.png)
    



    
![png](trading_files/trading_45_8.png)
    



    
![png](trading_files/trading_45_9.png)
    



    
![png](trading_files/trading_45_10.png)
    



    
![png](trading_files/trading_45_11.png)
    



    
![png](trading_files/trading_45_12.png)
    



```python

import joblib

# Save the trained Random Forest model to a file
joblib.dump(rf_model, 'random_forest_model.pkl')
joblib.dump(model_r, 'linear_regression_model.pkl')

print("Model saved successfully!")
```

    Model saved successfully!



```python
import json

ticker_mapping = dict(zip(final_merged["Ticker"].unique(), final_merged["Ticker_Encoded"].unique()))

# Convert numpy types to native Python types
ticker_mapping = {key: int(value) for key, value in ticker_mapping.items()}

# Save the mapping to a JSON file
import json
with open("ticker_mapping.json", "w") as file:
    json.dump(ticker_mapping, file)

```

# Just Another Manual Test




```python
import pandas as pd
from utils import predict  # Import your data preparation function

# Set up the symbol and date for prediction
today = pd.Timestamp("today").normalize()
future_date = today + pd.Timedelta(days=20)

for symbol in symbols:
    print(predict(symbol, future_date))

```

    [*********************100%***********************]  1 of 1 completed


    Stock Symbol: AAPL
    Date: 2024-12-19 00:00:00
    Close Price: $249.79
    Adjusted Close Price: $249.79


    [*********************100%***********************]  1 of 1 completed
    /Users/luis_cardenas/work/python/machine-learning/Udacity-Capstone-Project/utils.py:46: FutureWarning: Series.fillna with 'method' is deprecated and will raise in a future version. Use obj.ffill() or obj.bfill() instead.
      historical_df[column] = historical_df[column].fillna(method='ffill')
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)
    [*********************100%***********************]  1 of 1 completed


    LEGC: Loaded historical earnings data for AAPL into DataFrame.
    LEGC: Loaded upcoming earnings data for AAPL into DataFrame.
    Index(['Close', 'High', 'Low', 'Open', 'Volume', 'Ticker_Encoded', 'year',
           'month', 'day', 'weekday', 'is_day_before_a_holiday',
           'is_day_after_a_holiday', 'reportedEPS', 'estimatedEPS', 'surprise',
           'surprisePercentage', 'days_after_previous_earning',
           'days_to_next_earning', 'ma_5', 'volatility_5', 'ma_10',
           'volatility_10', 'ma_20', 'volatility_20', 'pct_change',
           'high_low_spread'],
          dtype='object')
    Predicted Adjusted Close for AAPL on 2025-01-08 (Random Forest): 248.0108770751953
    Predicted Adjusted Close for AAPL on 2025-01-08 (Linear Regression): 447.4778658895294
    {'most_recent_data': {'date': Timestamp('2024-12-19 00:00:00'), 'close': 249.7899932861328, 'adj_close': 249.7899932861328}, 'ramdom_forest': 248.0108770751953, 'linear_regression': 447.4778658895294, 'date': datetime.date(2025, 1, 8)}
    Stock Symbol: NET
    Date: 2024-12-19 00:00:00
    Close Price: $108.58
    Adjusted Close Price: $108.58


    [*********************100%***********************]  1 of 1 completed
    /Users/luis_cardenas/work/python/machine-learning/Udacity-Capstone-Project/utils.py:46: FutureWarning: Series.fillna with 'method' is deprecated and will raise in a future version. Use obj.ffill() or obj.bfill() instead.
      historical_df[column] = historical_df[column].fillna(method='ffill')
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)
    [*********************100%***********************]  1 of 1 completed


    LEGC: Loaded historical earnings data for NET into DataFrame.
    LEGC: Loaded upcoming earnings data for NET into DataFrame.
    Index(['Close', 'High', 'Low', 'Open', 'Volume', 'Ticker_Encoded', 'year',
           'month', 'day', 'weekday', 'is_day_before_a_holiday',
           'is_day_after_a_holiday', 'reportedEPS', 'estimatedEPS', 'surprise',
           'surprisePercentage', 'days_after_previous_earning',
           'days_to_next_earning', 'ma_5', 'volatility_5', 'ma_10',
           'volatility_10', 'ma_20', 'volatility_20', 'pct_change',
           'high_low_spread'],
          dtype='object')
    Predicted Adjusted Close for NET on 2025-01-08 (Random Forest): 108.79655632019043
    Predicted Adjusted Close for NET on 2025-01-08 (Linear Regression): 331.55654882279515
    {'most_recent_data': {'date': Timestamp('2024-12-19 00:00:00'), 'close': 108.58000183105469, 'adj_close': 108.58000183105469}, 'ramdom_forest': 108.79655632019043, 'linear_regression': 331.55654882279515, 'date': datetime.date(2025, 1, 8)}
    Stock Symbol: SNOW
    Date: 2024-12-19 00:00:00
    Close Price: $164.21
    Adjusted Close Price: $164.21


    [*********************100%***********************]  1 of 1 completed
    /Users/luis_cardenas/work/python/machine-learning/Udacity-Capstone-Project/utils.py:46: FutureWarning: Series.fillna with 'method' is deprecated and will raise in a future version. Use obj.ffill() or obj.bfill() instead.
      historical_df[column] = historical_df[column].fillna(method='ffill')
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)


    LEGC: Loaded historical earnings data for SNOW into DataFrame.
    LEGC: Loaded upcoming earnings data for SNOW into DataFrame.
    Index(['Close', 'High', 'Low', 'Open', 'Volume', 'Ticker_Encoded', 'year',
           'month', 'day', 'weekday', 'is_day_before_a_holiday',
           'is_day_after_a_holiday', 'reportedEPS', 'estimatedEPS', 'surprise',
           'surprisePercentage', 'days_after_previous_earning',
           'days_to_next_earning', 'ma_5', 'volatility_5', 'ma_10',
           'volatility_10', 'ma_20', 'volatility_20', 'pct_change',
           'high_low_spread'],
          dtype='object')
    Predicted Adjusted Close for SNOW on 2025-01-08 (Random Forest): 159.80297470092773
    Predicted Adjusted Close for SNOW on 2025-01-08 (Linear Regression): 420.49152714971
    {'most_recent_data': {'date': Timestamp('2024-12-19 00:00:00'), 'close': 164.2100067138672, 'adj_close': 164.2100067138672}, 'ramdom_forest': 159.80297470092773, 'linear_regression': 420.49152714971, 'date': datetime.date(2025, 1, 8)}


    [*********************100%***********************]  1 of 1 completed
    [*********************100%***********************]  1 of 1 completed

    Stock Symbol: MSFT
    Date: 2024-12-19 00:00:00
    Close Price: $437.03
    Adjusted Close Price: $437.03


    
    /Users/luis_cardenas/work/python/machine-learning/Udacity-Capstone-Project/utils.py:46: FutureWarning: Series.fillna with 'method' is deprecated and will raise in a future version. Use obj.ffill() or obj.bfill() instead.
      historical_df[column] = historical_df[column].fillna(method='ffill')
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)


    LEGC: Loaded historical earnings data for MSFT into DataFrame.
    LEGC: Loaded upcoming earnings data for MSFT into DataFrame.
    Index(['Close', 'High', 'Low', 'Open', 'Volume', 'Ticker_Encoded', 'year',
           'month', 'day', 'weekday', 'is_day_before_a_holiday',
           'is_day_after_a_holiday', 'reportedEPS', 'estimatedEPS', 'surprise',
           'surprisePercentage', 'days_after_previous_earning',
           'days_to_next_earning', 'ma_5', 'volatility_5', 'ma_10',
           'volatility_10', 'ma_20', 'volatility_20', 'pct_change',
           'high_low_spread'],
          dtype='object')
    Predicted Adjusted Close for MSFT on 2025-01-08 (Random Forest): 437.0191046142578
    Predicted Adjusted Close for MSFT on 2025-01-08 (Linear Regression): 894.9371434963751
    {'most_recent_data': {'date': Timestamp('2024-12-19 00:00:00'), 'close': 437.0299987792969, 'adj_close': 437.0299987792969}, 'ramdom_forest': 437.0191046142578, 'linear_regression': 894.9371434963751, 'date': datetime.date(2025, 1, 8)}


    [*********************100%***********************]  1 of 1 completed
    [*********************100%***********************]  1 of 1 completed
    /Users/luis_cardenas/work/python/machine-learning/Udacity-Capstone-Project/utils.py:46: FutureWarning: Series.fillna with 'method' is deprecated and will raise in a future version. Use obj.ffill() or obj.bfill() instead.
      historical_df[column] = historical_df[column].fillna(method='ffill')
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)


    Stock Symbol: META
    Date: 2024-12-19 00:00:00
    Close Price: $595.57
    Adjusted Close Price: $595.57
    LEGC: Loaded historical earnings data for META into DataFrame.
    LEGC: Loaded upcoming earnings data for META into DataFrame.
    Index(['Close', 'High', 'Low', 'Open', 'Volume', 'Ticker_Encoded', 'year',
           'month', 'day', 'weekday', 'is_day_before_a_holiday',
           'is_day_after_a_holiday', 'reportedEPS', 'estimatedEPS', 'surprise',
           'surprisePercentage', 'days_after_previous_earning',
           'days_to_next_earning', 'ma_5', 'volatility_5', 'ma_10',
           'volatility_10', 'ma_20', 'volatility_20', 'pct_change',
           'high_low_spread'],
          dtype='object')
    Predicted Adjusted Close for META on 2025-01-08 (Random Forest): 603.6886053466797
    Predicted Adjusted Close for META on 2025-01-08 (Linear Regression): 1504.6908480811746
    {'most_recent_data': {'date': Timestamp('2024-12-19 00:00:00'), 'close': 595.5700073242188, 'adj_close': 595.5700073242188}, 'ramdom_forest': 603.6886053466797, 'linear_regression': 1504.6908480811746, 'date': datetime.date(2025, 1, 8)}


    [*********************100%***********************]  1 of 1 completed
    [*********************100%***********************]  1 of 1 completed
    /Users/luis_cardenas/work/python/machine-learning/Udacity-Capstone-Project/utils.py:46: FutureWarning: Series.fillna with 'method' is deprecated and will raise in a future version. Use obj.ffill() or obj.bfill() instead.
      historical_df[column] = historical_df[column].fillna(method='ffill')
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)


    Stock Symbol: TSLA
    Date: 2024-12-19 00:00:00
    Close Price: $436.17
    Adjusted Close Price: $436.17
    LEGC: Loaded historical earnings data for TSLA into DataFrame.
    LEGC: Loaded upcoming earnings data for TSLA into DataFrame.
    Index(['Close', 'High', 'Low', 'Open', 'Volume', 'Ticker_Encoded', 'year',
           'month', 'day', 'weekday', 'is_day_before_a_holiday',
           'is_day_after_a_holiday', 'reportedEPS', 'estimatedEPS', 'surprise',
           'surprisePercentage', 'days_after_previous_earning',
           'days_to_next_earning', 'ma_5', 'volatility_5', 'ma_10',
           'volatility_10', 'ma_20', 'volatility_20', 'pct_change',
           'high_low_spread'],
          dtype='object')
    Predicted Adjusted Close for TSLA on 2025-01-08 (Random Forest): 440.17619354248046
    Predicted Adjusted Close for TSLA on 2025-01-08 (Linear Regression): 2215.448748389264
    {'most_recent_data': {'date': Timestamp('2024-12-19 00:00:00'), 'close': 436.1700134277344, 'adj_close': 436.1700134277344}, 'ramdom_forest': 440.17619354248046, 'linear_regression': 2215.448748389264, 'date': datetime.date(2025, 1, 8)}


    [*********************100%***********************]  1 of 1 completed


    Stock Symbol: DOX
    Date: 2024-12-19 00:00:00
    Close Price: $86.15
    Adjusted Close Price: $86.15


    [*********************100%***********************]  1 of 1 completed
    /Users/luis_cardenas/work/python/machine-learning/Udacity-Capstone-Project/utils.py:46: FutureWarning: Series.fillna with 'method' is deprecated and will raise in a future version. Use obj.ffill() or obj.bfill() instead.
      historical_df[column] = historical_df[column].fillna(method='ffill')
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)


    LEGC: Loaded historical earnings data for DOX into DataFrame.
    LEGC: Loaded upcoming earnings data for DOX into DataFrame.
    Index(['Close', 'High', 'Low', 'Open', 'Volume', 'Ticker_Encoded', 'year',
           'month', 'day', 'weekday', 'is_day_before_a_holiday',
           'is_day_after_a_holiday', 'reportedEPS', 'estimatedEPS', 'surprise',
           'surprisePercentage', 'days_after_previous_earning',
           'days_to_next_earning', 'ma_5', 'volatility_5', 'ma_10',
           'volatility_10', 'ma_20', 'volatility_20', 'pct_change',
           'high_low_spread'],
          dtype='object')
    Predicted Adjusted Close for DOX on 2025-01-08 (Random Forest): 83.62681198120117
    Predicted Adjusted Close for DOX on 2025-01-08 (Linear Regression): 154.22190961200195
    {'most_recent_data': {'date': Timestamp('2024-12-19 00:00:00'), 'close': 86.1500015258789, 'adj_close': 86.1500015258789}, 'ramdom_forest': 83.62681198120117, 'linear_regression': 154.22190961200195, 'date': datetime.date(2025, 1, 8)}


    [*********************100%***********************]  1 of 1 completed
    [*********************100%***********************]  1 of 1 completed
    /Users/luis_cardenas/work/python/machine-learning/Udacity-Capstone-Project/utils.py:46: FutureWarning: Series.fillna with 'method' is deprecated and will raise in a future version. Use obj.ffill() or obj.bfill() instead.
      historical_df[column] = historical_df[column].fillna(method='ffill')
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)


    Stock Symbol: CRM
    Date: 2024-12-19 00:00:00
    Close Price: $336.23
    Adjusted Close Price: $336.23
    LEGC: Loaded historical earnings data for CRM into DataFrame.
    LEGC: Loaded upcoming earnings data for CRM into DataFrame.
    Index(['Close', 'High', 'Low', 'Open', 'Volume', 'Ticker_Encoded', 'year',
           'month', 'day', 'weekday', 'is_day_before_a_holiday',
           'is_day_after_a_holiday', 'reportedEPS', 'estimatedEPS', 'surprise',
           'surprisePercentage', 'days_after_previous_earning',
           'days_to_next_earning', 'ma_5', 'volatility_5', 'ma_10',
           'volatility_10', 'ma_20', 'volatility_20', 'pct_change',
           'high_low_spread'],
          dtype='object')
    Predicted Adjusted Close for CRM on 2025-01-08 (Random Forest): 336.5359790039063
    Predicted Adjusted Close for CRM on 2025-01-08 (Linear Regression): 905.0145637683885
    {'most_recent_data': {'date': Timestamp('2024-12-19 00:00:00'), 'close': 336.2300109863281, 'adj_close': 336.2300109863281}, 'ramdom_forest': 336.5359790039063, 'linear_regression': 905.0145637683885, 'date': datetime.date(2025, 1, 8)}


    [*********************100%***********************]  1 of 1 completed


    Stock Symbol: ADBE
    Date: 2024-12-19 00:00:00
    Close Price: $437.39
    Adjusted Close Price: $437.39


    [*********************100%***********************]  1 of 1 completed
    /Users/luis_cardenas/work/python/machine-learning/Udacity-Capstone-Project/utils.py:46: FutureWarning: Series.fillna with 'method' is deprecated and will raise in a future version. Use obj.ffill() or obj.bfill() instead.
      historical_df[column] = historical_df[column].fillna(method='ffill')
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)


    LEGC: Loaded historical earnings data for ADBE into DataFrame.
    LEGC: Loaded upcoming earnings data for ADBE into DataFrame.
    Index(['Close', 'High', 'Low', 'Open', 'Volume', 'Ticker_Encoded', 'year',
           'month', 'day', 'weekday', 'is_day_before_a_holiday',
           'is_day_after_a_holiday', 'reportedEPS', 'estimatedEPS', 'surprise',
           'surprisePercentage', 'days_after_previous_earning',
           'days_to_next_earning', 'ma_5', 'volatility_5', 'ma_10',
           'volatility_10', 'ma_20', 'volatility_20', 'pct_change',
           'high_low_spread'],
          dtype='object')
    Predicted Adjusted Close for ADBE on 2025-01-08 (Random Forest): 441.422294921875
    Predicted Adjusted Close for ADBE on 2025-01-08 (Linear Regression): 865.4697324546935
    {'most_recent_data': {'date': Timestamp('2024-12-19 00:00:00'), 'close': 437.3900146484375, 'adj_close': 437.3900146484375}, 'ramdom_forest': 441.422294921875, 'linear_regression': 865.4697324546935, 'date': datetime.date(2025, 1, 8)}


    [*********************100%***********************]  1 of 1 completed


    Stock Symbol: F
    Date: 2024-12-19 00:00:00
    Close Price: $9.74
    Adjusted Close Price: $9.74


    [*********************100%***********************]  1 of 1 completed
    /Users/luis_cardenas/work/python/machine-learning/Udacity-Capstone-Project/utils.py:46: FutureWarning: Series.fillna with 'method' is deprecated and will raise in a future version. Use obj.ffill() or obj.bfill() instead.
      historical_df[column] = historical_df[column].fillna(method='ffill')
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)


    LEGC: Loaded historical earnings data for F into DataFrame.
    LEGC: Loaded upcoming earnings data for F into DataFrame.
    Index(['Close', 'High', 'Low', 'Open', 'Volume', 'Ticker_Encoded', 'year',
           'month', 'day', 'weekday', 'is_day_before_a_holiday',
           'is_day_after_a_holiday', 'reportedEPS', 'estimatedEPS', 'surprise',
           'surprisePercentage', 'days_after_previous_earning',
           'days_to_next_earning', 'ma_5', 'volatility_5', 'ma_10',
           'volatility_10', 'ma_20', 'volatility_20', 'pct_change',
           'high_low_spread'],
          dtype='object')
    Predicted Adjusted Close for F on 2025-01-08 (Random Forest): 9.647033424377442
    Predicted Adjusted Close for F on 2025-01-08 (Linear Regression): 19.40489265540546
    {'most_recent_data': {'date': Timestamp('2024-12-19 00:00:00'), 'close': 9.739999771118164, 'adj_close': 9.739999771118164}, 'ramdom_forest': 9.647033424377442, 'linear_regression': 19.40489265540546, 'date': datetime.date(2025, 1, 8)}


    [*********************100%***********************]  1 of 1 completed


    Stock Symbol: T
    Date: 2024-12-19 00:00:00
    Close Price: $22.57
    Adjusted Close Price: $22.57


    [*********************100%***********************]  1 of 1 completed
    /Users/luis_cardenas/work/python/machine-learning/Udacity-Capstone-Project/utils.py:46: FutureWarning: Series.fillna with 'method' is deprecated and will raise in a future version. Use obj.ffill() or obj.bfill() instead.
      historical_df[column] = historical_df[column].fillna(method='ffill')
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)


    LEGC: Loaded historical earnings data for T into DataFrame.
    LEGC: Loaded upcoming earnings data for T into DataFrame.
    Index(['Close', 'High', 'Low', 'Open', 'Volume', 'Ticker_Encoded', 'year',
           'month', 'day', 'weekday', 'is_day_before_a_holiday',
           'is_day_after_a_holiday', 'reportedEPS', 'estimatedEPS', 'surprise',
           'surprisePercentage', 'days_after_previous_earning',
           'days_to_next_earning', 'ma_5', 'volatility_5', 'ma_10',
           'volatility_10', 'ma_20', 'volatility_20', 'pct_change',
           'high_low_spread'],
          dtype='object')
    Predicted Adjusted Close for T on 2025-01-08 (Random Forest): 22.273158140182495
    Predicted Adjusted Close for T on 2025-01-08 (Linear Regression): 41.480773469789156
    {'most_recent_data': {'date': Timestamp('2024-12-19 00:00:00'), 'close': 22.56999969482422, 'adj_close': 22.56999969482422}, 'ramdom_forest': 22.273158140182495, 'linear_regression': 41.480773469789156, 'date': datetime.date(2025, 1, 8)}


    [*********************100%***********************]  1 of 1 completed


    Stock Symbol: VZ
    Date: 2024-12-19 00:00:00
    Close Price: $39.97
    Adjusted Close Price: $39.97


    [*********************100%***********************]  1 of 1 completed
    /Users/luis_cardenas/work/python/machine-learning/Udacity-Capstone-Project/utils.py:46: FutureWarning: Series.fillna with 'method' is deprecated and will raise in a future version. Use obj.ffill() or obj.bfill() instead.
      historical_df[column] = historical_df[column].fillna(method='ffill')
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)


    LEGC: Loaded historical earnings data for VZ into DataFrame.
    LEGC: Loaded upcoming earnings data for VZ into DataFrame.
    Index(['Close', 'High', 'Low', 'Open', 'Volume', 'Ticker_Encoded', 'year',
           'month', 'day', 'weekday', 'is_day_before_a_holiday',
           'is_day_after_a_holiday', 'reportedEPS', 'estimatedEPS', 'surprise',
           'surprisePercentage', 'days_after_previous_earning',
           'days_to_next_earning', 'ma_5', 'volatility_5', 'ma_10',
           'volatility_10', 'ma_20', 'volatility_20', 'pct_change',
           'high_low_spread'],
          dtype='object')
    Predicted Adjusted Close for VZ on 2025-01-08 (Random Forest): 39.800693359375
    Predicted Adjusted Close for VZ on 2025-01-08 (Linear Regression): 68.98032129084292
    {'most_recent_data': {'date': Timestamp('2024-12-19 00:00:00'), 'close': 39.970001220703125, 'adj_close': 39.970001220703125}, 'ramdom_forest': 39.800693359375, 'linear_regression': 68.98032129084292, 'date': datetime.date(2025, 1, 8)}


    [*********************100%***********************]  1 of 1 completed
    [*********************100%***********************]  1 of 1 completed
    /Users/luis_cardenas/work/python/machine-learning/Udacity-Capstone-Project/utils.py:46: FutureWarning: Series.fillna with 'method' is deprecated and will raise in a future version. Use obj.ffill() or obj.bfill() instead.
      historical_df[column] = historical_df[column].fillna(method='ffill')


    Stock Symbol: NVDA
    Date: 2024-12-19 00:00:00
    Close Price: $130.68
    Adjusted Close Price: $130.68
    LEGC: Loaded historical earnings data for NVDA into DataFrame.
    LEGC: Loaded upcoming earnings data for NVDA into DataFrame.
    Index(['Close', 'High', 'Low', 'Open', 'Volume', 'Ticker_Encoded', 'year',
           'month', 'day', 'weekday', 'is_day_before_a_holiday',
           'is_day_after_a_holiday', 'reportedEPS', 'estimatedEPS', 'surprise',
           'surprisePercentage', 'days_after_previous_earning',
           'days_to_next_earning', 'ma_5', 'volatility_5', 'ma_10',
           'volatility_10', 'ma_20', 'volatility_20', 'pct_change',
           'high_low_spread'],
          dtype='object')
    Predicted Adjusted Close for NVDA on 2025-01-08 (Random Forest): 128.32190856933593
    Predicted Adjusted Close for NVDA on 2025-01-08 (Linear Regression): 386.8001973892037
    {'most_recent_data': {'date': Timestamp('2024-12-19 00:00:00'), 'close': 130.67999267578125, 'adj_close': 130.67999267578125}, 'ramdom_forest': 128.32190856933593, 'linear_regression': 386.8001973892037, 'date': datetime.date(2025, 1, 8)}


    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)
    /Users/luis_cardenas/miniforge3/lib/python3.10/site-packages/sklearn/utils/_array_api.py:745: FutureWarning: Calling float on a single element Series is deprecated and will raise a TypeError in the future. Use float(ser.iloc[0]) instead
      array = numpy.asarray(array, order=order, dtype=dtype)


# Save everything to S3



```python

BUCKET = "capstone-stock-predictable-project"
!aws s3 cp random_forest_model.pkl s3://{BUCKET}/random_forest_model.pkl
!aws s3 cp linear_regression_model.pkl s3://{BUCKET}/linear_regression_model.pkl
!aws s3 cp scaler.pkl s3://{BUCKET}/scaler.pkl
!aws s3 cp ticker_mapping.json s3://{BUCKET}/ticker_mapping.json

```

    upload: ./random_forest_model.pkl to s3://capstone-stock-predictable-project/random_forest_model.pkl
    upload: ./linear_regression_model.pkl to s3://capstone-stock-predictable-project/linear_regression_model.pkl
    upload: ./scaler.pkl to s3://capstone-stock-predictable-project/scaler.pkl
    upload: ./ticker_mapping.json to s3://capstone-stock-predictable-project/ticker_mapping.json


# Deployment:
- Currently it's deployed in ECS as a lightweight Flask application
- It's open with no authentication

### Resources used:
```❯ ./create_resources.sh
Checking for existing VPC...
VPC ID: vpc-0d6faf0971ec86cdc
Checking for IAM Execution Role...
Creating IAM Execution Role...
Execution Role created: arn:aws:iam::072298625118:role/stock_predictor_execution_role
Checking for Execution Role Inline Policy...
Attaching inline policy to IAM Execution Role...
Inline policy attached to Execution Role.
Checking for IAM Task Role...
Creating IAM Task Role...
Task Role created: arn:aws:iam::072298625118:role/stock_predictor_task_role
Attaching inline policy to IAM Task Role...
Inline policy attached to Task Role.
Checking for existing Private Subnets...
Private Subnet 1: subnet-0fe65d113e7eb576c
Private Subnet 2: subnet-0d31c67048e4006d5
Checking for existing Public Subnets...
Public Subnet 1: subnet-04d419c18a9e57b2f
Public Subnet 2: subnet-0808db0ef9c245e6f
Setting up Internet Gateway...
Internet Gateway ID: igw-002d910b75e4dfebb
Checking for ALB Security Group...
ALB Security Group ID: sg-07da11b965d90f21a
Checking for ECS Security Group...
ECS Security Group ID: sg-0027e475625ede9fe
Checking for ALB...
ALB does not exist. Creating ALB...
ALB created: arn:aws:elasticloadbalancing:us-east-1:072298625118:loadbalancer/app/flask-app-alb/74d226fb9f0f29d1
Checking for Target Group...
Target Group does not exist. Creating Target Group...
Target Group created: arn:aws:elasticloadbalancing:us-east-1:072298625118:targetgroup/flask-ecs-target-group/cea7d45facce26c3
Checking for Listener...
Creating Listener for ALB...
Listener created: arn:aws:elasticloadbalancing:us-east-1:072298625118:listener/app/flask-app-alb/74d226fb9f0f29d1/8e36e08a4fd3e82a
Checking for ECS Cluster...
ECS Cluster already exists and is ACTIVE.
Registering Task Definition...
Task Definition ARN: arn:aws:ecs:us-east-1:072298625118:task-definition/flask-ecs-task:28
Creating ECS Service...
ECS Service created: arn:aws:ecs:us-east-1:072298625118:service/flask-ecs-cluster/flask-ecs-service
Final Summary:
VPC ID: vpc-0d6faf0971ec86cdc
Subnets: subnet-04d419c18a9e57b2f, subnet-0808db0ef9c245e6f, subnet-0fe65d113e7eb576c, subnet-0d31c67048e4006d5
Internet Gateway ID: igw-002d910b75e4dfebb
Security Groups: ALB=sg-07da11b965d90f21a, ECS=sg-0027e475625ede9fe
ALB ARN: arn:aws:elasticloadbalancing:us-east-1:072298625118:loadbalancer/app/flask-app-alb/74d226fb9f0f29d1
Target Group ARN: arn:aws:elasticloadbalancing:us-east-1:072298625118:targetgroup/flask-ecs-target-group/cea7d45facce26c3
Listener ARN: arn:aws:elasticloadbalancing:us-east-1:072298625118:listener/app/flask-app-alb/74d226fb9f0f29d1/8e36e08a4fd3e82a
ECS Cluster: flask-ecs-cluster
Task Definition ARN: arn:aws:ecs:us-east-1:072298625118:task-definition/flask-ecs-task:28
ECS Service ARN: arn:aws:ecs:us-east-1:072298625118:service/flask-ecs-cluster/flask-ecs-service```
  




```python
# We need to update the model in the flask container everytime we train the models
!curl -X PATCH http://flask-app-alb-1663822479.us-east-1.elb.amazonaws.com/update_models | jq
```

      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
    100    43  100    43    0     0     12      0  0:00:03  0:00:03 --:--:--    12
    [1;37m{
      [0m[34;1m"message"[0m[1;37m: [0m[0;32m"Models updated successfully!"[0m[1;37m
    [1;37m}[0m



```python
import requests
import json

base_url = "http://flask-app-alb-1663822479.us-east-1.elb.amazonaws.com/predict"

for symbol in symbols:
    response = requests.get(f"{base_url}/{symbol}")
    data = response.json()
    print(json.dumps(data, indent=4))
```

    {
        "date": "Fri, 20 Dec 2024 00:00:00 GMT",
        "linear_regression": 416.332,
        "most_recent_data": {
            "adj_close": 249.79,
            "close": 249.79,
            "date": "Thu, 19 Dec 2024 00:00:00 GMT"
        },
        "ramdom_forest": 249.736,
        "symbol": "AAPL"
    }
    {
        "date": "Fri, 20 Dec 2024 00:00:00 GMT",
        "linear_regression": 230.097,
        "most_recent_data": {
            "adj_close": 108.58,
            "close": 108.58,
            "date": "Thu, 19 Dec 2024 00:00:00 GMT"
        },
        "ramdom_forest": 107.951,
        "symbol": "NET"
    }
    {
        "date": "Fri, 20 Dec 2024 00:00:00 GMT",
        "linear_regression": 324.558,
        "most_recent_data": {
            "adj_close": 164.21,
            "close": 164.21,
            "date": "Thu, 19 Dec 2024 00:00:00 GMT"
        },
        "ramdom_forest": 163.296,
        "symbol": "SNOW"
    }
    {
        "date": "Fri, 20 Dec 2024 00:00:00 GMT",
        "linear_regression": 660.755,
        "most_recent_data": {
            "adj_close": 437.03,
            "close": 437.03,
            "date": "Thu, 19 Dec 2024 00:00:00 GMT"
        },
        "ramdom_forest": 436.984,
        "symbol": "MSFT"
    }
    {
        "date": "Fri, 20 Dec 2024 00:00:00 GMT",
        "linear_regression": 1096.475,
        "most_recent_data": {
            "adj_close": 595.57,
            "close": 595.57,
            "date": "Thu, 19 Dec 2024 00:00:00 GMT"
        },
        "ramdom_forest": 600.64,
        "symbol": "META"
    }
    {
        "date": "Fri, 20 Dec 2024 00:00:00 GMT",
        "linear_regression": 1518.574,
        "most_recent_data": {
            "adj_close": 436.17,
            "close": 436.17,
            "date": "Thu, 19 Dec 2024 00:00:00 GMT"
        },
        "ramdom_forest": 436.646,
        "symbol": "TSLA"
    }
    {
        "date": "Fri, 20 Dec 2024 00:00:00 GMT",
        "linear_regression": 163.576,
        "most_recent_data": {
            "adj_close": 86.15,
            "close": 86.15,
            "date": "Thu, 19 Dec 2024 00:00:00 GMT"
        },
        "ramdom_forest": 84.295,
        "symbol": "DOX"
    }
    {
        "date": "Fri, 20 Dec 2024 00:00:00 GMT",
        "linear_regression": 588.446,
        "most_recent_data": {
            "adj_close": 336.23,
            "close": 336.23,
            "date": "Thu, 19 Dec 2024 00:00:00 GMT"
        },
        "ramdom_forest": 335.636,
        "symbol": "CRM"
    }
    {
        "date": "Fri, 20 Dec 2024 00:00:00 GMT",
        "linear_regression": 808.644,
        "most_recent_data": {
            "adj_close": 437.39,
            "close": 437.39,
            "date": "Thu, 19 Dec 2024 00:00:00 GMT"
        },
        "ramdom_forest": 437.236,
        "symbol": "ADBE"
    }
    {
        "date": "Fri, 20 Dec 2024 00:00:00 GMT",
        "linear_regression": 36.732,
        "most_recent_data": {
            "adj_close": 9.74,
            "close": 9.74,
            "date": "Thu, 19 Dec 2024 00:00:00 GMT"
        },
        "ramdom_forest": 9.924,
        "symbol": "F"
    }
    {
        "date": "Fri, 20 Dec 2024 00:00:00 GMT",
        "linear_regression": 47.272,
        "most_recent_data": {
            "adj_close": 22.57,
            "close": 22.57,
            "date": "Thu, 19 Dec 2024 00:00:00 GMT"
        },
        "ramdom_forest": 22.351,
        "symbol": "T"
    }
    {
        "date": "Fri, 20 Dec 2024 00:00:00 GMT",
        "linear_regression": 64.174,
        "most_recent_data": {
            "adj_close": 39.97,
            "close": 39.97,
            "date": "Thu, 19 Dec 2024 00:00:00 GMT"
        },
        "ramdom_forest": 39.09,
        "symbol": "VZ"
    }
    {
        "date": "Fri, 20 Dec 2024 00:00:00 GMT",
        "linear_regression": 288.954,
        "most_recent_data": {
            "adj_close": 130.68,
            "close": 130.68,
            "date": "Thu, 19 Dec 2024 00:00:00 GMT"
        },
        "ramdom_forest": 129.371,
        "symbol": "NVDA"
    }

