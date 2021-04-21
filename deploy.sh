docker build -t vnuserx/multi-client:latest -t vnuserx/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vnuserx/multi-server:latest -t vnuserx/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vnuserx/multi-worker:latest -t vnuserx/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push vnuserx/multi-client:latest
docker push vnuserx/multi-server:latest
docker push vnuserx/multi-worker:latest
docker push vnuserx/multi-client:$SHA
docker push vnuserx/multi-server:$SHA
docker push vnuserx/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vnuserx/multi-server:$SHA
kubectl set image deployments/client-deployment client=vnuserx/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vnuserx/multi-worker:$SHA
