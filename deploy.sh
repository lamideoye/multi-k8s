docker build -t mideg3/multi-client:latest -t mideg3/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mideg3/multi-server:latest -t mideg3/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mideg3/multi-worker:latest -t mideg3/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mideg3/multi-client:latest
docker push mideg3/multi-server:latest
docker push mideg3/multi-worker:latest

docker push mideg3/multi-client:$SHA
docker push mideg3/multi-server:$SHA
docker push mideg3/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mideg3/multi-server:$SHA
kubectl set image deployments/client-deployment client=mideg3/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mideg3/multi-worker:$SHA