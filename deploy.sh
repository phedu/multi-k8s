docker build -t pawhermansen/multi-client:latest -t pawhermansen/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pawhermansen/multi-server:latest -t pawhermansen/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pawhermansen/multi-worker:latest -t pawhermansen/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pawhermansen/multi-client:latest
docker push pawhermansen/multi-server:latest
docker push pawhermansen/multi-worker:latest
docker push pawhermansen/multi-client:$SHA
docker push pawhermansen/multi-server:$SHA
docker push pawhermansen/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=pawhermansen/multi-client:$SHA
kubectl set image deployments/server-deployment server=pawhermansen/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=pawhermansen/multi-worker:$SHA
