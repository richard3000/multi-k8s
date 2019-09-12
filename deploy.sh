docker build -t richard3000/multi-client:latest -t richard3000/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t richard3000/multi-server:latest -t richard3000/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t richard3000/multi-worker:latest -t richard3000/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push richard3000/multi-client:latest
docker push richard3000/multi-server:latest
docker push richard3000/multi-worker:latest

docker push richard3000/multi-client:$SHA
docker push richard3000/multi-server:$SHA
docker push richard3000/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=richard3000/multi-server:$SHA
kubectl set image deployments/client-deployment client=richard3000/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=richard3000/multi-worker:$SHA