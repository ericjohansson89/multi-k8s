docker build -t ericsojohansson/multi-client:latest -t ericsojohansson/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ericsojohansson/multi-server:latest -t ericsojohansson/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ericsojohansson/multi-worker:latest -t ericsojohansson/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ericsojohansson/multi-client:lastest
docker push ericsojohansson/multi-server:latest
docker push ericsojohansson/multi-worker:latest
docker push ericsojohansson/multi-client:$SHA
docker push ericsojohansson/multi-server:$SHA
docker push ericsojohansson/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ericsojohansson/multi-server:$SHA
kubectl set image deployments/client-deployment server=ericsojohansson/multi-client:$SHA
kubectl set image deployments/worker-deployment server=ericsojohansson/multi-worker:$SHA