### running the server locally

```
cd api
pipenv run uvicorn lambda_function:app --reload
```
ctrl +  to stop the server


### using curl to test
```
curl http://127.0.0.1:8000
curl -v -X GET  http://127.0.0.1:8000/items/
```