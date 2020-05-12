docker build -t mikkii/multi-client:latest -t mikkii/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mikkii/multi-server:latest -t mikkii/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mikkii/multi-worker:latest -t mikkii/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mikkii/multi-client:latest
docker push mikkii/multi-server:latest
docker push mikkii/multi-worker:latest

docker push mikkii/multi-client:$SHA
docker push mikkii/multi-server:$SHA
docker push mikkii/multi-worker:$SHA

kubectl apply ./k8s
kubectl set image deployments/server-deployment server=mikkii/multi-server:$SHA
kubectl set image deployments/client-deployment client=mikkii/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mikkii/multi-worker:$SHA
